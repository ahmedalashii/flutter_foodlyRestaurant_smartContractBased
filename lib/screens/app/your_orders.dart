import "package:flutter/material.dart";
import 'package:foodly/screens/app/add_to_order.dart';
import "../../constants/colors.dart" as colors;
import '../../models/food_item.dart';
import "../../constants/orders.dart" as orders;
import '../../models/restaurant.dart';
import '../../widgets/alert_dialog.dart';
import 'payment_methods.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key? key, required this.restaurant}) : super(key: key);

  final Restaurant restaurant;

  @override
  State<YourOrders> createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  final double vatPercent = 16;

  late int selectedOrder;
  bool wannaDelete = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
        title: const Text(
          "Your Orders",
          style: TextStyle(
              color: Colors.black87, fontSize: 20, fontFamily: "Raleway"),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: (orders.restaurantOrderedFoodItems[widget.restaurant]!.isNotEmpty)
          ? buildYourOrders(context)
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
    );
  }

  SingleChildScrollView buildYourOrders(BuildContext context) {
    setState(() {});
    double subTotal = 0;
    double delivery = 0;
    orders.restaurantOrderedFoodItems[widget.restaurant]!
        .forEach((FoodItem item, int numberOfOrders) {
      if (!item.isPaid) {
        subTotal += (item.price * numberOfOrders);
        delivery =
            (delivery < item.shippingPrice) ? item.shippingPrice : delivery;
      }
    });
    double totalWithVatAndDelivery =
        subTotal + (subTotal * (vatPercent / 100)) + delivery;
    setState(() {});
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildOrdersList(),
            Row(
              children: [
                const Text(
                  "Subtotal",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontFamily: "Raleway"),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  "\$" + subTotal.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontFamily: "Raleway",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  "Delivery",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontFamily: "Raleway"),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  "\$" + delivery.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontFamily: "Raleway",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Total (incl. VAT = $vatPercent%)",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 21,
                      fontFamily: "Raleway"),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  "\$" + totalWithVatAndDelivery.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontFamily: "Raleway",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const Text(
                      "Add more items",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Raleway",
                        color: colors.buttonColorGreen,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black87.withOpacity(0.7),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 1,
              height: 3,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const Text(
                      "Promo code",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Raleway",
                        color: Colors.black87,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black87.withOpacity(0.7),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 1,
              height: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (totalWithVatAndDelivery > 0) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentMethods(
                        vatPercent: vatPercent,
                        restaurant: widget.restaurant,
                      ),
                    ),
                  );
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => const MyAlertDialog(
                        title: "You don't have any order yet to pay for!",
                        subTitle:
                            'Keep browsing and add orders to the card to pay for them when available.',
                        circleIcon: Icons.clear_rounded,
                        circleColor: Colors.red),
                  );
                }
              },
              child: Text(
                "CONTINUE (\$ " +
                    (totalWithVatAndDelivery.toStringAsFixed(2)) +
                    ")",
                style: const TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: colors.buttonColorGreen,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  ListView buildOrdersList() {
    Map<FoodItem, int> unpaidOrders = {};
    for (FoodItem foodItem
        in orders.restaurantOrderedFoodItems[widget.restaurant]!.keys) {
      if (!foodItem.isPaid && !unpaidOrders.containsKey(foodItem)) {
        unpaidOrders[foodItem] =
            orders.restaurantOrderedFoodItems[widget.restaurant]![foodItem]!;
      }
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: unpaidOrders.length,
        itemBuilder: (BuildContext context, int index) {
          bool isItThelastItem =
              (index == unpaidOrders.keys.toList().length - 1);
          FoodItem foodItem = unpaidOrders.keys.toList()[index];
          return InkWell(
            onTap: () {
              setState(() {
                if (wannaDelete) {
                  wannaDelete = false;
                }
              });
            },
            onLongPress: () {
              setState(() {
                if (wannaDelete) {
                  wannaDelete = false;
                } else {
                  selectedOrder = index;
                  wannaDelete = true;
                }
              });
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        width: 32,
                        height: 32,
                        child: Center(
                          child: Text(
                            unpaidOrders.values.toList()[index].toString(),
                            style: const TextStyle(
                                color: colors.buttonColorGreen,
                                fontSize: 18,
                                fontFamily: "Raleway"),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  unpaidOrders.keys
                                      .toList()[index]
                                      .name
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                      fontFamily: "Raleway"),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  "\$" +
                                      (unpaidOrders.keys.toList()[index].price *
                                              unpaidOrders.values
                                                  .toList()[index])
                                          .toStringAsFixed(2),
                                  style: const TextStyle(
                                      color: colors.buttonColorGreen,
                                      fontSize: 18,
                                      fontFamily: "Raleway"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            (wannaDelete && selectedOrder == index)
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (orders.restaurantOrderedFoodItems[
                                                widget.restaurant]![foodItem]! >
                                            1) {
                                          orders.restaurantOrderedFoodItems[
                                                  widget.restaurant]!
                                              .update(foodItem,
                                                  (value) => value - 1);
                                        } else if (orders
                                                    .restaurantOrderedFoodItems[
                                                widget.restaurant]![foodItem] ==
                                            1) {
                                          orders.restaurantOrderedFoodItems[
                                                  widget.restaurant]!
                                              .remove(foodItem);
                                          if (orders
                                              .restaurantOrderedFoodItems[
                                                  widget.restaurant]!
                                              .isEmpty) {
                                            Navigator.pop(context);
                                          }
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Icon(
                                            Icons.delete,
                                            color: colors.buttonColorGreen,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade100,
                                      ),
                                    ),
                                  )
                                : Text(
                                    orders
                                        .restaurantOrderedFoodItems[
                                            widget.restaurant]!
                                        .keys
                                        .toList()[index]
                                        .description
                                        .capitalize(),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Raleway",
                                      color: Colors.black54,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  height: 3,
                ),
                (isItThelastItem)
                    ? const SizedBox(height: 20)
                    : const SizedBox(),
              ],
            ),
          );
        });
  }
}
