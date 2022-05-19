// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import "../../constants/colors.dart" as colors;
import "../../constants/orders.dart" as orders;
import '../../models/food_item.dart';
import '../../widgets/alert_dialog.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key, required this.vatPercent}) : super(key: key);
  final double vatPercent;

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  late Client httpClient;
  late Web3Client ethClient;
  bool data = false;

  final restaurantOwner = "0xbfEAfa9B322E74AFCfcC63104219D9B0416C07F5"; // the address of the owner of the restaurant (foodly).

  final clientAddress = "0xC3923205Cd80c3B1856FF2B927e46896b36Df294"; // the address which the items will be paid from.
  dynamic myCoins = 0;
  double totalPriceWithVatAndDelivery = 0;

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(
        "https://ropsten.infura.io/v3/68fafe5fd373437a84c0a0e2aaa49387",
        httpClient);
    getBalance(clientAddress);
  }

  Future<DeployedContract> getDeployedContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0x02d643C66cF8e96271F81c1d4DCb7C59e6a631f6"; // the deployed contract

    final contract = DeployedContract(ContractAbi.fromJson(abi, "SampleToken"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await getDeployedContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<void> getBalance(String targetAddress) async {
    EthereumAddress address = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query("balanceOf", [address]);

    myCoins = result[0];
    data = true;
    setState(() {});
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "394e748f82785846d10c6fb6efc3a4e65fb9c39c0916dc42f579bc26738525d4");
    DeployedContract contract = await getDeployedContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: ethFunction,
            parameters: args,
            maxGas: 100000),
        fetchChainIdFromNetworkId: false,
        chainId: 3);
    return result;
  }


  // this method is created to transfer coins between two different addresses (the owner of the restaurant which is the stakeholder here and the client which is the one who will eat the food : ) ).
  Future<String> transferCoin() async {
    EthereumAddress address = EthereumAddress.fromHex(restaurantOwner);
    var bigAmount = BigInt.from(totalPriceWithVatAndDelivery);
    var response = await submit("transfer", [address, bigAmount]);

    debugPrint("Deposited in your wallet and withdrawn from the client wallet.");
    // txHash = response;
    setState(() {});
    return response;
  }

  // this method is just when we want to withdraw coins from our wallet in the metamask ...
  // Future<String> withdrawCoin() async {
  //   var bigAmount = BigInt.from(totalPriceWithVatAndDelivery);
  //   var response = await submit("withdrawBalance", [bigAmount]);
  //
  //   return response;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
        ),
        title: const Text(
          "Payment Methods",
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
      body: buildPaymentMethods(context),
    );
  }

  SingleChildScrollView buildPaymentMethods(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.055,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/payment_methods/paypal.png"),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.02), BlendMode.darken),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Paypal",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontFamily: "Raleway"),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "No Default",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontFamily: "Raleway"),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 20, color: Colors.black87.withOpacity(0.8)),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 3,
              indent: MediaQuery.of(context).size.width * 0.28,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.055,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/payment_methods/mastercard.png"),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.02), BlendMode.darken),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Master Card",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontFamily: "Raleway"),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Not Default",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontFamily: "Raleway"),
                        ),
                        Divider(
                          thickness: 3,
                          height: 5,
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 20, color: Colors.black87.withOpacity(0.8)),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 3,
              indent: MediaQuery.of(context).size.width * 0.28,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.055,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/payment_methods/visa.png"),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.02), BlendMode.darken),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Visa",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontFamily: "Raleway"),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Not Default",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontFamily: "Raleway"),
                        ),
                        Divider(
                          thickness: 3,
                          height: 5,
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 20, color: Colors.black87.withOpacity(0.8)),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 3,
              indent: MediaQuery.of(context).size.width * 0.28,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                double subTotal = 0;
                double delivery = 0;
                debugPrint("Number of distinct ordered Items to be paid: " + orders.orderedFoodItems.length.toString());
                orders.orderedFoodItems
                    .forEach((FoodItem item, int numberOfOrders) {
                  subTotal += (item.price * numberOfOrders);
                  delivery = (delivery < item.shippingPrice)
                      ? item.shippingPrice
                      : delivery;
                });
                totalPriceWithVatAndDelivery = subTotal +
                    (subTotal * (widget.vatPercent / 100)) +
                    delivery;
                debugPrint(totalPriceWithVatAndDelivery.ceil().toString());
                Future.delayed(Duration(seconds: 2), () async {
                  // if the totalPrice of the invoice is equal to zero then there are no orders chosen to be paid yet!
                  if (totalPriceWithVatAndDelivery.toInt() == 0) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => const MyAlertDialog(
                          title: "You don't have any order yet to pay for!",
                          subTitle:
                              'Keep browsing and add orders to the card to pay for them when available.',
                          circleIcon: Icons.clear_rounded,
                          circleColor: Colors.red),
                    );
                    setState(() {
                      orders.orderedFoodItems.clear();
                    });
                    // else if it's less than or equal to what we have in our wallet .. then withdraw and clear the orders which they were waiting to be paid ..
                  } else if (totalPriceWithVatAndDelivery <=
                      myCoins.toDouble()) {
                    await transferCoin();
                    setState(() {
                      orders.orderedFoodItems.clear();
                    });
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => MyAlertDialog(
                            title:
                                'You Placed the Order Successfully, \$${totalPriceWithVatAndDelivery.toStringAsFixed(2)} is withdrawn. and you still have \$' +
                                    (myCoins.toDouble() -
                                            totalPriceWithVatAndDelivery)
                                        .ceil()
                                        .toString(),
                            subTitle:
                                'You placed the orders successfully. you will get your food within 25 minutes. Thanks for using our services. Enjoy your food :)'));
                    debugPrint(totalPriceWithVatAndDelivery.ceil().toString());
                    debugPrint("Number of distinct ordered Items to be paid: " + orders.orderedFoodItems.length.toString() + ", the old ones are already paid");
                  // else if there's an insufficient amount of coins in our wallet then we can't pay the invoice ..
                  } else {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => MyAlertDialog(
                            title:
                                'The Total Price exceeds the coins you have!',
                            circleIcon: Icons.clear_rounded,
                            circleColor: Colors.red,
                            subTitle: "The Price of the invoice is : " +
                                totalPriceWithVatAndDelivery.ceil().toString() +
                                "\nwhereas the coins you have is : " +
                                myCoins.toDouble().toString()));
                  }
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.055,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/payment_methods/metamask.png"),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.02), BlendMode.darken),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Metamask",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontFamily: "Raleway"),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Default Payment",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontFamily: "Raleway"),
                        ),
                        Divider(
                          thickness: 3,
                          height: 5,
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 20, color: Colors.black87.withOpacity(0.8)),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 3,
              indent: MediaQuery.of(context).size.width * 0.28,
            ),
          ],
        ),
      ),
    );
  }
}
