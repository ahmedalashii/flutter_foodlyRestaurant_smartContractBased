import '../models/food_item.dart';
import '../models/restaurant.dart';



// List of items in our dropdown menu
var cities = [
  'San Francisco',
  'Khan Younis',
  'Al-Remal',
  'Al-nasser',
  'Al-zaytoun',
];


List<String> imagesList = [
  "assets/images/homepage-v1-header.png",
  "assets/images/homepage-v1-header2.png",
  "assets/images/homepage-v1-header.png",
  "assets/images/homepage-v1-header2.png",
  "assets/images/homepage-v1-header.png",
];

final List<FoodItem> featuredPartners = [
  FoodItem(
      imagePath: "assets/images/day-light-coffee.png",
      name: "Day Light Coffee",
      preparationTime: "25 min",
      shippingAddress: "Colorado, San Francisco",
      review: 4.5,
      price: 20,
      description: "Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain flowering plants in the Coffea genus.",
      shippingPrice: 0),
  FoodItem(
      imagePath: "assets/images/mario-italiano.png",
      name: "Mario Italiano",
      preparationTime: "25 min",
      shippingAddress: "SF, California",
      review: 4.3,
      description: "The Mushroom Kingdom is a fictional principality in Nintendo's Mario series.",
      price: 25,
      shippingPrice: 25),
  FoodItem(
      imagePath: "assets/images/burger.png",
      name: "Chicken Burger",
      preparationTime: "20 min",
      shippingAddress: "The Marina, San Francisco",
      review: 4.3,
      description: "A hamburger is a food consisting of fillings —usually a patty of ground meat, typically beef—placed inside a sliced bun or bread roll.",
      price: 35,
      shippingPrice: 25),
  FoodItem(
      imagePath: "assets/images/mc-donalds.png",
      name: "McDonald's",
      preparationTime: "15 min",
      shippingAddress: "North Beach, San Francisco",
      review: 5.0,
      price: 45,
      description: "McDonald's Corporation is an American multinational fast food corporation, founded in 1940 as a restaurant operated by Richard and Maurice McDonald, in San Bernardino, California, United States.",
      shippingPrice: 15),
];

final List<FoodItem> bestPicksRestaurantsByTeam = [
  FoodItem(
      imagePath: "assets/images/mc-donalds.png",
      name: "McDonald's",
      preparationTime: "15 min",
      shippingAddress: "North Beach, San Francisco",
      review: 5.0,
      description: "McDonald's Corporation is an American multinational fast food corporation, founded in 1940 as a restaurant operated by Richard and Maurice McDonald, in San Bernardino, California, United States.",
      price: 20,
      shippingPrice: 15),
  FoodItem(
      imagePath: "assets/images/burger.png",
      name: "The Halal Guys",
      preparationTime: "20 min",
      price: 30,
      shippingAddress: "The Marina, San Francisco",
      review: 4.3,
      description: "A hamburger is a food consisting of fillings —usually a patty of ground meat, typically beef—placed inside a sliced bun or bread roll.",
      shippingPrice: 25),
  FoodItem(
      imagePath: "assets/images/day-light-coffee.png",
      name: "Day Light Coffee",
      price: 35,
      preparationTime: "25 min",
      shippingAddress: "Colorado, San Francisco",
      review: 4.5,
      description: "Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain flowering plants in the Coffea genus.",
      shippingPrice: 0),
  FoodItem(
      imagePath: "assets/images/mario-italiano.png",
      price: 48,
      name: "Mario Italiano",
      preparationTime: "25 min",
      shippingAddress: "SF, California",
      review: 4.3,
      description: "The Mushroom Kingdom is a fictional principality in Nintendo's Mario series.",
      shippingPrice: 25),
];

final List<Restaurant> restaurants = [
  Restaurant(
    mealsImages: [
      "assets/images/table-food.png",
      "assets/images/cake.png",
      "assets/images/mc-donalds.png",
    ],
    name: "Cafe Brichor's",
    shippingPrice: 45,
    numberOfReviews: 306,
    reviewingAverage: 4.1,
    foodKinds: ["Chinese", "American", "Deshi Food"],
    preparingAverageTime: "25 min",
  ),
  Restaurant(
    mealsImages: [
      "assets/images/orange-fruit.png",
      "assets/images/cake.png",
      "assets/images/mario-italiano.png",
      "assets/images/mc-donalds.png",
    ],
    name: "La Brioche",
    shippingPrice: 25,
    numberOfReviews: 203,
    reviewingAverage: 4.6,
    foodKinds: ["American", "Southern", "Derssert"],
    preparingAverageTime: "22 min",
  ),
  Restaurant(
    mealsImages: [
      "assets/images/cake.png",
      "assets/images/table-food.png",
      "assets/images/mario-italiano.png",
      "assets/images/mc-donalds.png",
    ],
    name: "McDonald's",
    shippingPrice: 0,
    numberOfReviews: 85,
    reviewingAverage: 5,
    foodKinds: ["American", "Chinese", "Deshi Food"],
    preparingAverageTime: "17 min",
  ),
  Restaurant(
    mealsImages: [
      "assets/images/mario-italiano.png",
      "assets/images/cake.png",
      "assets/images/table-food.png",
      "assets/images/mc-donalds.png",
    ],
    name: "Asil Restaurant Dubai",
    shippingPrice: 13,
    numberOfReviews: 76,
    reviewingAverage: 4.1,
    foodKinds: ["Deshi Food", "Chinese", "American"],
    preparingAverageTime: "11 min",
  ),
];