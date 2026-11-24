import 'package:flutter/material.dart';

import '../data/database.dart';

TextStyle? mutedStyle(BuildContext context) => Theme.of(context)
    .textTheme
    .bodySmall
    ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

void showMessage(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

/// Amount field that accepts fractions ("1/3") as well as decimals.
class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.controller,
    required this.unit,
    this.onChanged,
  });

  final TextEditingController controller;
  final Unit unit;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 96,
    child: TextField(
      controller: controller,
      textAlign: TextAlign.end,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(isDense: true, suffixText: unit.name),
      onChanged: (s) {
        final v = parseAmount(s);
        if (v != null) onChanged?.call(v);
      },
    ),
  );
}

/// Asks for a single line of text. Returns null if cancelled or empty.
Future<String?> promptText(
  BuildContext context, {
  required String title,
  String initial = '',
  String action = 'Save',
}) {
  final c = TextEditingController(text: initial);
  return showDialog<String>(
    context: context,
    builder: (ctx) {
      void submit() {
        final v = c.text.trim();
        if (v.isNotEmpty) Navigator.pop(ctx, v);
      }

      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: c,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (_) => submit(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(onPressed: submit, child: Text(action)),
        ],
      );
    },
  );
}

typedef QuickValues = ({String name, double kcal, double? protein});

/// Name, kcal and optional protein for a one-off entry.
Future<QuickValues?> showQuickAddDialog(
  BuildContext context, {
  LogEntry? initial,
}) {
  final name = TextEditingController(text: initial?.name ?? '');
  final kcal = TextEditingController(
    text: initial?.quickKcal == null ? '' : formatAmount(initial!.quickKcal!),
  );
  final protein = TextEditingController(
    text: initial?.quickProtein == null
        ? ''
        : formatAmount(initial!.quickProtein!),
  );
  const numeric = TextInputType.numberWithOptions(decimal: true);

  return showDialog<QuickValues>(
    context: context,
    builder: (ctx) {
      void submit() {
        final n = name.text.trim();
        final k = parseAmount(kcal.text);
        final p = protein.text.trim().isEmpty
            ? null
            : parseAmount(protein.text);
        if (n.isEmpty || k == null) return;
        Navigator.pop(ctx, (name: n, kcal: k, protein: p));
      }

      return AlertDialog(
        title: Text(initial == null ? 'Quick add' : 'Edit quick add'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              autofocus: initial == null,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: kcal,
              keyboardType: numeric,
              decoration: const InputDecoration(labelText: 'kcal'),
            ),
            TextField(
              controller: protein,
              keyboardType: numeric,
              decoration: const InputDecoration(
                labelText: 'Protein, g (optional)',
              ),
              onSubmitted: (_) => submit(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(onPressed: submit, child: const Text('Save')),
        ],
      );
    },
  );
}
