import 'package:flutter/material.dart';

class RiskStatus extends StatelessWidget {
  const RiskStatus({
    super.key,
    this.riskDegree,
  });

  final int? riskDegree;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth - 80;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: containerWidth,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: containerWidth * ((riskDegree ?? 0) / 100),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red[700],
            ),
          ),
        ),
      ),
    );
  }
}
