class CartItem {
  final int productId;
  final String imageUrl;
  final String name;
  final double price;
  int qty;

  CartItem({
    required this.productId,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.qty,
  });
}
