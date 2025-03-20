class Product {
  final String image, brand, name, price;
  final int color;
  List<String>? images;

  Product(
      {required this.brand,
      required this.name,
      required this.image,
      required this.price,
      required this.color,
      this.images});
}
