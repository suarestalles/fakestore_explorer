import 'package:flutter/material.dart';
import 'package:get/get.dart';

final double defaultPadding = 8.0;

final InputDecoration inputDecoration = InputDecoration(
  labelText: 'Search...',
  labelStyle: TextStyle(
    color: Get.theme.primaryColor,
    fontSize: 16,
  ),
  hintText: 'Search by ...',
  hintStyle: TextStyle(color: Colors.grey[400]),
  prefixIcon: Icon(
    Icons.search,
    color: Get.theme.primaryColor,
  ),
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Get.theme.primaryColor, width: 1.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
);