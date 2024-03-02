import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class AddEventPage extends StatefulWidget {
  final Function(String, String, String, String,int, String) onSave;
  const AddEventPage({super.key, required this.onSave});

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController teamController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                  controller: nameController,
                  decoration:
                  const InputDecoration(labelText: 'Event Name')),
              const SizedBox(height: 8.0),
              TextField(
                  controller: teamController,
                  decoration:
                  const InputDecoration(labelText: 'Event Team')),
              const SizedBox(height: 8.0),

              TextField(
                controller: detailsController,
                decoration: const InputDecoration(labelText: 'Details'),
              ),
              TextField(
                controller: statusController,
                decoration: const InputDecoration(labelText: 'Status'),
              ),

              TextField(
                controller: participantsController,
                decoration: const InputDecoration(labelText: 'Participants'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_validateForm()) {
                    ProgressDialog pr = ProgressDialog(context);
                    pr.style(message: 'Loading...');

                    await pr.show();

                    await widget.onSave(
                      nameController.text,
                      teamController.text,
                      detailsController.text,
                      statusController.text,
                      int.parse(participantsController.text),
                      typeController.text,
                    );

                    await pr
                        .hide()
                        .then((_) => Navigator.pop(context));
                  }
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    if (nameController.text.isEmpty ||
        typeController.text.isEmpty ||
        teamController.text.isEmpty ||
        detailsController.text.isEmpty ||
        statusController.text.isEmpty ||
        participantsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return false;
    }
    return true;
  }
}