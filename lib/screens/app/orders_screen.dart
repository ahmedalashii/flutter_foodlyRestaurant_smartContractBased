import "package:flutter/material.dart";
import "../../constants/colors.dart" as colors;
import "../../constants/orders.dart" as orders;
import '../../models/food_item.dart';
import '../../models/restaurant.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Your Orders",
          style: TextStyle(
              fontFamily: "Raleway", fontSize: 21, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: colors.backgroundColor,
        elevation: 0,
      ),
      body: buildOrders(),
    );
  }

  SingleChildScrollView buildOrders() {
    int unpaidOrders = 0, paidOrders = 0;
    orders.restaurantOrderedFoodItems
        .forEach((Restaurant restaurant, Map<FoodItem, int> foodItems) {
      foodItems.forEach((FoodItem foodItem, int numberOfOrders) {
        if (!foodItem.isPaid) {
          unpaidOrders++;
        } else {
          paidOrders++;
        }
      });
    });
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: [
              Text("Unpaid Orders".toUpperCase(),
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 20,
                      color: Colors.grey.shade700)),
              Expanded(child: Container()),
              TextButton(
                style: TextButton.styleFrom(
                  primary: colors.buttonColorGreen,
                ),
                child: Text(
                  "Clear all".toUpperCase(),
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 16,
                      color: Colors.black87.withOpacity(0.8)),
                ),
                onPressed: () {
                  setState(() {
                    orders.restaurantOrderedFoodItems.forEach((Restaurant restaurant, Map<FoodItem,int> map) {
                      map.removeWhere((FoodItem item, int numberOfOrders) => !item.isPaid);
                    });
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          (unpaidOrders > 0)
              ? buildFoodItems(context, orders.restaurantOrderedFoodItems)
              : Center(
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/no-unpaid-orders.png"),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Paid Orders".toUpperCase(),
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 20,
                      color: Colors.grey.shade500)),
              Expanded(child: Container()),
              TextButton(
                  child: Text(
                    "Clear all".toUpperCase(),
                    style: const TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16,
                        color: Colors.black87),
                  ),
                  onPressed: () {
                    setState(() {
                      orders.restaurantOrderedFoodItems.forEach((Restaurant restaurant, Map<FoodItem,int> map) {
                        map.removeWhere((FoodItem item, int numberOfOrders) => item.isPaid);
                      });
                    });
                  }),
            ],
          ),
          const SizedBox(height: 10),
          (paidOrders > 0)
              ? buildFoodItems(context, orders.restaurantOrderedFoodItems,
                  paidOrders: true)
              : Center(
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/no-paid-orders.png"),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Column buildFoodItems(BuildContext context,
      Map<Restaurant, Map<FoodItem, int>> restaurantOrderedFoodItems,
      {bool paidOrders = false}) {
    Map<Restaurant, List<FoodItem>> itemsList = {};
    orders.restaurantOrderedFoodItems
        .forEach((Restaurant restaurant, Map<FoodItem, int> map) {
      itemsList.putIfAbsent(restaurant,
          () => []); // initialize restaurant and its food item list.
    });
    if (!paidOrders) {
      // adding distinct food items to itemsList
      orders.restaurantOrderedFoodItems
          .forEach((Restaurant restaurant, Map<FoodItem, int> foodItems) {
        foodItems.forEach((FoodItem foodItem, int numberOfOrders) {
          if (!foodItem.isPaid && !itemsList[restaurant]!.contains(foodItem)) {
            itemsList[restaurant]!.add(foodItem);
            debugPrint("Unpaid: " + itemsList[restaurant].toString());
          }
        });
      });
    } else {
      // adding distinct food items to itemsList
      orders.restaurantOrderedFoodItems
          .forEach((Restaurant restaurant, Map<FoodItem, int> foodItems) {
        foodItems.forEach((FoodItem foodItem, int numberOfOrders) {
          if (foodItem.isPaid && !itemsList[restaurant]!.contains(foodItem)) {
            itemsList[restaurant]!.add(foodItem);
            debugPrint("Paid: " +
                orders.restaurantOrderedFoodItems[restaurant]![foodItem]
                    .toString());
          }
        });
      });
    }
    // debugPrint((pastOrders)?"Paid: ":"Unpaid: " + itemsList.values.length.toString());
    return Column(
      children: [
        for (Restaurant restaurant in itemsList.keys)
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: itemsList[restaurant]!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AddToOrder(
                    //       foodItem: list[index],
                    //     ),
                    //   ),
                    // );
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.14,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    itemsList[restaurant]![index].imagePath),
                                colorFilter: (paidOrders)
                                    ? ColorFilter.mode(
                                        Colors.grey.withOpacity(1),
                                        BlendMode.hardLight)
                                    : ColorFilter.mode(
                                        Colors.black.withOpacity(0.07),
                                        BlendMode.darken),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    itemsList[restaurant]![index].name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Raleway",
                                      color: (paidOrders)
                                          ? Colors.black87.withOpacity(0.65)
                                          : Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    itemsList[restaurant]![index].description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Raleway",
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      const Text("\$\$",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: "Raleway")),
                                      const SizedBox(width: 10),
                                      Container(
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        restaurant.name,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: "Raleway",
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.027),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "USD " +
                                            itemsList[restaurant]![index]
                                                .price
                                                .toString(),
                                        style: TextStyle(
                                          fontFamily: "Raleway",
                                          color: (paidOrders)
                                              ? colors.buttonColorGreen
                                                  .withOpacity(0.7)
                                              : colors.buttonColorGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                );
              })
      ],
    );
  }
}
