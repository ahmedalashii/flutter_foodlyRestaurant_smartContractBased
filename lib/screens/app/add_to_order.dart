// ignore_for_file: prefer_const_constructors, prefer_final_fields

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "../../constants/colors.dart" as colors;
import '../../models/food_item.dart';
import '../../models/restaurant.dart';
import '../../widgets/choices_listView.dart';
import "../../constants/orders.dart" as orders;
import 'your_orders.dart';

class AddToOrder extends StatefulWidget {
  AddToOrder({Key? key, required this.foodItem, required this.restaurant})
      : super(key: key);

  late FoodItem foodItem;
  final Restaurant restaurant;
  @override
  State<AddToOrder> createState() => _AddToOrderState();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class _AddToOrderState extends State<AddToOrder> {
  int? _selected1stGroupValue = 0;
  int? _selected2ndGroupValue = 0;

  int numberOfOrders = 1;
  late double totalOrdersPrice;

  Color _statusBarColor = Colors.transparent;

  ScrollController _scrollController = ScrollController();
  late double _scrollPosition;

  void _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          setState(() {
            _statusBarColor = Colors.transparent;
          });
        }
      } else {
        setState(() {
          _statusBarColor = Colors.white;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    totalOrdersPrice = widget.foodItem.price;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // statusBarColor: _statusBarColor,
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colors.backgroundColor,
      body: buildAddToOrder(context),
    );
  }

  SingleChildScrollView buildAddToOrder(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      // controller: _scrollController,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.foodItem.imagePath),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.15), BlendMode.darken),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.055,
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.clear_rounded,
                          size: 25, color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.055),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.foodItem.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontFamily: "Raleway",
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.foodItem.description.capitalize(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "Raleway",
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: colors.buttonColorGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.foodItem.review.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Icon(Icons.access_time_filled_rounded,
                        color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(
                      widget.foodItem.preparationTime,
                      style: TextStyle(
                        fontFamily: "Raleway",
                        color: Colors.black87.withOpacity(0.7),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 7),
                    const Icon(
                      Icons.monetization_on,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      (widget.foodItem.shippingPrice > 0)
                          ? widget.foodItem.shippingPrice.toString()
                          : "Free",
                      style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 14,
                        color: Colors.black87.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                (widget.foodItem.additions!.isNotEmpty)
                    ? Row(
                        children: [
                          Text(
                            "Choice of top " +
                                widget.foodItem.name.split(" ")[
                                    widget.foodItem.name.split(" ").length - 1],
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Raleway",
                              color: Colors.black87,
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            width: 100,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Required".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Raleway",
                                  color: colors.requiredText,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: colors.requiredContainer.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                ChoicesList(
                    list: widget.foodItem.additions,
                    selectedGroupValue: _selected1stGroupValue),
                const SizedBox(height: 20),
                (widget.foodItem.additions!.isNotEmpty)
                    ? Row(
                        children: [
                          Text(
                            "Choice of bottom " +
                                widget.foodItem.name.split(" ")[
                                    widget.foodItem.name.split(" ").length - 1],
                            style: const TextStyle(
                              fontSize: 17,
                              fontFamily: "Raleway",
                              color: Colors.black87,
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            width: 100,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Required".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Raleway",
                                  color: colors.requiredText,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: colors.requiredContainer.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                ChoicesList(
                    list: widget.foodItem.additions,
                    selectedGroupValue: _selected2ndGroupValue),
                Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "Add Special Instructions",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Raleway",
                                color: Colors.black87.withOpacity(0.8),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black87.withOpacity(0.6),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      thickness: 1,
                      height: 5,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // we used here StatefulBuilder to set a specific setState to a specific widget (not the whole screen) ..
                StatefulBuilder(
                  builder: (BuildContext context,StateSetter state) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                state(() {
                                  if (numberOfOrders > 1) {
                                    numberOfOrders--;
                                    totalOrdersPrice -= widget.foodItem.price;
                                  }
                                });
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 35,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            Text(
                              numberOfOrders.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Raleway",
                                color: Colors.black87.withOpacity(0.8),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                state(() {
                                  numberOfOrders++;
                                  totalOrdersPrice += widget.foodItem.price;
                                });
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 35,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            // if the orders map doesn't contain the restaurant itself then add it ..
                            if (!orders.restaurantOrderedFoodItems
                                .containsKey(widget.restaurant)) {
                              orders.restaurantOrderedFoodItems[widget.restaurant] = {
                                widget.foodItem: numberOfOrders
                              };
                            } else {
                              // it contains the restaurant .. so check for FoodItem validity
                              // if the restaurant doesn't contain the foodItem then add it ..
                              if (!orders.restaurantOrderedFoodItems[widget.restaurant]!
                                  .containsKey(widget.foodItem)) {
                                orders.restaurantOrderedFoodItems[widget.restaurant]![
                                widget.foodItem] = numberOfOrders;
                              } else {
                                // if it contains the foodItem then check if it's the paid version (a past order) or just a new order ..
                                bool isPaidFound = false;
                                for (FoodItem item in orders
                                    .restaurantOrderedFoodItems[widget.restaurant]!
                                    .keys) {
                                  if (widget.foodItem.name == item.name) {
                                    if (!item.isPaid) {
                                      isPaidFound = false;
                                      setState(() {
                                        widget.foodItem = item;
                                      });
                                    } else {
                                      isPaidFound = true;
                                    }
                                  }
                                }

                                if (isPaidFound) {
                                  FoodItem foodItem = FoodItem(
                                      isPaid: false,
                                      additions: widget.foodItem.additions,
                                      description: widget.foodItem.description,
                                      foodKind: widget.foodItem.foodKind,
                                      price: widget.foodItem.price,
                                      preparationTime: widget.foodItem.preparationTime,
                                      shippingAddress: widget.foodItem.shippingAddress,
                                      shippingPrice: widget.foodItem.shippingPrice,
                                      review: widget.foodItem.review,
                                      name: widget.foodItem.name,
                                      imagePath: widget.foodItem.imagePath);
                                  orders.restaurantOrderedFoodItems[widget.restaurant]![
                                  foodItem] = numberOfOrders;
                                } else {
                                  orders.restaurantOrderedFoodItems[widget.restaurant]!
                                      .update(
                                      widget.foodItem,
                                          (oldNumberOfOrders) =>
                                      oldNumberOfOrders + numberOfOrders);
                                }
                              }
                            }
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    YourOrders(restaurant: widget.restaurant),
                              ),
                            );
                          },
                          child: Text(
                            "ADD TO ORDER (\$ " +
                                (totalOrdersPrice.toStringAsFixed(2)) +
                                ")",
                            style: TextStyle(
                              fontFamily: "Raleway",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.buttonColorGreen,
                            minimumSize: Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
