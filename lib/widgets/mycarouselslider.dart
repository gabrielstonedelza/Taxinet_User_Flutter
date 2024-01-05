import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyCarouselComponent extends StatelessWidget {
  const MyCarouselComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://taxinetghana.xyz/media/cars_initial_pics/Lexus-TX-2024-1280-01.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://taxinetghana.xyz/media/cars_initial_pics/BMW-iX1_eDrive20-2024-1280-01.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://taxinetghana.xyz/media/cars_initial_pics/Cadillac-XT4-2024-1280-01.jpg"),
                    fit: BoxFit.cover)),
          ),
        ],
        options: CarouselOptions(
          height: 180,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ));
  }
}
