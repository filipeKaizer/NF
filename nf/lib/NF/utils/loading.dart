import 'package:flutter/material.dart';
import 'package:nf/settings.dart';

class Loading extends StatelessWidget {
  final IconData iconData;
  final String text;
  const Loading({required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white60, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: 100, color: Settings.TextColor),
            const SizedBox(height: 20),
            Text(
              text,
              style: TextStyle(
                color: Settings.TextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
