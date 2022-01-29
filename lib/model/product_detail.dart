class ProductDetailModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  int? quantity;

  ProductDetailModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating,
      this.quantity});

  factory ProductDetailModel.fromJson(dynamic json) {
    return ProductDetailModel(
        image: json["image"],
        category: json["category"],
        description: json["description"],
        id: json["id"],
        price: json["price"] is int ? json["price"].toDouble() : json["price"],
        quantity: json["quantity"],
        rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
        title: json["title"]);
  }

  Map<String, dynamic> toJson(ProductDetailModel detail) {
    return {
      'id': detail.id,
      'title': detail.title,
      'price': detail.price,
      'description': detail.description,
      'category': detail.category,
      'image': detail.image,
      'quantity': detail.quantity
    };
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({
    double? rate,
    int? count,
  }) {
    rate = rate;
    count = count;
  }

  Rating.fromJson(dynamic json) {
    rate = json['rate'] is int ? json["rate"].toDouble() : json["rate"];
    count = json['count'];
  }
  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   'rate'] = rate;
  //   'count'] = count;
  //   return map;
  // }
}
