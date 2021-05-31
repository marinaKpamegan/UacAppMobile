
class UacLocation{
  String name;
  String description;
  double lat;
  double lng;
  String type;

  UacLocation(this.name, this.description, this.lat, this.lng, this.type);


  UacLocation.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      description = json['description'] as String,
      lat = json['lat'] as double,
      lng = json['lng'] as double,
      type = json['type'] as String;

  Map<String, dynamic> toJson()=>
      {
        'name': name,
        'description': description,
        'lat': lat,
        'lng': lng,
        'type': type
      };

  /*@override
  String toString() {
    return '{ ${this.name}, ${this.description}, ${this.type}, ${this.location.latitude}, ${this.location.longitude}  }';
  }*/
}

