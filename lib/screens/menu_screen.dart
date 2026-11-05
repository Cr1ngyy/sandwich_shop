import 'package:flutter/material.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/sandwich_repository.dart';
import 'package:sandwich_shop/widgets/sandwich_card.dart';
import 'package:sandwich_shop/constants.dart';
import 'package:sandwich_shop/widgets/basket_button.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SandwichRepository repository = SandwichRepository();
    final List<Sandwich> sandwiches = repository.getSandwiches();

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: shopHeaderStyle),
        actions: const [BasketButton()],
        // backgroundColor: const Color.fromARGB(255, 254, 74, 254),
      ),
      // backgroundColor: const Color.fromARGB(31, 243, 152, 250),
      body: ListView.builder(
        itemCount: sandwiches.length,
        itemBuilder: (BuildContext context, int index) {
          return SandwichCard(sandwich: sandwiches[index]);
        },
      ),
    );
  }
}
