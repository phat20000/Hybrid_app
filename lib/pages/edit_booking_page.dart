import 'package:appbooking/db/booking.dart';
import 'package:appbooking/model/address.dart';
import 'package:appbooking/model/book.dart';
import 'package:appbooking/widget/note_form_widget.dart';
import 'package:flutter/material.dart';

class AddEditNotePage extends StatefulWidget {
  final Booking? bookings;

  const AddEditNotePage({
    Key? key,
    this.bookings,
  }) : super(key: key);

  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();

  late bool status;
  late String name;
  late String address;
  late String city;
  late String district;
  late String ward;
  late String typeProperty;
  late String furniture;
  late String bedrooms;
  late String price;
  late String reporter;
  late String createdAt;

  @override
  void initState() {
    super.initState();

    status = widget.bookings?.status ?? false;
    name = widget.bookings?.name ?? '';
    address = widget.bookings?.address ?? '';
    city = widget.bookings?.city ?? citys[0].name;
    district = widget.bookings?.district ?? citys[0].districts[0].name;
    ward = widget.bookings?.ward ?? citys[0].districts[0].wards[0].name;
    typeProperty = widget.bookings?.typeProperty ?? types[0];
    furniture = widget.bookings?.furniture ?? furnitures[0];
    bedrooms = widget.bookings?.bedrooms ?? '';

    price = widget.bookings?.price ?? '';
    reporter = widget.bookings?.reporter ?? '';
    createdAt = widget.bookings?.createdAt ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            status: status,
            name: name,
            address: address,
            city: city,
            district: district,
            ward: ward,
            typeProperty: typeProperty,
            furniture: furniture,
            bedrooms: bedrooms,
            price: price,
            reporter: reporter,
            createdAt: createdAt,
            onChangedStatus: (isImportant) => setState(() => status = isImportant),
            onChangedName: (nameText) => setState(() => name = nameText),
            onChangedAddress: (text) => setState(() => address = text),
            onChangedcreatedAt: (text) => setState(() => createdAt = DateTime.now().toString()),
            onChangedbedrooms: (text) => setState(() => bedrooms = text),
            onChangedcity: (text) => setState(() => city = text!),
            onChangedfurniture: (text) => setState(() => furniture = text!),
            onChangeddistrict: (text) => setState(() => district = text!),
            onChangedprice: (text) => setState(() => price = text),
            onChangedreporter: (text) => setState(() => reporter = text),
            onChangedtypeProperty: (text) => setState(() => typeProperty = text!),
            onChangedward: (text) => setState(() => ward = text!),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = name.isNotEmpty && address.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: () => _displayDialog(context),
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.bookings != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  void _displayDialog(context) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.only(top: 25),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            height: 600,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildName(),
                  buildCity(),
                  buildAddress(),
                  buildDistrict(),
                  buildWard(),
                  buildType(),
                  buildFur(),
                  buildBed(),
                  buildPrice(),
                  buildReport(),
                  buildCreateAt(),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 60, bottom: 7),
                  child: MaterialButton(
                    color: Colors.cyan[600],
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 19, bottom: 7),
                  child: MaterialButton(
                      color: Colors.cyan[600],
                      child: const Text('SAVE'),
                      onPressed: addOrUpdateNote),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future updateNote() async {
    final note = widget.bookings!.copy(
        status: status,
        name: name,
        address: address,
        city: city,
        district: district,
        ward: ward,
        typeProperty: typeProperty,
        furniture: furniture,
        bedrooms: bedrooms,
        price: price,
        reporter: reporter,
        createdAt: createdAt.isEmpty ? DateTime.now().toString() : createdAt);

    await BookDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Booking(
        status: status,
        name: name,
        address: address,
        city: city,
        district: district,
        ward: ward,
        typeProperty: typeProperty,
        furniture: furniture,
        bedrooms: bedrooms,
        price: price,
        reporter: reporter,
        createdAt: createdAt.isEmpty ? DateTime.now().toString() : createdAt);

    await BookDatabase.instance.create(note);
  }

  Widget buildAddress() => TextFormField(
        maxLines: 1,
        initialValue: address,
        decoration: const InputDecoration(labelText: 'Address'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The address cannot be empty'
            : null,
        onChanged: (text) => setState(() => address = text),
      );

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: name,
        decoration: const InputDecoration(
          labelText: 'Name',
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8), // Added this
        ),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) =>
            title != null && title.isEmpty ? 'The name cannot be empty' : null,
        onChanged: (text) => setState(() => name = text),
      );

  Widget buildCity() => TextFormField(
        maxLines: 1,
        initialValue: city,
        decoration: const InputDecoration(labelText: 'Name'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: (text) => setState(() => city = text),
      );

  Widget buildDistrict() => TextFormField(
        maxLines: 1,
        initialValue: district,
        decoration: const InputDecoration(labelText: 'Name'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: (text) => setState(() => district = text),
      );

  Widget buildWard() => TextFormField(
        maxLines: 1,
        initialValue: ward,
        decoration: const InputDecoration(labelText: 'Ward'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: (text) => setState(() => ward = text),
      );

  Widget buildType() => TextFormField(
        maxLines: 1,
        initialValue: typeProperty,
        decoration: const InputDecoration(labelText: 'Name'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: (text) => setState(() => typeProperty = text),
      );

  Widget buildFur() => TextFormField(
        maxLines: 1,
        initialValue: furniture,
        decoration: const InputDecoration(labelText: 'Fur'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: (text) => setState(() => furniture = text),
      );

  Widget buildBed() => TextFormField(
        maxLines: 1,
        initialValue: bedrooms,
        decoration: const InputDecoration(labelText: 'Bedrooms'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The bedrooms cannot be empty'
            : null,
        onChanged: (text) => setState(() => bedrooms = text),
      );

  Widget buildPrice() => TextFormField(
        maxLines: 1,
        initialValue: price,
        decoration: const InputDecoration(labelText: 'Price'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: (text) => setState(() => price = text),
      );

  Widget buildReport() => TextFormField(
        maxLines: 1,
        initialValue: reporter,
        decoration: const InputDecoration(labelText: 'Reporter'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: (text) => setState(() => reporter = text),
      );

  Widget buildCreateAt() => TextFormField(
        maxLines: 1,
        initialValue: createdAt,
        decoration: const InputDecoration(labelText: 'createdAt'),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: (text) => setState(() => createdAt = text),
      );
}
