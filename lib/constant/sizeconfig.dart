import 'package:flutter/material.dart';

customYMargin(double value) {
  return SizedBox(height: value);
}

customXMargin(double value) {
  return SizedBox(width: value);
}

kwidth(double value, BuildContext context) {
  return MediaQuery.of(context).size.width * (value / 100);
}

kheight(double value, BuildContext context) {
  return MediaQuery.of(context).size.height * (value / 100);
}
