import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_dashboard/component/appbar.dart';
import 'package:vendor_dashboard/screens/add_item.dart';

class StoreScreen extends StatelessWidget {
  static const route = 'storeScreen';

  final ref = FirebaseFirestore.instance.collection('product');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
             
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    ListTile(
                     
                          leading:Text(
                            snapshot.data!.docs[index]['name'],
                          ),
                         
                         trailing: Text(
                            snapshot.data!.docs[index]['price'],
                          )
                        
                      
                    ),
                    Divider()
                  ],
                );
              },
              itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, AddItem.route),
      ),
    );
  }
}
