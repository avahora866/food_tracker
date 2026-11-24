import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers.dart';
import 'common.dart';

/// Ingredient manager. With [pick], tapping an ingredient returns it.
class IngredientsScreen extends ConsumerStatefulWidget {
  const IngredientsScreen({super.key, this.pick = false});

  final bool pick;

  @override
  ConsumerState<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends ConsumerState<IngredientsScreen> {
  String _query = '';

  Future<void> _edit([Ingredient? ing]) async {
    final c = await showDialog<IngredientsCompanion>(
      context: context,
      builder: (_) => _IngredientDialog(initial: ing),
    );
    if (c != null) await ref.read(databaseProvider).saveIngredient(c);
  }

  @override
  Widget build(BuildContext context) {
    final q = _query.toLowerCase();
    final items = (ref.watch(ingredientsProvider).value ?? [])
        .where((i) => i.name.toLowerCase().contains(q))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pick ? 'Pick ingredient' : 'Ingredients'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New ingredient',
        onPressed: _edit,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              autofocus: widget.pick,
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                isDense: true,
              ),
              onChanged: (s) => setState(() => _query = s),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 80),
              children: [
                for (final i in items)
                  ListTile(
                    title: Text(i.name),
                    subtitle: Text(
                      '${formatAmount(i.refKcal)} kcal · ${formatAmount(i.refProtein)} g protein'
                      ' per ${formatAmount(i.refAmount)} ${i.unit.name}',
                      style: mutedStyle(context),
                    ),
                    onTap: () =>
                        widget.pick ? Navigator.pop(context, i) : _edit(i),
                    trailing: PopupMenuButton<String>(
                      onSelected: (a) => a == 'edit'
                          ? _edit(i)
                          : ref.read(databaseProvider).archiveIngredient(i.id),
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientDialog extends StatefulWidget {
  const _IngredientDialog({this.initial});

  final Ingredient? initial;

  @override
  State<_IngredientDialog> createState() => _IngredientDialogState();
}

class _IngredientDialogState extends State<_IngredientDialog> {
  late final _name = TextEditingController(text: widget.initial?.name);
  late Unit _unit = widget.initial?.unit ?? Unit.g;
  late final _ref = TextEditingController(
    text: formatAmount(widget.initial?.refAmount ?? _unit.defaultRefAmount),
  );
  late final _kcal = TextEditingController(
    text: widget.initial == null ? '' : formatAmount(widget.initial!.refKcal),
  );
  late final _protein = TextEditingController(
    text: widget.initial == null
        ? ''
        : formatAmount(widget.initial!.refProtein),
  );

  void _submit() {
    final name = _name.text.trim();
    final ref = parseAmount(_ref.text);
    final kcal = parseAmount(_kcal.text);
    final protein = _protein.text.trim().isEmpty
        ? 0.0
        : parseAmount(_protein.text);
    if (name.isEmpty ||
        ref == null ||
        ref == 0 ||
        kcal == null ||
        protein == null) {
      return;
    }
    final id = widget.initial?.id;
    Navigator.pop(
      context,
      IngredientsCompanion(
        id: id == null ? const Value.absent() : Value(id),
        name: Value(name),
        unit: Value(_unit),
        refAmount: Value(ref),
        refKcal: Value(kcal),
        refProtein: Value(protein),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const numeric = TextInputType.numberWithOptions(decimal: true);
    return AlertDialog(
      title: Text(
        widget.initial == null ? 'New ingredient' : 'Edit ingredient',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _name,
              autofocus: widget.initial == null,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ref,
                    keyboardType: numeric,
                    decoration: const InputDecoration(labelText: 'Per'),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<Unit>(
                  value: _unit,
                  items: [
                    for (final u in Unit.values)
                      DropdownMenuItem(value: u, child: Text(u.name)),
                  ],
                  onChanged: (u) => setState(() {
                    _unit = u!;
                    _ref.text = formatAmount(u.defaultRefAmount);
                  }),
                ),
              ],
            ),
            TextField(
              controller: _kcal,
              keyboardType: numeric,
              decoration: const InputDecoration(labelText: 'kcal'),
            ),
            TextField(
              controller: _protein,
              keyboardType: numeric,
              decoration: const InputDecoration(labelText: 'Protein, g'),
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
