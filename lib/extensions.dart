import 'package:appbooking/model/address.dart';
import 'package:intl/intl.dart';

import 'model/book.dart';

extension BookingParseDate on Booking {
  String parseCreateAt() {
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS")
        .parse(createdAt ?? DateTime.now().toString());
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  String parseLocation() {
    return "${address ?? ""}, ${ward.toString() == "Select Ward" ? "" : ward.toString()}, ${district.toString() == "Select District" ? "" : district.toString()}, ${city.toString() == "Select City" ? "" : city.toString()}";
  }

  String parseApartment() {
    return typeProperty.toString() == "Select Type" ? "" : typeProperty.toString();
  }

  String parseFurniture() {
    return furniture.toString() == "Select Furniture" ? "" : furniture.toString();
  }
}

extension AddressExtensions on String {
  List<District> getDistricts() {
    try {
      return citys.where((element) => element.name == this).first.districts;
    } catch (e) {
      return [citys[0].districts[0]];
    }
  }

  List<Ward> getWards(String city) {
    try {
      City temp = citys.where((element) => element.name == city).first;
      District temp2 =
          temp.districts.where((element) => element.name == this).first;
      return temp2.wards;
    } catch (e) {
      return citys[0].districts[0].wards;
    }
  }
}
