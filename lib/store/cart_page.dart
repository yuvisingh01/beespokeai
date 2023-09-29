// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:beespokeai/store/product.dart';
import 'package:beespokeai/store/product_feed_page.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalCartValue = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotalCartValue();
  }

  void _calculateTotalCartValue() {
    double total = 0;
    for (final cartItem in widget.cartItems) {
      final product = cartItem.product;
      final totalPrice = product.price * cartItem.quantity;
      total += totalPrice;
    }
    setState(() {
      totalCartValue = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo.png', width: 240, height: 55),
            const SizedBox(width: 8),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 144, 94, 205),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = widget.cartItems[index];
          final product = cartItem.product;

          return ListTile(
            leading: Image.network(product.image),
            title: Text(product.title),
            subtitle: Text('Price: \$${product.price.toStringAsFixed(2)}'),
            trailing: Text('Quantity: ${cartItem.quantity}'),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${totalCartValue.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle checkout logic here
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}



