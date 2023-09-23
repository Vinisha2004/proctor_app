import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Complaint {
  String title;
  String description;

  Complaint(this.title, this.description);
}

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({super.key});
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'raise your complaint'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Complaint complaint = Complaint(
                    _titleController.text,
                    _descriptionController.text,
                  );

                  // TODO: Send the complaint to your backend or perform necessary actions

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Complaint Submitted'),
                        content: Text('Thank you for your feedback!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Submit Complaint'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Complaint App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('complains and feedback'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ComplaintForm(),
        ),
      ),
    );
  }
}
