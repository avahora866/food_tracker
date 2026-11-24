import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/database.dart';
import '../providers.dart';
import 'add_meal_sheet.dart';
import 'common.dart';
import 'edit_entry_screen.dart';
import 'meals_screen.dart';

/// Home: one page per logical day, swipe or use the arrows to move.
class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  static const _todayPage = 100000;
  final _pages = PageController(initialPage: _todayPage);
  final _today = logicalDay(DateTime.now());
  int _page = _todayPage;

  DateTime _dayAt(int page) =>
      DateTime(_today.year, _today.month, _today.day + page - _todayPage);

  String _title(int page) => switch (page - _todayPage) {
    0 => 'Today',
    -1 => 'Yesterday',
    1 => 'Tomorrow',
    _ => DateFormat('EEE d MMM').format(_dayAt(page)),
  };

  void _go(int delta) => _pages.animateToPage(
    _page + delta,
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeOut,
  );

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _go(_todayPage - _page),
          child: Text(_title(_page)),
        ),
        actions: [
          IconButton(
            tooltip: 'Previous day',
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _go(-1),
          ),
          IconButton(
            tooltip: 'Next day',
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _go(1),
          ),
          IconButton(
            tooltip: 'My meals',
            icon: const Icon(Icons.menu_book_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MealsScreen()),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pages,
        onPageChanged: (p) => setState(() => _page = p),
        itemBuilder: (_, page) => DayView(day: dayKey(_dayAt(page))),
      ),
    );
  }
}

class DayView extends ConsumerWidget {
  const DayView({super.key, required this.day});

  final String day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(dayProvider(day)).value;
    if (entries == null) return const SizedBox.shrink();
    final total = entries.map((e) => e.total).sum;
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${total.kcal.round()}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const Text(' kcal'),
              const Spacer(),
              Text('${total.protein.round()} g protein'),
            ],
          ),
        ),
        for (final slot in Slot.values)
          _SlotSection(
            day: day,
            slot: slot,
            entries: entries.where((e) => e.entry.slot == slot).toList(),
          ),
      ],
    );
  }
}

class _SlotSection extends ConsumerWidget {
  const _SlotSection({
    required this.day,
    required this.slot,
    required this.entries,
  });

  final String day;
  final Slot slot;
  final List<EntryView> entries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void add() => showAddMealSheet(context, day: day, slot: slot);
    final subtotal = entries.map((e) => e.total).sum;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 1),
        InkWell(
          onTap: add,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text(slot.label, style: Theme.of(context).textTheme.titleSmall),
                const Spacer(),
                if (entries.isNotEmpty)
                  Text(subtotal.label, style: mutedStyle(context)),
                IconButton(
                  tooltip: 'Add to ${slot.label}',
                  icon: const Icon(Icons.add),
                  onPressed: add,
                ),
              ],
            ),
          ),
        ),
        for (final e in entries) _EntryTile(view: e),
        if (entries.isEmpty)
          InkWell(onTap: add, child: const SizedBox(height: 24)),
      ],
    );
  }
}

class _EntryTile extends ConsumerWidget {
  const _EntryTile({required this.view});

  final EntryView view;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = view.entry;
    return Dismissible(
      key: ValueKey(e.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline),
      ),
      onDismissed: (_) async {
        final db = ref.read(databaseProvider);
        final messenger = ScaffoldMessenger.of(context);
        final deleted = await db.deleteEntry(e.id);
        messenger
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text('Deleted ${e.name}'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () => db.restoreEntry(deleted),
              ),
            ),
          );
      },
      child: ListTile(
        dense: true,
        title: Text(e.name),
        subtitle: view.edited
            ? Text('edited', style: mutedStyle(context))
            : null,
        trailing: Text(view.total.label),
        onTap: () async {
          if (view.isQuick) {
            final v = await showQuickAddDialog(context, initial: e);
            if (v != null) {
              await ref
                  .read(databaseProvider)
                  .updateQuick(
                    e.id,
                    name: v.name,
                    kcal: v.kcal,
                    protein: v.protein,
                  );
            }
          } else {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EditEntryScreen(entryId: e.id)),
            );
          }
        },
      ),
    );
  }
}
