class ContactModel {
  String? name;
  String? email;
  String? phone;
  String? img;

  ContactModel({this.name, this.email, this.phone, this.img});

  ContactModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['img'] = this.img;
    return data;
  }
}
