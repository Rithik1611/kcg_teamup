import 'package:flutter/material.dart';
import 'package:kcg_teamup/view/pages/home.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _courseLinkController = TextEditingController();
  final _aboutController =
      TextEditingController(); // New controller for 'about'
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _courseLinkController.dispose();
    _aboutController.dispose(); // Dispose the new 'about' controller
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('CONFIRM'),
          content: const Text(
              'This will post the Event to the Students. Are you Sure?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newCategory = Category(
                    title: _titleController.text,
                    courseLink: _courseLinkController.text,
                    date: _selectedDate,
                    // Optionally use 'about' field if needed
                  );
                  setState(() {
                    Category.popularCourseList.add(newCategory);
                  });
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(true); // Return to previous screen
                }
              },
              child: const Text('POST'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Event'),
        backgroundColor: const Color.fromARGB(255, 93, 93, 93),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Name of the Event';
                  }
                  return null;
                },
                maxLength: 30, // Limit the length to 30 characters
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Event Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Type of the Event';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _courseLinkController,
                decoration: const InputDecoration(labelText: 'Event Link'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the event link';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _aboutController,
                decoration: const InputDecoration(labelText: 'Description'),
                // Optional field, no validation required
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Date of the Event';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month_rounded),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                controller: TextEditingController(
                  text: _selectedDate == null
                      ? ''
                      : '${_selectedDate!.toLocal()}'.split(' ')[0],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showConfirmationDialog,
                child: const Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
