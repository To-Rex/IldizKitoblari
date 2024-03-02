class QuotesModel {
  String? message;
  bool? status;
  Data? data;

  QuotesModel({this.message, this.status, this.data});

  QuotesModel.fromJson(Map<String, dynamic> json) {
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
  Result? result;
  int? count;

  Data({this.result, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['count'] = count;
    return data;
  }
}

class Result {
  String? sId;
  Name? name;
  Name? description;
  int? type;
  bool? status;
  String? image;
  String? pubDate;
  Product? product;
  int? count;

  Result(
      {this.sId,
        this.name,
        this.description,
        this.type,
        this.status,
        this.image,
        this.pubDate,
        this.product,
        this.count});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? Name.fromJson(json['description'])
        : null;
    type = json['type'];
    status = json['status'];
    image = json['image'];
    pubDate = json['pub_date'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['type'] = type;
    data['status'] = status;
    data['image'] = image;
    data['pub_date'] = pubDate;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['count'] = count;
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

class Product {
  Name? name;
  String? slug;
  String? menuSlug;

  Product({this.name, this.slug, this.menuSlug});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    slug = json['slug'];
    menuSlug = json['menu_slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['slug'] = slug;
    data['menu_slug'] = menuSlug;
    return data;
  }
}
