class HotelDetails {
  final String uuid;
  final String name;
  final double price;
  final double rating;
  final HotelAddress address;
  final HotelServices services;
  final List<String> photos;

  HotelDetails(
      {this.uuid,
      this.name,
      this.price,
      this.rating,
      this.address,
      this.services,
      this.photos});

  HotelDetails.fromJson(Map<String, dynamic> json)
      : this(
            uuid: json['uuid'],
            name: json['name'],
            price: json['price'],
            rating: json['rating'],
            address: HotelAddress.fromJson(json['address']),
            services: HotelServices.fromJson(json['services']),
            photos: json['photos'].cast<String>().toList());
}

class HotelAddress {
  final String country;
  final String street;
  final String city;

  HotelAddress({this.country, this.street, this.city});

  HotelAddress.fromJson(Map<String, dynamic> json)
      : this(
            country: json['country'],
            street: json['street'],
            city: json['city']);
}

class HotelServices {
  final List<String> free;
  final List<String> paid;

  HotelServices({this.free, this.paid});

  HotelServices.fromJson(Map<String, dynamic> json)
      : this(
            free: json['free'].cast<String>().toList(),
            paid: json['paid'].cast<String>().toList());
}
