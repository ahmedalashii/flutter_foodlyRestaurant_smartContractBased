import 'food_item.dart';

class FoodCategory{
  late String title;
  List<FoodItem>? foodItems;

  FoodCategory({required this.title, this.foodItems});
}