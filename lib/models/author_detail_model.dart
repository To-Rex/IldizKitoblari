class AuthorDetailModel {
  String? message;
  bool? status;
  Data? data;

  AuthorDetailModel({this.message, this.status, this.data});

  AuthorDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  Name? name;
  String? optionId;
  Name? content;
  String? image;

  Data({this.sId, this.name, this.optionId, this.content, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    optionId = json['option_id'];
    content =
    json['content'] != null ? Name.fromJson(json['content']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['option_id'] = optionId;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['image'] = image;
    return data;
  }
}

class Name {
  String? uz;
  String? oz;
  String? ru;

  Name({this.uz, this.oz, this.ru});

  Name.fromJson(Map<String, dynamic> json) {
    uz = json['uz'];
    oz = json['oz'];
    ru = json['ru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uz'] = uz;
    data['oz'] = oz;
    data['ru'] = ru;
    return data;
  }
}
