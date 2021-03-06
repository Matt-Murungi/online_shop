import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/screens/shopping_cart.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

int cartCount = 0;

class _HomeState extends State<Home> {
  final ref = FirebaseFirestore.instance.collection('product');
  

  List cartItems = [];
  
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        cartCount = 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Online Katale"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShoppingCart(),
                    settings:
                        RouteSettings(arguments: cartItems)),
              );
            },
            child: const Icon(Icons.shopping_cart),
          ),
          Text('${cartItems.length}')
        ],
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    Map item = {
                      'name': snapshot.data!.docs[index]['name'],
                      'price': snapshot.data!.docs[index]['price']
                    };
                    cartItems.add(item);

                    setState(() {
                      cartCount = cartItems.length;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    color: Colors.grey[100],
                    height: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          snapshot.data!.docs[index]['name'],
                          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          snapshot.data!.docs[index]['price'],
                         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
            );
          }),
    );
  }
}
