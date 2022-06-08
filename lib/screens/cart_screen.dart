import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loja_uzzubiju/models/cart_model.dart';
import 'package:loja_uzzubiju/models/user_model.dart';
import 'package:loja_uzzubiju/screens/login_screen.dart';
import 'package:loja_uzzubiju/tiles/cart_tile.dart';
import 'package:loja_uzzubiju/widgets/cart_price.dart';
import 'package:loja_uzzubiju/widgets/ship_cart.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/discount_cart.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Carrinho"),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
                builder: ((context, child, model) {
              int p = model.products.length;
              return Text(
                "$p ${p < 1 ? "item" : "itens"}",
                style: const TextStyle(fontSize: 17),
              );
            })),
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoadingIn()) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Faça o login para adicionar items ao carrinho",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "ENTRAR",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else if (model.products == null || model.products.length == 0) {
            return const Center(
              child: Text("Você não possui items no carrinho.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            );
          } else {
            return ListView(
              children: [
                Column(
                  children: model.products.map((products) {
                    return CartTile(cartProduct: products);
                  }).toList(),
                ),
                const DiscountCart(),
                const ShipCart(),
                CartPrice(buy: () async {
                  String orderId = await model.finishOder();
                  if (orderId != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OrderScreen(orderId: orderId)));
                  }
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
