import 'package:flutter/material.dart';
import 'package:loja_uzzubiju/tabs/orders_tab.dart';
import 'package:loja_uzzubiju/widgets/cart_button.dart';
import '../tabs/home_tab.dart';
import '../tabs/places_tab.dart';
import '../tabs/products_tab.dart';
import '../widgets/custon_drawer.dart';

//a HomeScreen possui uma PageView, com os repectivos conteudoes de cada item da
//Drawer, é exibido de acordo com a opção seleciando pelo usuário, para cada
//posição é chamda uma PAGE, HOMETAB, PRODUCTSTAB...

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          drawer: CustonDrawer(
            pageController: _pageController,
          ),
          body: const HomeTab(),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 214, 21, 125),
            title: const Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustonDrawer(
            pageController: _pageController,
          ),
          body: const ProductsTab(),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Nossas lojas"),
            centerTitle: true,
          ),
          drawer: CustonDrawer(
            pageController: _pageController,
          ),
          body: PlacesTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Meus Pedidos"),
            centerTitle: true,
          ),
          drawer: CustonDrawer(
            pageController: _pageController,
          ),
          body: const OrdersTab(),
        ),
      ],
    );
  }
}
