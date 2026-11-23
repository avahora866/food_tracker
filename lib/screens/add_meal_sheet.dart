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
  List<RecipeSummary> _sorted(List<RecipeSummary> all) {
    final q = _query.toLowerCase();
    int slotRank(Recipe r) => r.defaultSlot == widget.slot ? 0 : 1;
    return all.where((s) => s.recipe.name.toLowerCase().contains(q)).toList()
      ..sort((a, b) {
        final ra = a.recipe, rb = b.recipe;
        final bySlot = slotRank(ra).compareTo(slotRank(rb));
        if (bySlot != 0) return bySlot;
        final ta = ra.lastUsedAt, tb = rb.lastUsedAt;
        if (ta != tb) {
          if (ta == null) return 1;
          if (tb == null) return -1;
          return tb.compareTo(ta);
        }
        return ra.name.toLowerCase().compareTo(rb.name.toLowerCase());
      });
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final recipes = _sorted(ref.watch(recipesProvider).value ?? []);

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
              for (final s in recipes)
                ListTile(
                  title: Text(s.recipe.name),
                  trailing: Text(
                    '${s.total.kcal.round()} kcal',
                    style: mutedStyle(context),
                  ),
                  onTap: () async {
                    final nav = Navigator.of(context);
                    await db.addRecipeToDay(
                      s.recipe.id,
                      widget.day,
                      widget.slot,
                    );
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
