import 'package:appbooking/db/booking.dart';
import 'package:appbooking/model/book.dart';
import 'package:appbooking/pages/detail_list_page.dart';
import 'package:appbooking/pages/edit_booking_page.dart';
import 'package:appbooking/widget/note_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final fieldText = TextEditingController();
  late List<Booking> notes;
  bool isLoading = false;
  String search = '';

  void clearText() {
    fieldText.clear();
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    BookDatabase.instance.close();
    fieldText.dispose();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await BookDatabase.instance.readAll();
    setState(() => search = '');
    setState(() => isLoading = false);
  }

  Future searchBooking() async {
    setState(() => isLoading = true);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: fieldText,
                onChanged: (text) async {
                  var results = await BookDatabase.instance.search(text);
                  setState(() {
                    search = text;
                    notes = results;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () async {
                      clearText();
                      var results = await BookDatabase.instance.readAll();
                      /* Clear the search field */
                      setState(() {
                        search = '';
                        notes = results;
                      });
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? const Text(
                      'No booking',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildSearch() => TextFormField(
        maxLines: 1,
        initialValue: search,
        decoration: const InputDecoration(labelText: 'Search'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The address cannot be empty'
            : null,
        onChanged: (text) => setState(() => search = text),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(20),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(4),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(book: note, index: index),
          );
        },
      );
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}
