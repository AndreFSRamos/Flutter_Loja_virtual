import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'circular_indicator.dart';

class TypePayment extends StatefulWidget {
  const TypePayment({Key? key}) : super(key: key);

  @override
  State<TypePayment> createState() => _TypePaymentState();
}

String typePayment = "";

class _TypePaymentState extends State<TypePayment> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection("patment").doc().get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularIndicator();
        } else {
          return SizedBox(
              height: 36,
              child: GridView(
                padding: const EdgeInsets.symmetric(vertical: 4),
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.5),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                      border: Border.all(
                          //color: optionTypePayment == widget.typePayment
                          color: Theme.of(context).primaryColor,
                          width: 3),
                    ),
                    width: 50,
                    alignment: Alignment.center,
                  ),
                ],
              ));
        }
      },
    );
  }
}
