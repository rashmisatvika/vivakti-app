import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vivakti_app/utils/constants.dart';
import 'package:vivakti_app/screens/home_screen.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({Key? key}) : super(key: key);

  @override
  State<CategorySelectionScreen> createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final List<String> _selectedCategories = [];
  final TextEditingController _searchController = TextEditingController();
  String _query = "";

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = Constants.categories
        .where((c) => c.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Constants.backgroundColor,
              Colors.white.withOpacity(0.9),
            ],
          ),
        ),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeumorphicButton(
                  onPressed: () => Navigator.pop(context),
                  style: NeumorphicStyle(
                    color: Colors.white,
                    depth: 4,
                    intensity: 0.5,
                    shape: NeumorphicShape.convex,
                  ),
                  child: const Icon(Icons.arrow_back, size: 20),
                ),
                const Text(
                  "Select Services",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Constants.textColor,
                  ),
                ),
                const SizedBox(width: 40), // Spacer for alignment
              ],
            ),

            const SizedBox(height: 20),

            // Search bar
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                decoration: const InputDecoration(
                  hintText: "Search services...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Categories list
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final category = filtered[index];
                  bool isSelected = _selectedCategories.contains(category);

                  return NeumorphicButton(
                    onPressed: () => _toggleCategory(category),
                    style: NeumorphicStyle(
                      color: isSelected ? Constants.primaryColor : Colors.white,
                      depth: 6,
                      intensity: 0.8,
                      shape: NeumorphicShape.convex,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_repair_service,
                            size: 30,
                            color: isSelected ? Colors.white : Constants.textColor,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            category,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Constants.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Continue button
            NeumorphicButton(
              onPressed: _selectedCategories.isEmpty
                  ? null
                  : () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
              style: NeumorphicStyle(
                color: Constants.primaryColor,
                depth: 8,
                intensity: 0.8,
                shape: NeumorphicShape.convex,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
