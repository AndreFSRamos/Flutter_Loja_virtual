import 'package:flutter/material.dart';
import 'package:loja_uzzubiju/tiles/drawer_tile.dart';

// Widget "CustonDrawer" é responsavel pela contrução da tela de munu (DRAWER),
// ela contem cada opção do munu, porem as cunfuionalidades são responsabulidade
// da widget "DrawerTile". Essa widget recebe da widget "HomeScreen" por parametro
// a controler "pageContreller", para auxilar no escolha das pages.

class CustonDrawer extends StatelessWidget {
  const CustonDrawer({Key? key, required this.pageController})
      : super(key: key);

  final PageController pageController;
//================= INICIO DO CORPO DA DRAWER =================================
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 247, 131, 195), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
    return Drawer(
      child: Stack(
        children: [
          _buildBodyBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 8,
                      left: 8,
                      child: Text(
                        'UZZUBIJU',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Olá",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            child: Text(
                              "Entre ou cadastre-se >",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Opção do menu, INICIO, PRODUTOS, LOJAS e MEUS PEDIDOS. Cada opção
              //chama o widget "DrawerTile" para que seja craiada os efeitos de
              //click e mudançãs de cores.e passa por parametro, um icone, text,
              // a controller, a numero da pagina (Numero da paigina tem que iniciar
              // 0), atraz
              const Divider(),
              DrawerTile(
                icon: Icons.home,
                text: "Inicio",
                pageController: pageController,
                page: 0,
              ),
              DrawerTile(
                icon: Icons.list,
                text: "Produtos",
                pageController: pageController,
                page: 1,
              ),
              DrawerTile(
                icon: Icons.location_on,
                text: "Lojas",
                pageController: pageController,
                page: 2,
              ),
              DrawerTile(
                icon: Icons.playlist_add_check,
                text: "Meus pedidos",
                pageController: pageController,
                page: 3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
