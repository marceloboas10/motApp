import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class CardFinancialWidget extends StatelessWidget {
  const CardFinancialWidget({
    super.key,
    required this.title,
    required this.price,
    required this.colorPrice,
  });

  final String title;
  final String price;
  final Color colorPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: LightColors.gray,
                  fontWeight: FontWeight.w500,
                ),
              ),
              FittedBox(
                child: Text(
                  price,
                  style: TextStyle(
                    color: colorPrice,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
