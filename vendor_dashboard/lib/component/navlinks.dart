import 'package:flutter/material.dart';

class NavLink extends StatelessWidget {
  final String label;
  final Function()? function;

  NavLink({required this.label, this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function ,
      child: Text(label, style: const TextStyle(
        fontWeight: FontWeight.w700
      ),),
      );
  }
}