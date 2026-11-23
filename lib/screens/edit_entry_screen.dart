import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers.dart';
import 'common.dart';
import 'ingredients_screen.dart';

/// Edits one day's copy of a meal. Changes save as you type and never touch
/// the saved recipe.
class EditEntryScreen extends ConsumerStatefulWidget {
  const EditEntryScreen({super.key, required this.entryId});

  final int entryId;

  @override
  ConsumerState<EditEntryScreen> createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends ConsumerState<EditEntryScreen> {
  LogEntry? _entry;
  List<LogLine> _lines = [];
  final Map<int, TextEditingController> _amounts = {};

  AppDatabase get _db => ref.read(databaseProvider);

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  void dispose() {
    for (final c in _amounts.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _reload() async {
    final entry = await _db.getEntry(widget.entryId);
    final lines = await _db.entryLines(widget.entryId);
    if (!mounted) return;
    setState(() {
      _entry = entry;
      _lines = lines;
      for (final c in _amounts.values) {
        c.dispose();
      }
      _amounts
        ..clear()
        ..addAll({
          for (final l in lines)
            l.id: TextEditingController(text: formatAmount(l.amount)),
        });
    });
  }

  void _setAmount(LogLine line, double amount) {
    setState(
      () => _lines = [
        for (final l in _lines)
          l.id == line.id ? l.copyWith(amount: amount) : l,
      ],
    );
    _db.updateLineAmount(line.id, amount);
  }

  Future<void> _addIngredient() async {
    final ing = await Navigator.push<Ingredient>(
      context,
      MaterialPageRoute(builder: (_) => const IngredientsScreen(pick: true)),
    );
    if (ing == null) return;
    await _db.addLine(widget.entryId, ing, ing.refAmount);
    await _reload();
  }

  Future<void> _scale() async {
    final s = await promptText(
      context,
      title: 'Servings multiplier',
      initial: '1.5',
      action: 'Scale',
    );
    final f = s == null ? null : parseAmount(s);
    if (f == null || f == 0) return;
    await _db.scaleEntry(widget.entryId, f);
    await _reload();
  }

  Future<void> _saveAsRecipe() async {
    final name = await promptText(
      context,
      title: 'Save as new meal',
      initial: _entry!.name,
    );
    if (name == null) return;
    await _db.saveEntryAsRecipe(widget.entryId, name);
    await _reload();
    if (mounted) showMessage(context, 'Saved "$name" to My meals');
  }

  @override
  Widget build(BuildContext context) {
    final entry = _entry;
    if (entry == null) return const Scaffold();
    final total = _lines.map((l) => l.nutr).sum;

    return Scaffold(
      appBar: AppBar(
        title: Text(entry.name),
        actions: [
          PopupMenuButton<VoidCallback>(
            onSelected: (f) => f(),
            itemBuilder: (_) => [
              PopupMenuItem(value: _scale, child: const Text('Servings ×')),
              PopupMenuItem(
                value: () async {
                  await _db.resetEntryToRecipe(widget.entryId);
                  await _reload();
                },
                enabled: entry.sourceRecipeId != null,
                child: const Text('Reset to recipe'),
              ),
              PopupMenuItem(
                value: _saveAsRecipe,
                child: const Text('Save as recipe'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              total.label,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          for (final line in _lines)
            ListTile(
              title: Text(line.name),
              subtitle: Text(line.nutr.label, style: mutedStyle(context)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AmountField(
                    controller: _amounts[line.id]!,
                    unit: line.unit,
                    onChanged: (v) => _setAmount(line, v),
                  ),
                  IconButton(
                    tooltip: 'Remove',
                    icon: const Icon(Icons.close),
                    onPressed: () async {
                      await _db.deleteLine(line.id);
                      await _reload();
                    },
                  ),
                ],
              ),
            ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add ingredient'),
            onTap: _addIngredient,
          ),
        ],
      ),
    );
  }
}
