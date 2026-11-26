import 'package:flutter/material.dart';

import 'weight_entry.dart';
import 'weight_repository.dart';

/// Screen for logging and reviewing weight measurements.
class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key, required this.repository, this.onChanged});

  final WeightRepository repository;

  /// Called with the full list after an entry is added or deleted, so
  /// reminders can be rescheduled.
  final void Function(List<WeightEntry> entries)? onChanged;

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  List<WeightEntry>? _entries;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload({bool notify = false}) async {
    final entries = await widget.repository.load();
    if (!mounted) return;
    setState(() => _entries = entries);
    if (notify) widget.onChanged?.call(entries);
  }

  Future<void> _addEntry() async {
    final result = await showDialog<(double, DateTime)>(
      context: context,
      builder: (_) => const _AddWeightDialog(),
    );
    if (result == null) return;
    final (kg, date) = result;
    await widget.repository.add(
      WeightEntry(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        date: date,
        kg: kg,
      ),
    );
    await _reload(notify: true);
  }

  Future<void> _delete(WeightEntry entry) async {
    await widget.repository.delete(entry.id);
    await _reload(notify: true);
  }

  @override
  Widget build(BuildContext context) {
    final entries = _entries;
    final loc = MaterialLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('Weight'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addEntry,
        icon: const Icon(Icons.add),
        label: const Text('Log weight'),
      ),
      body: entries == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                if (!hasMeasurementForMonth(entries, DateTime.now()))
                  Card(
                    margin: const EdgeInsets.all(16),
                    color: theme.colorScheme.secondaryContainer,
                    child: ListTile(
                      leading: const Icon(Icons.notifications_active),
                      title: Text(
                        'No weigh-in yet for '
                        '${loc.formatMonthYear(DateTime.now())}',
                      ),
                      subtitle: const Text(
                        "You'll get a daily reminder until you log one.",
                      ),
                    ),
                  ),
                if (entries.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: Text('No measurements yet.')),
                  ),
                for (final (i, e) in entries.indexed)
                  Dismissible(
                    key: ValueKey(e.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: theme.colorScheme.errorContainer,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: const Icon(Icons.delete),
                    ),
                    onDismissed: (_) => _delete(e),
                    child: ListTile(
                      title: Text('${_fmt(e.kg)} kg'),
                      subtitle: Text(loc.formatMediumDate(e.date)),
                      trailing: i + 1 < entries.length
                          ? _Delta(e.kg - entries[i + 1].kg)
                          : null,
                    ),
                  ),
              ],
            ),
    );
  }
}

String _fmt(double v) => v.toStringAsFixed(1);

class _Delta extends StatelessWidget {
  const _Delta(this.diff);
  final double diff;

  @override
  Widget build(BuildContext context) {
    final rounded = double.parse(diff.toStringAsFixed(1));
    final sign = rounded > 0 ? '+' : '';
    return Text(
      '$sign${_fmt(rounded)} kg',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class _AddWeightDialog extends StatefulWidget {
  const _AddWeightDialog();

  @override
  State<_AddWeightDialog> createState() => _AddWeightDialogState();
}

class _AddWeightDialogState extends State<_AddWeightDialog> {
  final _controller = TextEditingController();
  DateTime _date = DateUtils.dateOnly(DateTime.now());
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    final value = double.tryParse(_controller.text.trim().replaceAll(',', '.'));
    if (value == null || value <= 0) {
      setState(() => _error = 'Enter a valid weight');
      return;
    }
    Navigator.of(context).pop((value, _date));
  }

  @override
  Widget build(BuildContext context) {
    final loc = MaterialLocalizations.of(context);
    return AlertDialog(
      title: const Text('Log weight'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Weight',
              suffixText: 'kg',
              errorText: _error,
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today),
            title: Text(loc.formatMediumDate(_date)),
            onTap: _pickDate,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
