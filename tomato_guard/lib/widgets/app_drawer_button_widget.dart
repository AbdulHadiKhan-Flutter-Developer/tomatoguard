import 'package:flutter/material.dart';
import 'package:tomato_guard/utils/app_constant.dart';

class AppDrawerButtonWidget extends StatelessWidget {
  final String text;
  final Color selectedcolor;
  final Color unselectedcolor;
  final Color iconselectedcolor;
  final bool isselected;
  final VoidCallback ontap;
  final IconData icon;

  const AppDrawerButtonWidget({
    super.key,
    required this.text,
    required this.selectedcolor,
    required this.unselectedcolor,
    required this.iconselectedcolor,
    required this.isselected,
    required this.ontap,

    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(25),
        child: GestureDetector(
          onTap: ontap,

          child: Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Icon(icon, color: Colors.white),
                ),
                SizedBox(width: 6),

                Text(
                  text,
                  style: TextStyle(
                    fontFamily: AppConstant.boldfontheading,
                    color: AppConstant.container,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_right,
                  color: isselected ? iconselectedcolor : AppConstant.heading,
                ),
              ],
            ),
            height: 50,
            width: double.infinity,
            color: isselected ? selectedcolor : unselectedcolor,
          ),
        ),
      ),
    );
  }
}
