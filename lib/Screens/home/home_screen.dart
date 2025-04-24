import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:savory_book/screens/code_exractions/hardcord_retrieve.dart';
import 'package:savory_book/screens/code_exractions/home_db_retreive.dart';
import 'package:savory_book/screens/drawer/drawer_screen.dart';
import 'package:savory_book/screens/hardcoded/hardcoded_item.dart';
import 'package:savory_book/functions/db_function.dart';
import 'package:savory_book/model/food_model.dart';
import 'package:savory_book/model/user_model.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _openDrawerKey = GlobalKey<ScaffoldState>();
  final List<String> filters = ["All", "Breakfast", "Lunch", "Snack", "Dinner", "Drink"];
  final List<String> foodTypeFilters = ["All", "Veg", "Non-Veg"];
  final List<String> difficultyFilters = ["All", "Easy", "Medium", "Hard"];

  final _searchController = TextEditingController();

  String selectedItem = "All";
  String selectedFoodType = "All";
  String selectedDifficulty = "All";

  List<Food> filteredFoodList = [];
  List<Map<String, String>> hardcodedFilteredItems = [];
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    filteredFoodList = foodListNotifier.value;
    hardcodedFilteredItems = foodItems;
    _searchController.addListener(_filterItems);

    final settingsBox = Hive.box('settingsBox');
    isDarkMode = settingsBox.get('isDarkMode', defaultValue: false);

    settingsBox.listenable().addListener(() {
      final newDarkMode = settingsBox.get('isDarkMode');
      if (newDarkMode != isDarkMode) {
        setState(() {
          isDarkMode = newDarkMode;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterItems);
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final searchQuery = _searchController.text.toLowerCase();
    final foodList = foodListNotifier.value;
    final hardcodedList = foodItems;

    setState(() {
      filteredFoodList = foodList.where((food) {
        final matchesCategory = selectedItem == "All" || food.category == selectedItem;
        final matchesType = selectedFoodType == "All" || food.type.toLowerCase() == selectedFoodType.toLowerCase();
        final matchesDifficulty = selectedDifficulty == "All" || food.difficulty.toLowerCase() == selectedDifficulty.toLowerCase();
        final matchesSearch = food.title.toLowerCase().contains(searchQuery);
        return matchesCategory && matchesType && matchesDifficulty && matchesSearch;
      }).toList();

      hardcodedFilteredItems = hardcodedList.where((food) {
        final category = food["category"] ?? "";
        final type = food["type"] ?? "";
        final difficulty = food["difficulty"] ?? "";
        final name = food["name"] ?? "";
        final matchesCategory = selectedItem == "All" || category == selectedItem;
        final matchesType = selectedFoodType == "All" || type.toLowerCase() == selectedFoodType.toLowerCase();
        final matchesDifficulty = selectedDifficulty == "All" || difficulty.toLowerCase() == selectedDifficulty.toLowerCase();
        final matchesSearch = name.toLowerCase().contains(searchQuery);
        return matchesCategory && matchesType && matchesDifficulty && matchesSearch;
      }).toList();
    });
  }

  void category(String category) {
    setState(() {
      selectedItem = category;
    });
    _filterItems();
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select Food Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: foodTypeFilters.map((type) {
                    return ChoiceChip(
                      label: Text(type),
                      selected: selectedFoodType == type,
                      onSelected: (selected) {
                        setState(() {
                          selectedFoodType = type;
                        });
                        Navigator.pop(context);
                        _filterItems();
                      },
                      selectedColor: const Color(0xFF50606F),
                      labelStyle: TextStyle(
                        color: selectedFoodType == type
                            ? Colors.white
                            : isDarkMode ? Colors.white70 : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Text("Select Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: filters.map((filter) {
                    return ChoiceChip(
                      label: Text(filter),
                      selected: selectedItem == filter,
                      onSelected: (selected) {
                        setState(() {
                          selectedItem = filter;
                        });
                        Navigator.pop(context);
                        _filterItems();
                      },
                      selectedColor: const Color(0xFF50606F),
                      labelStyle: TextStyle(
                        color: selectedItem == filter
                            ? Colors.white
                            : isDarkMode ? Colors.white70 : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Text("Select Difficulty", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: difficultyFilters.map((level) {
                    return ChoiceChip(
                      label: Text(level),
                      selected: selectedDifficulty == level,
                      onSelected: (selected) {
                        setState(() {
                          selectedDifficulty = level;
                        });
                        Navigator.pop(context);
                        _filterItems();
                      },
                      selectedColor: const Color(0xFF50606F),
                      labelStyle: TextStyle(
                        color: selectedDifficulty == level
                            ? Colors.white
                            : isDarkMode ? Colors.white70 : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedItem = "All";
                        selectedFoodType = "All";
                        selectedDifficulty = "All";
                        _searchController.clear();
                      });
                      Navigator.pop(context);
                      _filterItems();
                    },
                    child: const Text(
                      "Clear Filters",
                      style: TextStyle(
                        color: Color(0xFF50606F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFD2AB94);
    final textColor = isDarkMode ? Colors.white : const Color(0xFF50606F);
    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      key: _openDrawerKey,
      drawer: DrawerWidget(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: const Color(0xFFD2AB94),
                elevation: 0,
                automaticallyImplyLeading: false,
                toolbarHeight: 80,
                title: Row(
                  children: [
                    Image.asset('assets/images/logo.png', height: 70),
                    const SizedBox(width: 5),
                    Text(
                      'SavoryBook',
                      style: TextStyle(
                        color: const Color(0xFF3E2723),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => _openDrawerKey.currentState?.openDrawer(),
                      child: Icon(Icons.menu_rounded, size: 40, color: textColor),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          cursorColor: textColor,
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Categories',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: textColor)),
                    const SizedBox(height: 10),
                    if (filteredFoodList.isEmpty && hardcodedFilteredItems.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text('No items found...',
                              style: TextStyle(fontSize: 18, color: textColor)),
                        ),
                      )
                    else ...[
                      HomeDbRetrieve(
                        selectedItem: selectedItem,
                        searchController: _searchController,
                      ),
                      HardcodeRetreive(hardcodedFilteredItems: hardcodedFilteredItems),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFilterBottomSheet(context),
        icon: Icon(Icons.filter_list, color: textColor),
        label: Text("Filter", style: TextStyle(color: textColor)),
        backgroundColor: cardColor,
      ),
    );
  }
}
