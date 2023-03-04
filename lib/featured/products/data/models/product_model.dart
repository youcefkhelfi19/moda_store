class Product {
   String? productId;
  final String title;
  final String category;
  final String description;
  final double price;
  final int discount;
  final int quantity;
   List<String>? images;
  final List<String> sizes;
  final List<int> colors;
  final bool isPopular;
  final bool isRecommended;
  final String dateTime;



  Product({
     this.productId,
    required this.title,
    required this.quantity,
    required this.category,
    required this.description,
    required this.price,
    required this.discount,
     this.images,
    required this.sizes,
    required this.colors,
    required this.isPopular,
    required this.isRecommended,
    required this.dateTime
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['id'],
      title: map['title'],
      category: map['category'],
      isRecommended: map['isRecommended'],
      dateTime: map['dateTime'],
      description: map['description'],
      quantity: map['quantity'],
      price: map['price'].toDouble(),
      discount: map['discount'],
      images: List<String>.from(map['images']),
      sizes: List<String>.from(map['sizes']),
      colors: List<int>.from(map['colors']),
      isPopular: map['isPopular'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = productId;
    data['title'] = title;
    data['category'] = category;
    data['description'] = description;
    data['quantity'] = quantity;
    data['price'] = price;
    data['discount'] = discount;
    data['images'] = images;
    data['sizes'] = sizes;
    data['colors'] = colors;
    data['isPopular'] = isPopular;
    data['isRecommended'] = isRecommended;
    data['dateTime'] = dateTime;
    return data;
  }
}
