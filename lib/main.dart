import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

// สร้างคลาส FoodMenu
class FoodMenu {
  final String name;
  final int price;
  final List<String> ingredients;

  FoodMenu({required this.name, required this.price, required this.ingredients});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // รายการ FoodMenu
  List<FoodMenu> _menuItems = [];

  final Random _random = Random();

  // ฟังก์ชันสร้างรายการอาหารแบบสุ่ม
  void _addNewMenu() {
    setState(() {
      // ข้อมูลตัวอย่างอาหาร
      List<String> dishes = ['Steak', 'Burger', 'Pasta', 'Pizza', 'Salad'];
      List<List<String>> ingredientsList = [
        ['Beef', 'Cheese', 'Potato'],
        ['Beef', 'Cheese', 'Bread'],
        ['Pasta', 'Cheese', 'Beef'],
        ['Cheese', 'Tomato', 'Bread'],
        ['Lettuce', 'Tomato', 'Cucumber']
      ];

      int index = _random.nextInt(dishes.length);
      int price = (_random.nextInt(5) + 1) * 50; // ราคาสุ่ม (50, 100, 150, ...)
      _menuItems.add(
        FoodMenu(
          name: dishes[index],
          price: price,
          ingredients: ingredientsList[index],
        ),
      );
    });
  }

  // คำนวณราคารวม
  int get _totalPrice => _menuItems.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Total Price: \$$_totalPrice'),
      ),
      body: Center(
        child: _menuItems.isEmpty
            ? const Text('No menu items yet! Click + to add one.')
            : ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  FoodMenu menu = _menuItems[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        '${menu.price}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('Dish $index is ${menu.name}'),
                    subtitle: Text(
                        'This menu ingredients are ${menu.ingredients.join(', ')}'),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewMenu,
        tooltip: 'Add Menu Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
