import 'package:flutter/material.dart';
import 'package:shop_sqlite/Provider/cart_provider.dart';
import 'package:shop_sqlite/pages/my_cart.dart';
import 'package:shop_sqlite/pages/products_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ChangeNotifierProvider(
        create: (context) => CartNotifier(),
        child: MyHomePage(title: 'Flutter Shop SQLite'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Sqlite'),
      ),
      body: _selectedIndex == 0 ? ProductsListPage() : MyCartPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Shop'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'My Cart'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber.shade600,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
