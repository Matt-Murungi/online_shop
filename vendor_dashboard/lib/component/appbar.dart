import 'package:flutter/material.dart';
import 'package:vendor_dashboard/component/navlinks.dart';
import 'package:vendor_dashboard/screens/home_screen.dart';
import 'package:vendor_dashboard/screens/store_screen.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: const Text("Admin Panel"),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NavLink(
            label: "My Orders",
            function: ()=> Navigator.pushNamed(context, HomeScreen.route),
          ),
          const SizedBox(
            width: 40,
          ),
          NavLink(
            label: "My Store",
            function: () => Navigator.pushNamed(context, StoreScreen.route),
          ),
          const SizedBox(
            width: 40,
          ),
        ],
      )
    ],
  );
}
