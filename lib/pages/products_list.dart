import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_sqlite/models/cart_item_model.dart';
import 'package:shop_sqlite/models/product_model.dart';
import 'package:shop_sqlite/services/shop_database.dart';

class ProductsListPage extends StatelessWidget {
  const ProductsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      Product(1, 'Gorra Negra', 'Gorra negra de lana', 18.0),
      Product(2, 'Gorra Negra', 'Gorra negra de lana', 28.0),
      Product(3, 'Gorra Negra', 'Gorra negra de lana', 8.0),
      Product(4, 'Gorra Negra', 'Gorra negra de lana', 118.0),
      Product(5, 'Gorra Negra', 'Gorra negra de lana', 185.0),
      Product(6, 'Gorra Negra', 'Gorra negra de lana', 128.0),
      Product(7, 'Gorra Negra', 'Gorra negra de lana', 138.0),
    ];

    return ListView.separated(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            color: Colors.lightBlueAccent,
            child: _ProductoItem(products[index]),
          ),
          onTap: () async {
            await addToCart(products[index]);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Producto agregado!'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => Divider(
        height: 2,
        color: Colors.blue,
      ),
    );
  }

  Future addToCart(Product product) async {
    final item = CartItem(
      product.id,
      product.name,
      product.price,
      1,
    );
    await ShopDatabase.instance.insert(item);
  }
}

class _ProductoItem extends StatelessWidget {
  final Product product;

  _ProductoItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/gorra.png',
            width: 100,
          ),
          Padding(
              padding: EdgeInsets.only(
            right: 3,
            left: 3,
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name),
              Text(product.description),
              Text('\$ ${product.price}'),
            ],
          )
        ],
      ),
    );
  }
}
