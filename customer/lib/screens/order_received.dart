import 'package:customer/screens/home_screen.dart';
import 'package:customer/screens/shopping_cart.dart';
import 'package:flutter/material.dart';

class OrderReceived extends StatelessWidget {
static const route = 'order received';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Your order has been received"),
         const  SizedBox(height: 30,),
          Center(
            child: ActionButton(label: "Go back to shopping", function: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                ) ),
          )
        ],
      ),
    );
  }
}