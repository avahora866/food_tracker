import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'common.dart';
import 'ingredients_screen.dart';
import 'recipe_editor_screen.dart';

/// The recipe library.
class MealsScreen extends ConsumerWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(databaseProvider);
    final recipes = [...ref.watch(recipesProvider).value ?? []]
      ..sort(
        (a, b) =>
            a.recipe.name.toLowerCase().compareTo(b.recipe.name.toLowerCase()),
      );

    void open([int? id]) => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RecipeEditorScreen(recipeId: id)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My meals'),
        actions: [
          IconButton(
            tooltip: 'Ingredients',
            icon: const Icon(Icons.egg_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const IngredientsScreen()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New meal',
        onPressed: open,
        child: const Icon(Icons.add),
      ),
      body: recipes.isEmpty
          ? Center(child: Text('No meals yet', style: mutedStyle(context)))
          : ListView(
              children: [
                for (final s in recipes)
                  ListTile(
                    title: Text(s.recipe.name),
                    subtitle: Text(s.total.label, style: mutedStyle(context)),
                    onTap: () => open(s.recipe.id),
                    trailing: PopupMenuButton<String>(
                      onSelected: (action) => action == 'duplicate'
                          ? db.duplicateRecipe(s.recipe.id)
                          : db.deleteRecipe(s.recipe.id),
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: 'duplicate',
                          child: Text('Duplicate'),
                        ),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
