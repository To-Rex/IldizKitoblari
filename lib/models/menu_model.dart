class MenuModel {
  String? message;
  bool? status;
  Data? data;

  MenuModel({this.message, this.status, this.data});

  MenuModel.fromJson(Map<String, dynamic> json) {
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
  List<Result>? result;
  int? count;

  Data({this.result, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Result {
  String? sId;
  Title? title;
  String? slug;
  String? link;
  int? menuId;
  bool? isStatic;
  int? order;
  bool? isFooter;
  bool? isHeader;
  Title? shortContent;
  List<Children>? children;
  Banner? banner;

  Result(
      {this.sId,
        this.title,
        this.slug,
        this.link,
        this.menuId,
        this.isStatic,
        this.order,
        this.isFooter,
        this.isHeader,
        this.shortContent,
        this.children,
        this.banner});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    slug = json['slug'];
    link = json['link'];
    menuId = json['menu_id'];
    isStatic = json['is_static'];
    order = json['order'];
    isFooter = json['is_footer'];
    isHeader = json['is_header'];
    shortContent = json['short_content'] != null
        ? Title.fromJson(json['short_content'])
        : null;
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
    banner =
    json['banner'] != null ? Banner.fromJson(json['banner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['slug'] = slug;
    data['link'] = link;
    data['menu_id'] = menuId;
    data['is_static'] = isStatic;
    data['order'] = order;
    data['is_footer'] = isFooter;
    data['is_header'] = isHeader;
    if (shortContent != null) {
      data['short_content'] = shortContent!.toJson();
    }
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    if (banner != null) {
      data['banner'] = banner!.toJson();
    }
    return data;
  }
}

class Title {
  String? uz;
  String? oz;
  String? ru;

  Title({this.uz, this.oz, this.ru});

  Title.fromJson(Map<String, dynamic> json) {
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

class Children {
  String? sId;
  Title? title;
  String? slug;
  String? link;
  String? menuId;
  bool? isStatic;
  int? order;
  bool? isFooter;
  bool? isHeader;
  Title? shortContent;
  Null? banner;
  List<Childrens>? children;

  Children(
      {this.sId,
        this.title,
        this.slug,
        this.link,
        this.menuId,
        this.isStatic,
        this.order,
        this.isFooter,
        this.isHeader,
        this.shortContent,
        this.banner,
        this.children});

  Children.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    slug = json['slug'];
    link = json['link'];
    menuId = json['menu_id'];
    isStatic = json['is_static'];
    order = json['order'];
    isFooter = json['is_footer'];
    isHeader = json['is_header'];
    shortContent = json['short_content'] != null
        ? Title.fromJson(json['short_content'])
        : null;
    banner = json['banner'];
    if (json['children'] != null) {
      children = <Childrens>[];
      json['children'].forEach((v) {
        children!.add(Childrens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['slug'] = slug;
    data['link'] = link;
    data['menu_id'] = menuId;
    data['is_static'] = isStatic;
    data['order'] = order;
    data['is_footer'] = isFooter;
    data['is_header'] = isHeader;
    if (shortContent != null) {
      data['short_content'] = shortContent!.toJson();
    }
    data['banner'] = banner;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Childrens {
  String? sId;
  Title? title;
  String? slug;
  String? link;
  String? menuId;
  Title? shortContent;
  bool? isStatic;
  bool? isHeader;
  bool? isFooter;
  int? order;
  Null? banner;

  Childrens(
      {this.sId,
        this.title,
        this.slug,
        this.link,
        this.menuId,
        this.shortContent,
        this.isStatic,
        this.isHeader,
        this.isFooter,
        this.order,
        this.banner});

  Childrens.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    slug = json['slug'];
    link = json['link'];
    menuId = json['menu_id'];
    shortContent = json['short_content'] != null
        ? new Title.fromJson(json['short_content'])
        : null;
    isStatic = json['is_static'];
    isHeader = json['is_header'];
    isFooter = json['is_footer'];
    order = json['order'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['slug'] = slug;
    data['link'] = link;
    data['menu_id'] = menuId;
    if (shortContent != null) {
      data['short_content'] = shortContent!.toJson();
    }
    data['is_static'] = isStatic;
    data['is_header'] = isHeader;
    data['is_footer'] = isFooter;
    data['order'] = order;
    data['banner'] = banner;
    return data;
  }
}

class Banner {
  String? sId;
  String? name;
  String? link;
  String? menu;
  bool? status;
  String? imageUz;
  String? imageOz;
  String? imageRu;

  Banner(
      {this.sId,
        this.name,
        this.link,
        this.menu,
        this.status,
        this.imageUz,
        this.imageOz,
        this.imageRu});

  Banner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    link = json['link'];
    menu = json['menu'];
    status = json['status'];
    imageUz = json['image_uz'];
    imageOz = json['image_oz'];
    imageRu = json['image_ru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['link'] = this.link;
    data['menu'] = this.menu;
    data['status'] = this.status;
    data['image_uz'] = this.imageUz;
    data['image_oz'] = this.imageOz;
    data['image_ru'] = this.imageRu;
    return data;
  }
}
