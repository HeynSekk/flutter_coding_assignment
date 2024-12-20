class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;

  const User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });
}

class Address {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final Geo? geo;

  const Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });
}

class Geo {
  final String? lat;
  final String? lng;

  const Geo({
    this.lat,
    this.lng,
  });
}

class Company {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  const Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });
}
