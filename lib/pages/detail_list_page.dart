import 'package:appbooking/db/booking.dart';
import 'package:appbooking/extensions.dart';
import 'package:appbooking/model/book.dart';
import 'package:appbooking/model/note.dart';
import 'package:appbooking/pages/edit_booking_page.dart';
import 'package:flutter/material.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Booking note;
  late List<Note> noteArr;
  bool isLoading = false;
  late String noteText = '';

  @override
  void initState() {
    super.initState();
    noteText = '';
    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);
    noteArr = await BookDatabase.instance.readNotes(widget.noteId);
    // print(noteArr[1].name);
    note = await BookDatabase.instance.readBooking(widget.noteId);
    print(note.createdAt.toString());
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Flexible(
                      child: Text(
                        note.name.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  note.parseLocation().isNotEmpty
                      ? Row(
                    children: [
                      const Icon(Icons.add_location_sharp,
                          color: Colors.white),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          note.parseLocation(),
                          style:
                          const TextStyle(color: Colors.white38),
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                  const SizedBox(height: 18),
                  note.parseApartment().isNotEmpty
                      ? Row(
                    children: [
                      const Icon(Icons.apartment,
                          color: Colors.white),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          note.parseApartment(),
                          style:
                          const TextStyle(color: Colors.white38),
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                  const SizedBox(height: 18),
                  note.parseFurniture().isNotEmpty
                      ? Row(
                    children: [
                      const Icon(Icons.garage_outlined,
                          color: Colors.white),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          note.parseFurniture(),
                          style:
                          const TextStyle(color: Colors.white38),
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                  const SizedBox(height: 18),
                  note.price.toString().isNotEmpty
                      ? Row(
                    children: [
                      const Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          note.price.toString(),
                          style:
                          const TextStyle(color: Colors.white38),
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                  const SizedBox(height: 18),
                  note.bedrooms.toString().isNotEmpty
                      ? Row(
                    children: [
                      const Icon(
                        Icons.bed,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          note.bedrooms.toString(),
                          style:
                          const TextStyle(color: Colors.white38),
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                  const SizedBox(height: 18),
                  note.reporter.toString().isNotEmpty
                      ? Row(
                    children: [
                      const Icon(
                        Icons.person_add_alt_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          note.reporter.toString(),
                          style:
                          const TextStyle(color: Colors.white38),
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Icon(Icons.access_alarms, color: Colors.white),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          note.parseCreateAt(),
                          style: const TextStyle(color: Colors.white38),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  buildNote(),
                  const SizedBox(height: 18),
                  createNote(),
                  const SizedBox(height: 18),
                  noteArr.isEmpty
                      ? buildNotess('')
                      : buildNotess(noteArr[noteArr.length - 1].name)
                ],
              ),
            ),
      );

  Widget buildNotess(txt) => Flexible(
        child: Text(
          txt,
          style: const TextStyle(color: Colors.white70, fontSize: 18),
        ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(bookings: note),
        ));

        refreshNote();
      });

  Widget buildNote() => TextFormField(
        maxLines: 1,
        initialValue: noteText,
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            disabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Note',
            labelStyle: TextStyle(color: Colors.white)),
        style: const TextStyle(color: Colors.white, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: (text) => setState(() => noteText = text),
      );

  Widget createNote() => MaterialButton(
        color: Colors.white,
        child: const Text(
          'Save',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onPressed: () async {
          final noteTable = Note(
              name: noteText,
              dateTime: new DateTime.now().toString(),
              idBook: widget.noteId);
          await BookDatabase.instance.createNote(noteTable);
          refreshNote();
        },
      );

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await BookDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
