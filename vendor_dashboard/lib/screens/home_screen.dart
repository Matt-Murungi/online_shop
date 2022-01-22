import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_dashboard/component/appbar.dart';

class HomeScreen extends StatelessWidget {
  static const route = 'home';

  final ref = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (_, index) {
                List cart = snapshot.data!.docs[index]['cart'];
            

                return Container(
                  margin: const EdgeInsets.all(5),

                  decoration: BoxDecoration(
                  color: Colors.grey[200],
                  
                  borderRadius: BorderRadius.circular(8)

                  ),
                  
                  child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (BuildContext context, idx) {
                    return ListTile(
                      key: ValueKey(cart[idx]),
                     
                      title: Text(cart[idx]['name']),
                      trailing: Text(cart[idx]['price']),
                    );
                  }),
                );
              },
              itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
            );
          }),
    );
  }
}
