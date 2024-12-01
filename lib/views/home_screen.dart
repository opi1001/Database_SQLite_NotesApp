import 'package:database_sqlite_notes_app/views/create_notes_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget buildNote(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          ListTile(
            title: const Text("Notes Tittle"),
            subtitle: const Text("Nov 29,  2024 - High"),
            trailing: Checkbox(
              onChanged: (value) {},
              activeColor: Theme.of(context).primaryColor,
              value: true,
            ),
          ),
          const Divider(
            height: 5.0,
            color: Colors.red,
            thickness: 2.8,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateNotesScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          itemCount: 10,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Notes",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Text(
                      "0 - 10",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              );
            }
            return buildNote(index);
          }),
    );
  }
}
