import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers.dart';
import 'common.dart';
import 'ingredients_screen.dart';

class _Line {
  _Line(this.ingredient, double amount)
    : amount = amount,
      controller = TextEditingController(text: formatAmount(amount));

  final Ingredient ingredient;
  double amount;
  final TextEditingController controller;
}

/// Create or edit a saved meal. Saving never changes existing log entries.
class RecipeEditorScreen extends ConsumerStatefulWidget {
  const RecipeEditorScreen({super.key, this.recipeId, this.defaultSlot});

  final int? recipeId;
  final Slot? defaultSlot;

  @override
  ConsumerState<RecipeEditorScreen> createState() => _RecipeEditorState();
}

class _RecipeEditorState extends ConsumerState<RecipeEditorScreen> {
  final _name = TextEditingController();
  Slot? _slot;
  final List<_Line> _lines = [];
  bool _loaded = false;

  AppDatabase get _db => ref.read(databaseProvider);

  @override
  void initState() {
    super.initState();
    _slot = widget.defaultSlot;
    _load();
  }

  Future<void> _load() async {
    final id = widget.recipeId;
    if (id != null) {
      final r = await _db.getRecipe(id);
      final items = await _db.recipeItems(id);
      _name.text = r.name;
      _slot = r.defaultSlot;
      _lines.addAll([for (final i in items) _Line(i.ingredient, i.amount)]);
    }
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _name.dispose();
    for (final l in _lines) {
      l.controller.dispose();
    }
    super.dispose();
  }

  Future<void> _addIngredient() async {
    final ing = await Navigator.push<Ingredient>(
      context,
      MaterialPageRoute(builder: (_) => const IngredientsScreen(pick: true)),
    );
    if (ing != null) setState(() => _lines.add(_Line(ing, ing.refAmount)));
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return showMessage(context, 'Give the meal a name');
    if (_lines.any((l) => parseAmount(l.controller.text) == null)) {
      return showMessage(context, 'Check the amounts');
    }
    final nav = Navigator.of(context);
    await _db.saveRecipe(
      id: widget.recipeId,
      name: name,
      defaultSlot: _slot,
      lines: [for (final l in _lines) (l.ingredient.id, l.amount)],
    );
    nav.pop();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return const Scaffold();
    final total = _lines.map((l) => l.ingredient.nutrFor(l.amount)).sum;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeId == null ? 'New meal' : 'Edit meal'),
        actions: [
          IconButton(
            tooltip: 'Save',
            icon: const Icon(Icons.check),
            onPressed: _save,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _name,
              autofocus: widget.recipeId == null,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Wrap(
              spacing: 8,
              children: [
                for (final s in Slot.values)
                  ChoiceChip(
                    label: Text(s.label),
                    selected: _slot == s,
                    onSelected: (on) => setState(() => _slot = on ? s : null),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              total.label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          for (final l in _lines)
            ListTile(
              title: Text(l.ingredient.name),
              subtitle: Text(
                l.ingredient.nutrFor(l.amount).label,
                style: mutedStyle(context),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AmountField(
                    controller: l.controller,
                    unit: l.ingredient.unit,
                    onChanged: (v) => setState(() => l.amount = v),
                  ),
                  IconButton(
                    tooltip: 'Remove',
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() => _lines.remove(l)),
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
