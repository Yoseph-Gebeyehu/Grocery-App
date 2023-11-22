class Fruit {
  final String image;
  final String name;
  final double amout;
  final String category;
  bool isAddedToCart;
  bool isFavorite;

  Fruit({
    required this.image,
    required this.name,
    required this.amout,
    required this.category,
    this.isAddedToCart = false,
    this.isFavorite = false,
  });
}
