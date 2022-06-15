import "package:flutter/material.dart";
import "../../constants/colors.dart" as colors;
import "../../constants/lists.dart" as lists;
import '../../widgets/restaurants_widget.dart';
import 'featured_partners.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late PageController _pageController;
  String dropDownValue = 'San Francisco';
  int _currentIndex = 2;

  bool isHomePageVisible = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colors.backgroundColor,
      body: Padding(
        padding: (isHomePageVisible)
            ? EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.055)
            : EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
        child: (isHomePageVisible)
            ? buildHomePage(context)
            : const FeaturedPartners(),
      ),
    );
  }

  Widget buildHomePage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            "Delivery to".toUpperCase(),
            style: const TextStyle(
              fontFamily: "Raleway",
              color: colors.buttonColorGreen,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                dropdownColor: colors.backgroundColor,
                underline: const SizedBox(),
                elevation: 0,
                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: colors.buttonColorGreen, size: 35),
                value: dropDownValue,
                items: lists.cities.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                        color: Colors.black87.withOpacity(0.8),
                        fontSize: 25,
                        fontFamily: "Raleway",
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValue = newValue!;
                  });
                },
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Filter",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    color: Colors.black87.withOpacity(0.8),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 1,
          ),
          const SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.24,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: lists.imagesList.length,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  onPageChanged: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(lists.imagesList[index]),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.1), BlendMode.darken),
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
                  right: 30, // Position from Right
                  child: SizedBox(
                    height: 15,
                    child: ListView.builder(
                      itemCount: lists.imagesList.length,
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
                              color: (_currentIndex == index)
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.5),
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
          const SizedBox(height: 10),
          buildTitle(context, "Featured Partners", "See all", onPressed: () {
            setState(() {
              isHomePageVisible = false;
            });
          }),
          const SizedBox(height: 10),
          buildListViewRestaurants(context, lists.featuredPartners),
          const SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.23,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage("assets/images/banner.png"),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.014), BlendMode.darken),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Free Delivery for\n1 Month!",
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "You've to order at least \$10 for\nusing free delivery for 1 month.",
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          buildTitle(context, "Best Picks\nRestaurants by team", "See all",
              onPressed: () {}),
          const SizedBox(height: 17),
          buildListViewRestaurants(context, lists.bestPicksRestaurantsByTeam),
          const SizedBox(height: 15),
          buildTitle(context, "All Restaurants", "See all", onPressed: () {}),
          const Restaurants(),
        ],
      ),
    );
  }

  Container buildListViewRestaurants(BuildContext context, List list) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      height: MediaQuery.of(context).size.height * 0.31,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          bool isItTheLastItem = index != list.length - 1;
          return GestureDetector(
            onTap: (){
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AddToOrder(
              //       foodItem: list[index],
              //     ),
              //   ),
              // );
            },
            child: Container(
              margin: (isItTheLastItem)
                  ? const EdgeInsets.only(right: 20)
                  : const EdgeInsets.only(right: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(list[index].imagePath),
                  const SizedBox(height: 15),
                  Text(
                    list[index].name,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontFamily: "Raleway"),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    list[index].shippingAddress,
                    style: const TextStyle(
                      color: colors.subTitleColor,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
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
                          list[index].review.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        list[index].preparationTime,
                        style: const TextStyle(
                            fontFamily: "Raleway",
                            color: colors.subTitleColor,
                            fontSize: 15),
                      ),
                      const SizedBox(width: 7),
                      (list[index].shippingPrice > 0)
                          ? const Icon(
                              Icons.attach_money_rounded,
                              size: 20,
                              color: Colors.grey,
                            )
                          : Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                      (list[index].shippingPrice > 0)
                          ? const SizedBox()
                          : const SizedBox(width: 5),
                      Text(
                        (list[index].shippingPrice > 0)
                            ? list[index].shippingPrice.toString()
                            : "Free Delivery",
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

  Padding buildTitle(BuildContext context, String leftText, String rightText,
      {required VoidCallback? onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Row(
        children: <Widget>[
          Text(
            leftText,
            style: const TextStyle(
              fontSize: 25,
              fontFamily: "Raleway",
              color: Colors.black87,
            ),
          ),
          Expanded(child: Container()),
          TextButton(
              child: Text(
                rightText,
                style: const TextStyle(
                  color: colors.buttonColorGreen,
                  fontFamily: "Raleway",
                  fontSize: 18,
                ),
              ),
              onPressed: onPressed),
        ],
      ),
    );
  }
}
