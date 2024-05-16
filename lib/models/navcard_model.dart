// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NavIcon {
  final IconData icon;
  final Color color;
  final IconData? activeIcon;
  final String? title;

  const NavIcon({
    required this.icon,
    required this.color,
    this.activeIcon,
    this.title,
  });
}
