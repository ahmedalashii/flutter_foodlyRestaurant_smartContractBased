
import "package:flutter/material.dart";
import "../../constants/colors.dart" as colors;
import '../../models/restaurant.dart';
import '../wallet/connect_wallet.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods(
      {Key? key, required this.vatPercent, required this.restaurant})
      : super(key: key);
  final double vatPercent;
  final Restaurant restaurant;

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {

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
                          image: const AssetImage(
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
                          image: const AssetImage(
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
                          image: const AssetImage(
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
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ConnectWallet(restaurant: widget.restaurant, vatPercent: widget.vatPercent),
                  ),
                );
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
                          image: const AssetImage(
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
