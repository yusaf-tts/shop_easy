class Product {
  final String category;
  final String description;
  final String discount;
  final String imageUrl;
  final String name;
  final String price;
  final String rating;
  final String stock;
  final bool addedToFav;
  bool addedToCart;

  Product({
    required this.category,
    required this.description,
    required this.discount,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.stock,
    required this.addedToFav,
    required this.addedToCart,
  });

  factory Product.fromMap(Map<dynamic, dynamic> map) {
    return Product(
        category: map['category'],
        description: map['description'],
        discount: map['discount'],
        imageUrl: map['image_url'],
        name: map['name'],
        price: map['price'],
        rating: map['rating'],
        stock: map['stock'],
        addedToFav: map['added_to_fav'],
        addedToCart: map['added_to_cart']);
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'description': description,
      'discount': discount,
      'image_url': imageUrl,
      'name': name,
      'price': price,
      'rating': rating,
      'stock': stock,
      'added_to_fav': addedToFav,
      'added_to_cart': addedToCart,
    };
  }


  Product copyWith({
    String? category,
    String? description,
    String? discount,
    String? imageUrl,
    String? name,
    String? price,
    String? rating,
    String? stock,
    bool? addedToFav,
    bool? addedToCart,
  }) {
    return Product(
      category: category ?? this.category,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      addedToFav: addedToFav ?? this.addedToFav,
      addedToCart: addedToCart ?? this.addedToCart,
    );
  }
}
