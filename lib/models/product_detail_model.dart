class ProductDetailModel {
  String? message;
  bool? status;
  Data? data;

  ProductDetailModel({this.message, this.status, this.data});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  Name? name;
  int? price;
  int? sale;
  int? views;
  int? searched;
  int? count;
  bool? status;
  bool? famous;
  bool? newProduct;
  List<Options>? options;
  Name? content;
  List<SimularProducts>? simularProducts;
  List<Comments>? comments;
  List<Images>? images;

  Data(
      {this.sId,
        this.name,
        this.price,
        this.sale,
        this.views,
        this.searched,
        this.count,
        this.status,
        this.famous,
        this.newProduct,
        this.options,
        this.content,
        this.simularProducts,
        this.comments,
        this.images});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    price = json['price'];
    sale = json['sale'];
    views = json['views'];
    searched = json['searched'];
    count = json['count'];
    status = json['status'];
    famous = json['famous'];
    newProduct = json['new_product'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    content =
    json['content'] != null ? new Name.fromJson(json['content']) : null;
    if (json['simular_products'] != null) {
      simularProducts = <SimularProducts>[];
      json['simular_products'].forEach((v) {
        simularProducts!.add(new SimularProducts.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['price'] = this.price;
    data['sale'] = this.sale;
    data['views'] = this.views;
    data['searched'] = this.searched;
    data['count'] = this.count;
    data['status'] = this.status;
    data['famous'] = this.famous;
    data['new_product'] = this.newProduct;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    if (this.simularProducts != null) {
      data['simular_products'] =
          this.simularProducts!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uz'] = this.uz;
    data['oz'] = this.oz;
    data['ru'] = this.ru;
    return data;
  }
}

class Options {
  OptionId? optionId;
  String? value;
  ValueId? valueId;
  String? sId;

  Options({this.optionId, this.value, this.valueId, this.sId});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'] != null
        ? new OptionId.fromJson(json['option_id'])
        : null;
    value = json['value'];
    valueId = json['value_id'] != null
        ? new ValueId.fromJson(json['value_id'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.optionId != null) {
      data['option_id'] = this.optionId!.toJson();
    }
    data['value'] = this.value;
    if (this.valueId != null) {
      data['value_id'] = this.valueId!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class OptionId {
  String? sId;
  Name? name;
  int? type;

  OptionId({this.sId, this.name, this.type});

  OptionId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}

class ValueId {
  String? sId;
  Name? name;

  ValueId({this.sId, this.name});

  ValueId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    return data;
  }
}

class SimularProducts {
  String? sId;
  String? slug;
  int? price;
  int? sale;
  int? count;
  Options? option;
  String? image;

  SimularProducts(
      {this.sId,
        this.slug,
        this.price,
        this.sale,
        this.count,
        this.option,
        this.image});

  SimularProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    slug = json['slug'];
    price = json['price'];
    sale = json['sale'];
    count = json['count'];
    option =
    json['option'] != null ? new Options.fromJson(json['option']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['slug'] = this.slug;
    data['price'] = this.price;
    data['sale'] = this.sale;
    data['count'] = this.count;
    if (this.option != null) {
      data['option'] = this.option!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Comments {
  String? sId;
  int? rate;
  String? description;
  User? user;
  String? createdAt;

  Comments({this.sId, this.rate, this.description, this.user, this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rate = json['rate'];
    description = json['description'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rate'] = this.rate;
    data['description'] = this.description;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class User {
  String? sId;
  String? fullName;
  String? avatar;
  String? createdAt;

  User({this.sId, this.fullName, this.avatar, this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['full_name'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['full_name'] = this.fullName;
    data['avatar'] = this.avatar;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Images {
  String? sId;
  String? file;
  bool? isMain;

  Images({this.sId, this.file, this.isMain});

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    file = json['file'];
    isMain = json['is_main'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['file'] = this.file;
    data['is_main'] = this.isMain;
    return data;
  }
}
