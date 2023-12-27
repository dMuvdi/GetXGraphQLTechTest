import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key, this.onChanged, this.value, required this.items, this.hintText, this.borderColor, this.fillColor});

  final void Function(String?)? onChanged;
  final String? value;
  final List<String> items;
  final String? hintText;
  final Color? borderColor;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      padding: const EdgeInsets.only(left: 20.0, top: 7.0, bottom: 5.0, right: 10.0),
      decoration: BoxDecoration(
        color: fillColor ?? const Color(0xFFFFE1E1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          hint: Text(
            hintText ?? 'Selecciona una opción',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF3F3F3F),
            ),
          ),
          onChanged: onChanged,
          value: value,
          icon: const Icon(Icons.expand_more, color: Color(0xFF3F3F3F), size: 35,),
          items: items
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, 
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3F3F3F),
                ),
              ),
            );
          }).toList(),
          isExpanded: true,
        ),
      ),
    );
  }
}