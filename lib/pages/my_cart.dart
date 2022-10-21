import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_sqlite/Provider/cart_provider.dart';
import 'package:shop_sqlite/models/cart_item_model.dart';
import 'package:shop_sqlite/services/shop_database.dart';

class MyCartPage extends StatelessWidget {
  final cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: ShopDatabase.instance.getAllItems(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CartItem> cartItems = snapshot.data!;

              return cartItems.isEmpty
                  ? Center(
                      child: Text(
                        'No hay productos',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : ListView.separated(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.yellow.shade800,
                          child: _CartItem(cartItems[index]),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                    );
            } else {
              return Center(
                child: Text(
                  'No hay productos',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class _CartItem extends StatelessWidget {
  final CartItem cartItem;

  const _CartItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DefaultTextStyle.merge(
        style: TextStyle(fontSize: 20, color: Colors.white),
        child: Row(
          children: [
            Image.asset(
              'assets/images/gorra.png',
              width: 100,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(cartItem.name),
                  Text('\$ ${cartItem.price}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${cartItem.quantity} unidades'),
                      ElevatedButton(
                        onPressed: () async {
                          cartItem.quantity++;
                          await ShopDatabase.instance.update(cartItem);
                          Provider.of<CartNotifier>(context, listen: false)
                              .shouldRefresh();
                        },
                        child: Text('+'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10.0),
                          minimumSize: Size.zero,
                          primary: Colors.green.shade300,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          cartItem.quantity--;
                          if (cartItem.quantity == 0) {
                            await ShopDatabase.instance.delete(cartItem.id);
                          } else {
                            await ShopDatabase.instance.update(cartItem);
                          }
                          Provider.of<CartNotifier>(context, listen: false)
                              .shouldRefresh();
                        },
                        child: Text('-'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10.0),
                          minimumSize: Size.zero,
                          primary: Colors.green.shade300,
                        ),
                      ),
                    ],
                  ),
                  Text('Total: \$ ${cartItem.totalPrice}'),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await ShopDatabase.instance.delete(cartItem.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Producto eliminado!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Provider.of<CartNotifier>(context, listen: false)
                          .shouldRefresh();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
