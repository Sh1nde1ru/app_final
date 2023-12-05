import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    required this.child,
    required this.height,
    required this.width,
  });
  final child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade200,
            borderRadius: BorderRadius.circular(12),
            /*boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 15,
                  offset: const Offset(5, 5)),
              const BoxShadow(
                  color: Colors.white, blurRadius: 15, offset: Offset(-5, -5))
            ],*/
          ),
          child: Center(
            child: child,
          )),
    );
  }
}
