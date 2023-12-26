import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.name,
    required this.imageURL,
    this.onTap,
  });

  final String name;
  final String imageURL;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2A2A2A).withOpacity(0.8),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
            image: NetworkImage(imageURL),
            fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: Text(
            name,
            textAlign: TextAlign.center, 
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 30, 
              fontWeight: FontWeight.w600
            )
          )
        ),
      ),
    );
  }
}