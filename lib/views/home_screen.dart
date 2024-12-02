import 'package:database_sqlite_notes_app/Database/sqlite.dart';
import 'package:database_sqlite_notes_app/models/note_models.dart';
import 'package:database_sqlite_notes_app/views/create_notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Note>> noteList;

  final DateFormat dateFormatter = DateFormat("MMM,dd,yyyy");

  SqLiteHelper sqLiteHelper = SqLiteHelper.instance;

  @override
  void initState() {
    super.initState();
    _updateNoteList();
  }

  _updateNoteList() {
    noteList = SqLiteHelper.instance.getNote();
  }

  Widget buildNote(Note note) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              note.tittle!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  decoration: note.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
            ),
            subtitle:
                Text('${dateFormatter.format(note.date!)} - ${note.priority}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      decoration: note.status == 0
                          ? TextDecoration.none
                          : TextDecoration.lineThrough,
                    )),
            trailing: Checkbox(
              onChanged: (value) {
                note.status = value! ? 1 : 0;
                SqLiteHelper.instance.updateNote(note);
                _updateNoteList();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
              activeColor: Theme.of(context).primaryColor,
              value: note.status == 0 ? true : false,
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreateNotesScreen(
                    //!  UpdateNoteList: _updateNoteList(),
                    //  note:note,
                    ))),
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
        body: FutureBuilder(
            future: noteList,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final int completeNoteCount = snapshot.data!
                  .where((Note note) => note.status == 1)
                  .toList()
                  .length;
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  itemCount: int.parse(snapshot.data!.length.toString()) + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "My Notes",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            Text(
                              '$completeNoteCount of ${snapshot.data.length}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return buildNote(snapshot.data![index - 1]);
                  });
            }));
  }
}
