import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/filters_screen.dart';
import '../screens/ai_planner_screen.dart';
import '../screens/ai_chat_screen.dart';
import '../screens/ai_image_screen.dart';
import '../providers/theme_provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback tapHandler, {
    bool isSelected = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: isSelected
            ? colorScheme.primaryContainer.withValues(alpha: 0.2)
            : null,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.1)
                : colorScheme.surfaceVariant.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 22,
            color: isSelected
                ? colorScheme.primary
                : colorScheme.onSurface.withValues(alpha: 0.75),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.chevron_right, size: 18, color: colorScheme.primary)
            : null,
        onTap: tapHandler,
        hoverColor: colorScheme.primary.withValues(alpha: 0.05),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
    return Drawer(
      width: 280,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Custom Header (clipped and using DrawerHeader to avoid overflow issues)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
              ),
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.primary, colorScheme.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.travel_explore_rounded,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trip Guide',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Your journey starts here',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ),
            ),

            const SizedBox(height: 16),

            // Main Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                'MENU',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                  letterSpacing: 1.2,
                ),
              ),
            ),

            buildListTile(
              context,
              'Explore Trips',
              Icons.map_outlined,
              () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              isSelected: currentRoute == '/',
            ),
            buildListTile(
              context,
              'Filters',
              Icons.tune_rounded,
              () {
                Navigator.of(context).pushReplacementNamed(
                  FiltersScreen.routeName,
                );
              },
              isSelected: currentRoute == FiltersScreen.routeName,
            ),
 
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              child: Text(
                'AI TOOLS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                  letterSpacing: 1.2,
                ),
              ),
            ),
 
            buildListTile(
              context,
              'AI Planner',
              Icons.smart_toy_outlined,
              () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => const AiPlannerScreen(),
                );
              },
            ),
            buildListTile(
              context,
              'Assistant',
              Icons.chat_bubble_outline_rounded,
              () {
                Navigator.of(context).pushNamed(AIChatScreen.routeName);
              },
            ),
            buildListTile(
              context,
              'Smart Camera',
              Icons.camera_alt_outlined,
              () {
                Navigator.of(context).pushNamed(AIImageScreen.routeName);
              },
            ),

            // Footer / Settings
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SwitchListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      title: const Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      secondary: Icon(
                        themeProvider.isDarkMode
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        size: 20,
                        color: colorScheme.primary,
                      ),
                      value: themeProvider.isDarkMode,
                      onChanged: (value) => themeProvider.toggleTheme(value),
                      activeColor: colorScheme.primary,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
