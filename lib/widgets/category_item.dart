import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/category.dart';
import '../screens/results_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        ResultsScreen.routeName,
        arguments: {'id': category.id, 'title': category.title},
      ),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: category.color.withValues(
            alpha: 0.15,
          ), // Soft pastel background
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: category.color.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // "Floating" Icon with shadow
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: category.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: category.color.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(category.icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              category.title,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
