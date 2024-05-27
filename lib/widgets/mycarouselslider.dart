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
                        "https://taxinetghana.xyz/media/cars_initial_pics/Toyota-Yaris-2017-1280-02.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://taxinetghana.xyz/media/cars_initial_pics/Hyundai-Elantra-2024-1280-02.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://taxinetghana.xyz/media/cars_initial_pics/Mitsubishi-XFC_Concept-2022-1280-04.jpg"),
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
