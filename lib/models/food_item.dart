class FoodItem {
  final String imagePath,
      name,
      shippingAddress,
      preparationTime,
      foodKind,
      description;
  final double shippingPrice, review, price;
  bool isPaid;
  final List<String>? additions;

  FoodItem(
      {required this.imagePath,
      required this.name,
      this.foodKind = "Chinese",
      required this.shippingAddress,
      required this.review,
      this.price = 0,
      this.isPaid = false,
      this.additions = const [],
      this.description = "Shortbread, chocolate turtle cookies, and red velvet.",
      required this.preparationTime,
      required this.shippingPrice});
}
