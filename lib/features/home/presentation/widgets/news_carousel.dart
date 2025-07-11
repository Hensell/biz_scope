import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

part 'news_card.dart';
part 'news_model.dart';

class NewsCarousel extends StatelessWidget {
  const NewsCarousel({super.key});

  static final List<BranchNews> newsItems = [
    BranchNews(
      branch: 'Chinandega',
      message:
          'Chinandega creció 15% en colocaciones y atendió a 120 nuevos microempresarios, superando su meta trimestral.',
      growth: 0.15,
    ),
    BranchNews(
      branch: 'León',
      message:
          'León sumó 9% más clientes este trimestre y realizó 8 ferias financieras, con el 60% de contratos gestionados digitalmente.',
      growth: 0.09,
    ),
    BranchNews(
      branch: 'Estelí',
      message:
          'Estelí bajó su morosidad un 12%, regularizando a más de 50 familias y logrando récord de cartera sana en la región norte.',
      growth: 0.12,
      positive: true,
    ),
    BranchNews(
      branch: 'Granada',
      message:
          'Granada sostuvo la cartera con solo -3% de variación, apoyando a emprendedores turísticos y manteniendo alta satisfacción.',
      growth: -0.03,
    ),
    BranchNews(
      branch: 'Oriental',
      message:
          'Oriental lideró con +22% en colocaciones, más de 1,000 créditos otorgados y el 70% de trámites digitalizados.',
      growth: 0.22,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: newsItems.length,
      options: CarouselOptions(
        height: 250,
        enlargeCenterPage: true,
        viewportFraction: 0.87,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        scrollPhysics: const BouncingScrollPhysics(),
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
      itemBuilder: (context, index, realIdx) {
        final item = newsItems[index];
        return NewsCard(item: item);
      },
    );
  }
}
