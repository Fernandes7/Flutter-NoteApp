import 'package:crud/data/data.dart';
import 'package:crud/data/notedata/notedata.dart';
import 'package:crud/views/screenaddnotes.dart';
import 'package:flutter/material.dart';

class Screenallnotes extends StatelessWidget {
  const Screenallnotes({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await NoteDB.instance.getAllnote();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Added Notes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 2, 19),
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: NoteDB.instance.noteListNotifier,
        builder: (context, List<Notedata> newNotes, _) {
          if (newNotes.isEmpty) {
            return const Center(
              child: Text("No Notes to Display"),
            );
          }
          return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(8),
              children: List.generate(newNotes.length, (index) {
                final note = NoteDB.instance.noteListNotifier.value[index];
                return Noteitem(
                    id: note.id!, titile: note.title!, content: note.content!);
              }));
        },
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (cxt) => Screenaddnotes(type: Actiontype.addnote)));
        },
        label: const Text("Nex"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class Noteitem extends StatelessWidget {
  final String id;
  final String titile;
  final String content;
  const Noteitem(
      {super.key,
      required this.id,
      required this.titile,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (cxt) =>
                Screenaddnotes(type: Actiontype.editnote, id: id)));
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: const Color.fromARGB(255, 184, 179, 250)),
              color: const Color.fromARGB(255, 206, 227, 255)),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(titile,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                  IconButton(
                    onPressed: () {
                      NoteDB.instance.deletNote(id);
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  )
                ],
              ),
              Text(
                content,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontSize: 14),
              )
            ],
          )),
    );
  }
}
