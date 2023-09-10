import 'package:crud/data/data.dart';
import 'package:crud/data/notedata/notedata.dart';
import 'package:flutter/material.dart';

enum Actiontype { addnote, editnote }

class Screenaddnotes extends StatelessWidget {
  final Actiontype type;
  final String? id;
  Screenaddnotes({super.key, required this.type, this.id});

  Widget get savebutton => TextButton.icon(
      onPressed: () {
        switch (type) {
          case Actiontype.addnote:
            saveNote();
            break;
          case Actiontype.editnote:
            saveEditedNote();
            break;
        }
      },
      icon: const Icon(Icons.save),
      label: const Text("save"));

  final tilecontroller = TextEditingController();
  final contentcontroller = TextEditingController();
  final scaffolkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (type == Actiontype.editnote) {
      if (id == null) {
        Navigator.of(context).pop();
      }
      final note = NoteDB.instance.getNotebyId(id!);
      if (note == null) {
        Navigator.of(context).pop();
      }
      tilecontroller.text = note!.title ?? "No Titile";
      contentcontroller.text = note.content ?? "No Content";
    }
    return Scaffold(
        appBar: AppBar(
          key: scaffolkey,
          title: Text(type.name.toUpperCase()),
          actions: [savebutton],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextFormField(
                  controller: tilecontroller,
                  decoration: const InputDecoration(
                      hintText: "titile", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: contentcontroller,
                  maxLines: 4,
                  maxLength: 100,
                  decoration: const InputDecoration(
                      hintText: "Content", border: OutlineInputBorder()),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> saveNote() async {
    final title = tilecontroller.text;
    final contet = contentcontroller.text;
    final newnote = Notedata.create(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: contet);

    final newNote = await NoteDB.instance.createNote(newnote);
    if (newNote != null) {
      Navigator.of(scaffolkey.currentContext!).pop();
    } else {
      print("look here");
    }
  }

  Future<void> saveEditedNote() async {
    final title = tilecontroller.text;
    final content = contentcontroller.text;

    final editNote = Notedata.create(id: id, title: title, content: content);
    final update = await NoteDB.instance.updateNote(editNote);
    if (update != null) {
      Navigator.of(scaffolkey.currentContext!).pop();
    }
  }
}
