class CartMedicine {
  int? id;
  int? mId;
  String? name;
  String? description;
  String? price;
  String? image;
  int? pId;
  int? isMedicine;

  CartMedicine({
    required this.name,
    required this.mId,
    required this.description,
    required this.price,
    required this.image,
    required this.pId,
    required this.isMedicine,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'medicine_id': mId,
      'name': name,
      'descriptions': description,
      'price': price,
      'image': image,
      'pId': pId,
      'isMedicine': isMedicine,
    };
    return map;
  }

  CartMedicine.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    mId = map['medicine_id'];
    name = map['name'].toString();
    description = map['descriptions'].toString();
    price = map['price'].toString();
    image = map['image'].toString();
    pId = map['pId'];
    isMedicine = map['isMedicine'];
  }
}
