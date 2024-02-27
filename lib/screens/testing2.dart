import 'package:flutter/material.dart';

class DisplaySelected extends StatefulWidget {
  const DisplaySelected({Key? key});

  @override
  State<DisplaySelected> createState() => _DisplaySelectedState();
}

class _DisplaySelectedState extends State<DisplaySelected> {
  String businessType = "restaurent";
  bool isYesSelected = true;

  void updateSelection(bool isSelected) {
    setState(() {
      isYesSelected = isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100),
            Visibility(
              visible: businessType == "restaurent",
              child: Column(
                children: [
                  Restaurent(
                    isSelected: isYesSelected,
                    onTap: updateSelection,
                  ),
                  Restaurent2(),
                ],
              ),
            ),
            Visibility(
              visible: businessType == "barber",
              child: Column(
                children: [
                  Barber(),
                  Barber2(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Restaurent extends StatelessWidget {
  final bool isSelected;
  final Function(bool) onTap;

  const Restaurent({
    Key? key,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onTap(true),
          child: Text(
            "yes",
            style: TextStyle(color: isSelected ? Colors.green : Colors.grey),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () => onTap(false),
          child: Text(
            "no",
            style: TextStyle(color: isSelected ? Colors.grey : Colors.green),
          ),
        ),
      ],
    );
  }
}

class Restaurent2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("restaurent2 widget");
  }
}

class Barber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("barber widget");
  }
}

class Barber2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("barber2 widget");
  }
}
