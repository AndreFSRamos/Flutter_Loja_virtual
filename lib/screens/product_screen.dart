import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_uzzubiju/datas/products_data.dart';

// Products Screenn é a page de compra do item, ela recebe por parametro o item
// em questão, é contruida por uma carosel de imagem do item, valor, titulo, descrição
// opção de escolha de tamanho do item, descrição e o botão de adicionar ao carrinho.

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, required this.data}) : super(key: key);

  final ProductsData data;

  //variavael "size" auxiliar do efeito de desabilitar  e habilitar o botão de
  //adicionar o carrinho.
  String size = "";

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.title),
        centerTitle: true,
      ),
      //Utilizando ListView para criar uma rolagem da tela.
      body: ListView(
        children: [
          //========== INICIO DO CAROSEL DAS IMAGENS ==========================
          AspectRatio(
            aspectRatio: 1,
            child: CarouselSlider(
              items: widget.data.images.map((url) {
                return Builder(
                  builder: (context) {
                    return Image.network(
                      url,
                      fit: BoxFit.cover,
                    );
                  },
                );
              }).toList(),
              options:
                  CarouselOptions(height: MediaQuery.of(context).size.height),
            ),
          ),
          //================ TITULO E VALOR DO ITEM ============================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.data.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "R\$ ${widget.data.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                const SizedBox(
                  height: 16,
                ),
                //=================== OPÇÃO DE ESCOLHER O TAMANHO ==============
                const Text(
                  "Temanho",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 36,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.5),
                    children: widget.data.size.map((optionSize) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.size = optionSize;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                            border: Border.all(
                                color: optionSize == widget.size
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                                width: 3),
                          ),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(optionSize),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                //================= BOTÃO ======================================
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: widget.size != "" ? () {} : null,
                    child: const Text(
                      "Adicionar ao carrinho",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Descrição",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.data.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
