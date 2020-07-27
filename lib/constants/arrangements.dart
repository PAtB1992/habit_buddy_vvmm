import 'package:flutter/material.dart';

// Box Decorations

BoxDecoration fieldDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: Colors.red,
);

BoxDecoration disabledFieldDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: Colors.grey[200],
);

// Field Variables

const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = const EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
    const EdgeInsets.symmetric(horizontal: 15, vertical: 15);

// Text Variables
const TextStyle buttonTitleTextStyle =
    const TextStyle(fontWeight: FontWeight.w700, color: Colors.white);
