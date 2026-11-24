import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers.dart';
import 'common.dart';
import 'recipe_editor_screen.dart';

Future<void> showAddMealSheet(
  BuildContext context, {
  required String day,
  required Slot slot,
}) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  showDragHandle: true,
  builder: (_) => FractionallySizedBox(
    heightFactor: 0.85,
    child: _AddMealSheet(day: day, slot: slot),
  ),
);

class _AddMealSheet extends ConsumerStatefulWidget {
  const _AddMealSheet({required this.day, required this.slot});

  final String day;
  final Slot slot;

  @override
  ConsumerState<_AddMealSheet> createState() => _AddMealSheetState();
}

class _AddMealSheetState extends ConsumerState<_AddMealSheet> {
  String _query = '';

  /// This slot's meals first, then most recently used, then by name.
  List<_Pickable> _sorted(List<_Pickable> all) {
    final q = _query.toLowerCase();
    return all.where((p) => p.name.toLowerCase().contains(q)).toList()
      ..sort((a, b) {
        final bySlot = a.slotRank.compareTo(b.slotRank);
        if (bySlot != 0) return bySlot;
        final ta = a.lastUsedAt, tb = b.lastUsedAt;
        if (ta != tb) {
          if (ta == null) return 1;
          if (tb == null) return -1;
          return tb.compareTo(ta);
        }
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final items = _sorted([
      for (final r in ref.watch(recipesProvider).value ?? <RecipeSummary>[])
        _Pickable(
          name: r.recipe.name,
          kcal: r.total.kcal,
          lastUsedAt: r.recipe.lastUsedAt,
          slotRank: r.recipe.defaultSlot == widget.slot ? 0 : 1,
          add: () => db.addRecipeToDay(r.recipe.id, widget.day, widget.slot),
        ),
      for (final i in ref.watch(ingredientsProvider).value ?? <Ingredient>[])
        if (i.loggableAlone)
          _Pickable(
            name: i.name,
            unit: i.unit,
            kcal: i.nutrFor(1).kcal,
            lastUsedAt: i.lastUsedAt,
            slotRank: 1,
            add: () => db.addIngredientToDay(i.id, widget.day, widget.slot),
          ),
    ]);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Add to ${widget.slot.label}',
              prefixIcon: const Icon(Icons.search),
              isDense: true,
            ),
            onChanged: (s) => setState(() => _query = s),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.bolt_outlined),
          title: const Text('Quick add'),
          onTap: () async {
            final nav = Navigator.of(context);
            final v = await showQuickAddDialog(context);
            if (v == null) return;
            await db.addQuick(
              widget.day,
              widget.slot,
              name: v.name,
              kcal: v.kcal,
              protein: v.protein,
            );
            nav.pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('New meal'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecipeEditorScreen(defaultSlot: widget.slot),
            ),
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView(
            children: [
              for (final p in items)
                ListTile(
                  title: Text(p.name),
                  subtitle: p.unit == null
                      ? null
                      : Text('1 ${p.unit!.name}', style: mutedStyle(context)),
                  trailing: Text(
                    '${p.kcal.round()} kcal',
                    style: mutedStyle(context),
                  ),
                  onTap: () async {
                    final nav = Navigator.of(context);
                    await p.add();
                    nav.pop();
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A row in the picker: a saved meal, or a piece/cup ingredient logged alone.
class _Pickable {
  _Pickable({
    required this.name,
    required this.kcal,
    required this.lastUsedAt,
    required this.slotRank,
    required this.add,
    this.unit,
  });

  final String name;
  final double kcal;
  final DateTime? lastUsedAt;
  final int slotRank;
  final Future<void> Function() add;

  /// Set for ingredients only.
  final Unit? unit;
}
