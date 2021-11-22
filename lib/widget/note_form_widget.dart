import 'dart:ui';

import 'package:appbooking/extensions.dart';
import 'package:appbooking/model/address.dart';
import 'package:appbooking/widget/address_selected_widget.dart';
import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool status;
  final String? name;
  final String? address;
  final String? city;
  final String? district;
  final String? ward;
  final String? typeProperty;
  final String? furniture;
  final String? bedrooms;
  final String? price;
  final String? reporter;
  final String? createdAt;
  final ValueChanged<bool> onChangedStatus;
  final ValueChanged<String> onChangedName;

  final ValueChanged<String> onChangedAddress;
  final ValueChanged<String?> onChangedcity;
  final ValueChanged<String?> onChangeddistrict;
  final ValueChanged<String?> onChangedward;
  final ValueChanged<String?> onChangedtypeProperty;
  final ValueChanged<String?> onChangedfurniture;
  final ValueChanged<String> onChangedbedrooms;
  final ValueChanged<String> onChangedprice;
  final ValueChanged<String> onChangedreporter;
  final ValueChanged<String> onChangedcreatedAt;

  const NoteFormWidget(
      {Key? key,
      this.status = false,
      this.name = '',
      this.address = '',
      this.city = '',
      this.district = '',
      this.ward = '',
      this.typeProperty = '',
      this.furniture = '',
      this.bedrooms = '',
      this.price = '',
      this.reporter = '',
      this.createdAt = '',
      required this.onChangedAddress,
      required this.onChangedName,
      required this.onChangedStatus,
      required this.onChangedcity,
      required this.onChangeddistrict,
      required this.onChangedward,
      required this.onChangedtypeProperty,
      required this.onChangedfurniture,
      required this.onChangedbedrooms,
      required this.onChangedreporter,
      required this.onChangedprice,
      required this.onChangedcreatedAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Name",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: buildName(),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Adress",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: buildAddress(),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "City",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: buildCity(citys),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "District",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: buildDistrict(city!.getDistricts()),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ward",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: buildWard(district!.getWards(city!)),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Type Property",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: buildType(),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Funrniture",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: buildFur(),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bedrooms",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: buildBed(),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Price",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: buildPrice(),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Report",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: buildReport(),
              ),
            ],
          ),
        ),
      );

  Widget buildName() => TextFormField(
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        maxLines: 1,
        initialValue: name,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The name cannot be empty' : null,
        onChanged: onChangedName,
      );

  Widget buildAddress() => TextFormField(
        cursorColor: Colors.white,
        maxLines: 1,
        initialValue: address,
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The address cannot be empty'
            : null,
        onChanged: onChangedAddress,
      );

  Widget buildCity(List<City> cities) => AddressSelectedOutline<String>(
        onChangedValue: (String? city) {
          onChangeddistrict(citys[0].districts[0].name);
          onChangedward(citys[0].districts[0].wards[0].name);
          onChangedcity(city);
        },
        selectedValue: city ?? cities[0].name,
        onValidator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        selectedItemBuilder: (BuildContext context) {
          return cities.map((e) => e.name).map((String value) {
            return Text(
              value,
              style: const TextStyle(color: Colors.white),
            );
          }).toList();
        },
        items: cities.map((City value) {
          return DropdownMenuItem<String>(
            value: value.name,
            child: Text(value.name),
          );
        }).toList(),
      );

  Widget buildDistrict(List<District> districts) {
    return AddressSelectedOutline<String>(
      onChangedValue: (String? district) {
        onChangedward(citys[0].districts[0].wards[0].name);
        onChangeddistrict(district);
      },
      selectedValue: district ?? districts[0].name,
      onValidator: (title) => title != null && title.isEmpty
          ? 'The description cannot be empty'
          : null,
      selectedItemBuilder: (BuildContext context) {
        return districts.map((e) => e.name).map((String value) {
          return Text(
            value,
            style: const TextStyle(color: Colors.white),
          );
        }).toList();
      },
      items: districts.map((District value) {
        return DropdownMenuItem<String>(
          value: value.name,
          child: Text(value.name),
        );
      }).toList(),
    );
  }

  Widget buildWard(List<Ward> wards) => AddressSelectedOutline<String>(
        onChangedValue: onChangedward,
        selectedValue: ward ?? wards[0].name,
        onValidator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        selectedItemBuilder: (BuildContext context) {
          return wards.map((e) => e.name).map((String value) {
            return Text(
              value,
              style: const TextStyle(color: Colors.white),
            );
          }).toList();
        },
        items: wards.map((Ward value) {
          return DropdownMenuItem<String>(
            value: value.name,
            child: Text(value.name),
          );
        }).toList(),
      );

  Widget buildType() => AddressSelectedOutline<String>(
        onChangedValue: onChangedtypeProperty,
        selectedValue: typeProperty ?? types[0],
        onValidator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        selectedItemBuilder: (BuildContext context) {
          return types.map((String value) {
            return Text(
              typeProperty ?? types[0],
              style: const TextStyle(color: Colors.white),
            );
          }).toList();
        },
        items: types.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );

  Widget buildFur() => AddressSelectedOutline<String>(
        onChangedValue: onChangedfurniture,
        selectedValue: furniture ?? furnitures[0],
        onValidator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        selectedItemBuilder: (BuildContext context) {
          return furnitures.map((String value) {
            return Text(
              furniture ?? furnitures[0],
              style: const TextStyle(color: Colors.white),
            );
          }).toList();
        },
        items: furnitures.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );

  Widget buildBed() => TextFormField(
        cursorColor: Colors.white,
        maxLines: 1,
        initialValue: bedrooms,
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The bedrooms cannot be empty'
            : null,
        onChanged: onChangedbedrooms,
      );

  Widget buildPrice() => TextFormField(
        cursorColor: Colors.white,
        maxLines: 1,
        initialValue: price,
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedprice,
      );

  Widget buildReport() => TextFormField(
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        maxLines: 1,
        initialValue: reporter,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedreporter,
      );

  Widget buildCreateAt() => TextFormField(
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        maxLines: 1,
        initialValue: createdAt,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedcreatedAt,
      );
}
