class CartCreate {
  String? sId;
  int? count;
  //String? product;
  String? type;
  //String? user;

  CartCreate({
    this.sId, this.count,
    //this.product,
    this.type,
    //this.user
  });

  CartCreate.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
    //product = json['product'];
    type = json['type'];
    //user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['count'] = count;
    //data['product'] = product;
    data['type'] = type;
    //data['user'] = user;
    return data;
  }

}
