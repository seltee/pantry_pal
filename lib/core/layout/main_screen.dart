import 'package:flutter/material.dart';
import 'package:pantry_pal/features/dashboard/presentation/dashboard_screen.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_add_screen.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_items_screen.dart';
import 'package:pantry_pal/features/settings/presentation/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const PantryItemsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Pantry Pal',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.merge(TextStyle(fontSize: 24)),
          ),
        ),
      ),
      body: IndexedStack(
        // This keeps state when switching tabs
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PantryAddScreen()),
          );
        },
        child: SizedBox(
          width: 20,
          height: 20,
          child: const Icon(Icons.add, size: 20),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2, size: 28),
            label: 'My Pantry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 28),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
