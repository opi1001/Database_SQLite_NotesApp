import 'package:database_sqlite_notes_app/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({super.key});
  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String priority = 'Low';
  String tittle = '';
  String btnText = 'add Note';
  String tittleText = 'add Note';
  TextEditingController dateController = TextEditingController();

  final DateFormat dateFormatter = DateFormat('MMM,dd,yyyy');
  final List<String> priorities = [
    'Low',
    'Medium',
    'High',
  ];

  handleDeletePicker() async {
    final DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      dateController.text = dateFormatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 80,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen())),
                    child: Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Add Note",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Form(
                    key: formKey,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20.0),
                          decoration: InputDecoration(
                            labelText: 'Add Note',
                            labelStyle: const TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                        child: TextFormField(
                          readOnly: true,
                          onTap: handleDeletePicker,
                          controller: dateController,
                          style: const TextStyle(fontSize: 20.0),
                          decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle: const TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: DropdownButtonFormField(
                            onChanged: (value) {
                              setState(() {
                                priority = value.toString();
                              });
                            },
                            items: priorities.map((String priority) {
                              return DropdownMenuItem(
                                value: priority,
                                child: Text(
                                  priority,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              );
                            }).toList(),
                            style: const TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                                labelText: 'Priority',
                                labelStyle: const TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          )),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          child: const Text(
                            'Add Note',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ]),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
