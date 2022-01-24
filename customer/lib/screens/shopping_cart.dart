import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/screens/order_received.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  CollectionReference ref = FirebaseFirestore.instance.collection('orders');
  @override
  Widget build(BuildContext context) {
    List cart = ModalRoute.of(context)!.settings.arguments as List;
    List<int> priceList = cart.map((item) => int.parse(item['price'])).toList();
    var total = priceList.reduce((value, element) => value + element);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(),
          Container(
              height: MediaQuery.of(context).size.height / 1.7,
              child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (BuildContext context, index) {
                    return Column(
                      children: [
                        ListTile(
                          key: ValueKey(cart[index]),
                          trailing: InkWell(
                              onTap: () {
                                if (cart.isNotEmpty) {
                                  setState(() {
                                    cart.removeAt(index);
                                  });
                                }
                              },
                              child: const Icon(Icons.delete)),
                          title: Text(cart[index]['name'], 
                          style: const TextStyle(fontWeight: FontWeight.w800,
                          color: Colors.black45
                          ),
                          
                          ),
                          subtitle: Text(cart[index]['price']),
                        ),
                      const  Divider(),
                      ],
                    );
                  })),
          const SizedBox(
            height: 40,
          ),
          Text("Total: $total", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),),
               const SizedBox(
            height: 40,
          ),
          ActionButton(
            label: "Checkout",
            function: () {
              ref.add({'cart': cart}).whenComplete(
                  () => Navigator.pushNamed(context, OrderReceived.route));
            },
          )
        ],
      )),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback function;

  ActionButton({required this.label, required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: Text(label,
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),),
    );
  }
}
