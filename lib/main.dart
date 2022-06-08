import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:loja_uzzubiju/models/cart_model.dart';
import 'package:loja_uzzubiju/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'screens/home_screen.dart';

/*Aplicação se trata de uma lojá virtual, atualmente adaptada para venda de bijuterias.
Até esse pnto do projeto, já está criada 90% da navagação entre tela, faltando apenas a 
navegação para verificar a status da compra, e a tela do carrinho. Já é possivel cadastrar 
os produtos manualmente no firebase.*/

Future<void> main() async {
  //Iniciarndo a conexão com o Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//Função principal STF para iniciar a aplicação.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    UserModel userModel = UserModel();
    return ScopedModel<UserModel>(
        model: userModel,
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return ScopedModel<CartModel>(
                model: CartModel(model),
                child: MaterialApp(
                  theme: ThemeData(
                    primarySwatch: Colors.pink,
                    primaryColor: const Color.fromARGB(255, 214, 21, 125),
                  ),
                  //comando para retirar a TAG de modo debug.
                  debugShowCheckedModeBanner: false,
                  //chamando a a home page.
                  home: HomeScreen(),
                ));
          },
        ));
  }
}
