import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final int maxRating;
  final Color filledStarColor;
  final Color unfilledStarColor;

  StarRating({
    required this.rating,
    this.maxRating = 5,
    this.filledStarColor = Colors.orange,
    this.unfilledStarColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(maxRating, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
            ),
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.star,
              color: index < rating ? filledStarColor : unfilledStarColor,
              size: 24,
            ),
          ),
        );
      }),
    );
  }
}
