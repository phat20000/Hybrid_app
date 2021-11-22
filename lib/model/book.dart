final String tableBooking = 'booking';

class BookFields {
  static final List<String> values = [
    id,
    status,
    name,
    address,
    city,
    district,
    ward,
    typeProperty,
    furniture,
    bedrooms,
    price,
    reporter,
    createdAt
  ];
  static const String id = '_id';
  static const String status = 'status';
  static const String name = 'name';
  static const String address = 'address';
  static const String city = 'city';
  static const String district = 'district';
  static const String ward = 'ward';
  static const String typeProperty = 'typeProperty';
  static const String furniture = 'furniture';
  static const String bedrooms = 'bedrooms';
  static const String price = 'price';
  static const String reporter = 'reporter';
  static const String createdAt = 'createdAt';
}

class Booking {
  final int? id;
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

  const Booking(
      {this.id,
      required this.status,
      this.name,
      this.address,
      this.city,
      this.district,
      this.ward,
      this.typeProperty,
      this.furniture,
      this.bedrooms,
      this.price,
      this.reporter,
      this.createdAt});

  Map<String, Object?> toJson() => {
        BookFields.id: id,
        BookFields.status: status ? 1 : 0,
        BookFields.name: name,
        BookFields.address: address,
        BookFields.city: city,
        BookFields.district: district,
        BookFields.ward: ward,
        BookFields.typeProperty: typeProperty,
        BookFields.furniture: furniture,
        BookFields.bedrooms: bedrooms,
        BookFields.price: price,
        BookFields.reporter: reporter,
        BookFields.createdAt: createdAt
      };

  Booking copy(
          {int? id,
          bool? status,
          String? name,
          String? address,
          String? city,
          String? district,
          String? ward,
          String? typeProperty,
          String? furniture,
          String? bedrooms,
          String? price,
          String? reporter,
          String? createdAt}) =>
      Booking(
          id: id ?? this.id,
          status: status ?? this.status,
          name: name ?? this.name,
          address: address ?? this.address,
          city: city ?? this.city,
          district: district ?? this.district,
          ward: ward ?? this.ward,
          typeProperty: typeProperty ?? this.typeProperty,
          furniture: furniture ?? this.furniture,
          bedrooms: bedrooms ?? this.bedrooms,
          price: price ?? this.price,
          reporter: reporter ?? this.reporter,
          createdAt: createdAt ?? this.createdAt);

  factory Booking.fromJson(Map<String, Object?> json) => Booking(
        id: json[BookFields.id] as int?,
        status: json[BookFields.status] == 1,
        name: json[BookFields.name] as String,
        address: json[BookFields.address] as String,
        city: json[BookFields.city] as String,
        district: json[BookFields.district] as String,
        ward: json[BookFields.ward] as String,
        typeProperty: json[BookFields.typeProperty] as String,
        furniture: json[BookFields.furniture] as String,
        bedrooms: json[BookFields.bedrooms] as String,
        price: json[BookFields.price] as String,
        reporter: json[BookFields.reporter] as String,
        createdAt: json[BookFields.createdAt] as String,
      );

  @override
  String toString() {
    return "$name $district";
  }
}
