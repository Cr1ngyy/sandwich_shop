import 'package:flutter/material.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/constants.dart';
import 'package:sandwich_shop/widgets/basket_button.dart';
import 'package:sandwich_shop/models/cart_item.dart';
import 'package:sandwich_shop/repositories/cart_repository.dart';
import 'package:sandwich_shop/widgets/primary_button.dart';

class OrderScreen extends StatefulWidget {
  final Sandwich sandwich;
  final int maxQuantity;

  const OrderScreen({super.key, required this.sandwich, this.maxQuantity = 10});

  @override
  State<StatefulWidget> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  String _confirmationMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: shopHeaderStyle),
        actions: const [BasketButton()],
        // backgroundColor: const Color.fromARGB(255, 255, 194, 250),
      ),
      // backgroundColor: Color.fromARGB(255, 255, 229, 247),
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Order ${widget.sandwich.name}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              OrderItemDisplay(_quantity, widget.sandwich.name),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _increaseQuantity(),
                    child: const Text('Add'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _decreaseQuantity(),
                    child: const Text('Remove'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'Add to Basket',
                  onPressed: _addToBasket,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _confirmationMessage,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          ],
      ),
      ),
      );
  }

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() => _quantity++);
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() => _quantity--);
    }
  }

  void _addToBasket() {
    if (_quantity > 0) {
      final CartItem item = CartItem(
        sandwich: widget.sandwich,
        quantity: _quantity,
      );
      CartRepository.instance.addItem(item);
      setState(() {
        _confirmationMessage =
            'Added $_quantity ${widget.sandwich.name} to basket';
      });
    } else {
      setState(() {
        _confirmationMessage = 'Please select at least 1 sandwich';
      });
    }
  }

}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text("$quantity $itemType sandwich(es): ${'🥪' * quantity}");
  }
}
