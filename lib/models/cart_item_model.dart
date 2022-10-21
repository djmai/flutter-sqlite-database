class CartItem {
  final int id;
  final String name;
  final double price;
  int quantity;

  CartItem(
    this.id,
    this.name,
    this.price,
    this.quantity,
  );

  get totalPrice {
    return quantity * price;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
