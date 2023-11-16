class HomeModel {
  final String image;
  final String name;
  final String amout;
  final String addToCart;
  bool isFavorite;

  HomeModel({
    required this.image,
    required this.name,
    required this.amout,
    required this.addToCart,
    this.isFavorite = false,
  });
}
