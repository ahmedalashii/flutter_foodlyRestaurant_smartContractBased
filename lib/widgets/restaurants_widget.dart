import "package:flutter/material.dart";
import "../constants/colors.dart" as colors;
import "../../constants/lists.dart" as lists;
import '../screens/app/single_restaurant.dart';

class Restaurants extends StatefulWidget {
  final bool reverse;

  const Restaurants({Key? key, this.reverse = false}) : super(key: key);

  @override
  State<Restaurants> createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: lists.restaurants.length,
        shrinkWrap: true,
        reverse: widget.reverse,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int itemIndex) {
          bool isItTheLastItem = itemIndex != lists.restaurants.length - 1;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleRestaurant(
                    restaurant: lists.restaurants[itemIndex],
                  ),
                ),
              );
            },
            child: Container(
              margin: (isItTheLastItem || widget.reverse)
                  ? const EdgeInsets.only(bottom: 15)
                  : const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller:
                              lists.restaurants[itemIndex].pageController,
                          itemCount:
                              lists.restaurants[itemIndex].mealsImages.length,
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          onPageChanged: (int index) {
                            setState(() {
                              lists.restaurants[itemIndex].currentImageIndex =
                                  index;
                            });
                          },
                          itemBuilder: (context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(lists.restaurants[itemIndex]
                                      .mealsImages[index]),
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 15, // Position form Bottom
                          right: 15, // Position from Right
                          child: SizedBox(
                            height: 15,
                            child: ListView.builder(
                              itemCount: lists
                                  .restaurants[itemIndex].mealsImages.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 3,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      color: (lists.restaurants[itemIndex]
                                                  .currentImageIndex ==
                                              index)
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    lists.restaurants[itemIndex].name,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontFamily: "Raleway"),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "\$\$",
                        style: TextStyle(
                          color: colors.subTitleColor,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(width: 5),
                      for (String foodKind
                          in lists.restaurants[itemIndex].foodKinds) ...[
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          foodKind,
                          style: const TextStyle(
                            color: colors.subTitleColor,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.normal,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: colors.buttonColorGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          lists.restaurants[itemIndex].reviewingAverage
                              .toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Icon(Icons.star_rounded,
                          color: colors.buttonColorGreen),
                      const SizedBox(width: 3),
                      Text(
                        lists.restaurants[itemIndex].numberOfReviews
                                .toString() +
                            "+ Ratings",
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 14,
                          color: Colors.black87.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Icon(Icons.access_time_filled_rounded,
                          color: Colors.grey),
                      const SizedBox(width: 10),
                      Text(
                        lists.restaurants[itemIndex].preparingAverageTime,
                        style: TextStyle(
                            fontFamily: "Raleway",
                            color: Colors.black87.withOpacity(0.7),
                            fontSize: 15),
                      ),
                      const SizedBox(width: 7),
                      const Icon(
                        Icons.monetization_on,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        (lists.restaurants[itemIndex].shippingPrice > 0)
                            ? lists.restaurants[itemIndex].shippingPrice
                                .toString()
                            : "Free",
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 14,
                          color: Colors.black87.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
