class ContactsModel {
  List<ContactModel>? results;

  ContactsModel({this.results});

  ContactsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ContactModel>[];
      json['results'].forEach((v) {
        results!.add(new ContactModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactModel {
  String? objectId;
  String? name;
  String? email;
  String? phone;
  String? img;
  String? createdAt;
  String? updatedAt;

  ContactModel(
      {this.objectId,
      this.name,
      this.email,
      this.phone,
      this.img,
      this.createdAt,
      this.updatedAt});

  ContactModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    img = json['img'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['img'] = this.img;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
