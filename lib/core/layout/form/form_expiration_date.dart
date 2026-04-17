import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormExpirationDate extends StatelessWidget {
  final DateTime currentDate;
  final Function setExpirationDate;
  const FormExpirationDate({
    super.key,
    required this.currentDate,
    required this.setExpirationDate,
  });

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );

    if (picked != null && picked != currentDate) {
      setExpirationDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pickDate(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Expiration Date',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        child: Text(
          DateFormat('dd MMMM yyyy').format(currentDate),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
