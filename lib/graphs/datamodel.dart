import 'package:backendapp/widgets/linechart.dart';
import 'package:flutter/material.dart';

class line extends StatefulWidget {
  const line({super.key});

  @override
  State<line> createState() => _lineState();
}

class _lineState extends State<line> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        // Expanded(child: BusinessLineChart(yaxis: "reviews")),
        // Expanded(child: BusinessLineChart(yaxis: "Rating"))
      ]),
    );
  }
}