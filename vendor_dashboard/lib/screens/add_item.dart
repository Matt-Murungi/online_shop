import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_dashboard/screens/login.dart';
import 'package:vendor_dashboard/screens/store_screen.dart';
import 'package:vendor_dashboard/utils/styles.dart';

class AddItem extends StatelessWidget {
  static const route = 'addItem';

  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('product');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ItemInput(
            controller: productName,
            label: "Item",
          ),
          ItemInput(
            controller: productPrice,
            label: "Price",
          ),
          ActionButton(
              buttonLabel: "Add",
              function: () {
                ref.add({
                  'name': productName.text,
                  'price': productPrice.text
                }).whenComplete(
                    () => Navigator.pushNamed(context, StoreScreen.route));
              })
        ],
      ),
    );
  }
}

class ItemInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  ItemInput({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
  
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          border: outlineInputBorderStyle,
        ),
      ),
    );
  }
}
