import 'package:flutter/material.dart';

class BottomButtonWidget extends StatelessWidget {
  final bool isselected;
  final VoidCallback ontap;
  final Color selectedcolor;
  final Color unselectedcolor;
  final IconData icon;

  const BottomButtonWidget({
    super.key,
    required this.isselected,
    required this.ontap,
    required this.selectedcolor,
    required this.unselectedcolor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(20),
      child: Container(
        child: IconButton(
          onPressed: ontap,
          icon: Icon(icon, color: Colors.white),
        ),
        height: 40,
        width: 80,
        color: isselected ? selectedcolor : unselectedcolor,
      ),
    );
  }
}
