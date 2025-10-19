import 'package:flutter/material.dart';

class StarsRating extends StatelessWidget {
  final double rate; // Avaliação do produto (0.0 - 5.0)

  const StarsRating(this.rate, {super.key});

  @override
  Widget build(BuildContext context) {
    int fullStars = rate.toInt(); // Parte inteira
    double partialStar = rate - fullStars; // Parte decimal

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          // Estrela cheia
          return Icon(Icons.star, color: Colors.amber);
        } else if (index == fullStars && partialStar > 0) {
          // Estrela parcialmente cheia
          return _estrelaParcial(partialStar);
        } else {
          // Estrela vazia
          return Icon(Icons.star_border, color: Colors.amber);
        }
      }),
    );
  }

  // Função para desenhar a estrela parcialmente preenchida
  Widget _estrelaParcial(double parte) {
    return Stack(
      children: [
        Icon(Icons.star_border, color: Colors.amber),
        ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: parte,
            child: Icon(Icons.star, color: Colors.amber),
          ),
        ),
      ],
    );
  }
}