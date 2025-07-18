import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tomato_guard/utils/app_constant.dart';

class CarousalSlider extends StatefulWidget {
  const CarousalSlider({super.key});

  @override
  State<CarousalSlider> createState() => _CarousalSliderState();
}

class _CarousalSliderState extends State<CarousalSlider> {
  int _currentindex = 0;
  final List<String> imageList = [
    'assets/images/leaf1.png',
    'assets/images/leaf2.png',
    'assets/images/leaf3.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageList.map((imagepath) {
            return ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: Image.asset(
                imagepath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 150,
            enlargeCenterPage: true,
            autoPlay: true,
            // enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentindex = index;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.asMap().entries.map((entry) {
            return Container(
              height: 8,
              width: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentindex == entry.key
                    ? AppConstant.heading
                    : AppConstant.container,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
