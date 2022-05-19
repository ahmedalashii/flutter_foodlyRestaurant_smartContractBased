import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "../../constants/colors.dart" as colors;
import '../../models/food_category.dart';
import '../../models/restaurant.dart';
import 'add_to_order.dart';

class SingleRestaurant extends StatefulWidget {
  const SingleRestaurant({Key? key, required this.restaurant})
      : super(key: key);

  final Restaurant restaurant;

  @override
  State<SingleRestaurant> createState() => _SingleRestaurantState();
}

class _SingleRestaurantState extends State<SingleRestaurant> {
  int selectedIndex = 0;
  late FoodCategory selectedCategory;

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
    selectedCategory = widget.restaurant.categories[0]; // at first
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: _statusBarColor,
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colors.backgroundColor,
      body: buildSingleRestaurant(context),
    );
  }

  SingleChildScrollView buildSingleRestaurant(BuildContext context) {
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
                PageView.builder(
                  controller: widget.restaurant.pageController,
                  itemCount: widget.restaurant.mealsImages.length,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  onPageChanged: (int index) {
                    setState(() {
                      widget.restaurant.currentImageIndex = index;
                    });
                  },
                  itemBuilder: (context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget
                              .restaurant.mealsImages.reversed
                              .toList()[index]),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.02), BlendMode.darken),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.055,
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios,
                            size: 25, color: Colors.white),
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.ios_share,
                            size: 25, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search_rounded,
                            size: 25, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15, // Position form Bottom
                  right: 30, // Position from Right
                  child: SizedBox(
                    height: 15,
                    child: ListView.builder(
                      itemCount: widget.restaurant.mealsImages.length,
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
                              color:
                                  (widget.restaurant.currentImageIndex == index)
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.5),
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
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontFamily: "Raleway",
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
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
                    for (String foodKind in widget.restaurant.foodKinds) ...[
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
                    Text(
                      widget.restaurant.reviewingAverage.toString(),
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Icon(Icons.star_rounded,
                        color: colors.buttonColorGreen),
                    const SizedBox(width: 3),
                    Text(
                      widget.restaurant.numberOfReviews.toString() +
                          "+ Ratings",
                      style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 14,
                        color: Colors.black87.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      height: 30,
                      width: 25,
                      decoration: BoxDecoration(
                        color: colors.buttonColorGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.monetization_on,
                          color: colors.buttonColorGreen, size: 25),
                    ),
                    const SizedBox(width: 8),
                    (widget.restaurant.shippingPrice > 0)
                        ? Text(
                            widget.restaurant.shippingPrice.toString(),
                            style: TextStyle(
                                color: Colors.black87.withOpacity(0.8),
                                fontSize: 18,
                                fontFamily: "Raleway"),
                          )
                        : RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontFamily: "Raleway"),
                              text: "Free\n",
                              children: [
                                TextSpan(
                                    text: "Delivery",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Raleway")),
                              ],
                            ),
                          ),
                    const SizedBox(width: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      height: 30,
                      width: 25,
                      decoration: BoxDecoration(
                        color: colors.buttonColorGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.access_time_filled_rounded,
                          color: colors.buttonColorGreen, size: 25),
                    ),
                    const SizedBox(width: 8),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontFamily: "Raleway"),
                        text: widget.restaurant.preparingAverageTime
                                .split(" ")[0]
                                .toString() +
                            "\n",
                        children: const [
                          TextSpan(
                              text: "Minutes",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Raleway")),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "Take Away".toUpperCase(),
                        style: const TextStyle(
                            color: colors.buttonColorGreen,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w500),
                      ),
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            width: 0.8,
                            color: colors.buttonColorGreen,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  "Featured Items",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Raleway",
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: buildListViewFeaturedItems(
                      context, widget.restaurant.featuredItems),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.restaurant.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isNotItTheLastItem =
                            index != widget.restaurant.categories.length - 1;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              selectedCategory =
                                  widget.restaurant.categories[index];
                            });
                          },
                          child: Padding(
                            padding: (isNotItTheLastItem)
                                ? const EdgeInsets.only(right: 20.0)
                                : const EdgeInsets.only(right: 0),
                            child: Text(
                              widget.restaurant.categories[index].title,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Raleway",
                                color: (selectedIndex == index)
                                    ? Colors.black87
                                    : Colors.grey,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Most Popular",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Raleway",
                    color: Colors.black87,
                  ),
                ),
                buildFoodItems(context, widget.restaurant.mostPopular),
                const SizedBox(height: 20),
                (selectedCategory.foodItems!.isNotEmpty)
                    ? Text(
                        selectedCategory.title,
                        style: const TextStyle(
                          fontSize: 25,
                          fontFamily: "Raleway",
                          color: Colors.black87,
                        ),
                      )
                    : const SizedBox(),
                (selectedCategory.foodItems!.isNotEmpty)
                    ? buildFoodItems(context, selectedCategory.foodItems)
                    : Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage(
                                  "assets/images/sorry-restaurant.png"),
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.1),
                                  BlendMode.darken),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView buildFoodItems(BuildContext context, List<dynamic>? list) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: (list != null) ? list.length : 0,
        itemBuilder: (BuildContext context, int index) {
          bool isNotItTheLastItem = index != (list!.length - 1);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddToOrder(
                    foodItem: list[index],
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.05),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.14,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(list[index].imagePath),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.07), BlendMode.darken),
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
                              list[index].name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "Raleway",
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              list[index].description,
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
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  list[index].foodKind,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: "Raleway",
                                      fontSize: 12),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  "USD " + list[index].price.toString(),
                                  style: const TextStyle(
                                    fontFamily: "Raleway",
                                    color: colors.buttonColorGreen,
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
                const SizedBox(height: 10),
                (isNotItTheLastItem)
                    ? const Divider(
                        height: 10,
                        thickness: 1,
                      )
                    : const SizedBox(),
                (isNotItTheLastItem)
                    ? const SizedBox(height: 10)
                    : const SizedBox(height: 5),
              ],
            ),
          );
        });
  }

  ListView buildListViewFeaturedItems(BuildContext context, List list) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        bool isNotItTheLastItem = index != list.length - 1;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddToOrder(
                  foodItem: list[index],
                ),
              ),
            );
          },
          child: Container(
            margin: (isNotItTheLastItem)
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
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      "\$\$",
                      style: TextStyle(
                          color: Colors.black54, fontFamily: "Raleway"),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(list[index].foodKind,
                        style: const TextStyle(
                            color: Colors.black54, fontFamily: "Raleway")),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
