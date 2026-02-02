import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;
  final IconData icon;

  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
    this.icon = Icons.category,
  });
}

const dummyCategories = [
  Category(
    id: 'c1',
    title: 'Mountains',
    color: Colors.purple,
    icon: Icons.terrain,
  ),
  Category(
    id: 'c2',
    title: 'Beaches',
    color: Colors.red,
    icon: Icons.beach_access,
  ),
  Category(id: 'c3', title: 'Forests', color: Colors.orange, icon: Icons.park),
  Category(
    id: 'c4',
    title: 'Cities',
    color: Colors.amber,
    icon: Icons.location_city,
  ),
  Category(
    id: 'c5',
    title: 'Deserts',
    color: Colors.blue,
    icon: Icons.wb_sunny,
  ),
  Category(id: 'c6', title: 'Snow', color: Colors.green, icon: Icons.ac_unit),
  Category(
    id: 'c7',
    title: 'Lakes',
    color: Colors.lightBlue,
    icon: Icons.water,
  ),
  Category(
    id: 'c8',
    title: 'Jungles',
    color: Colors.lightGreen,
    icon: Icons.grass,
  ),
  Category(
    id: 'c9',
    title: 'Historical',
    color: Colors.pink,
    icon: Icons.history_edu,
  ),
  Category(
    id: 'c10',
    title: 'Summer',
    color: Colors.teal,
    icon: Icons.umbrella,
  ),
];
