// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import '../../models/food_item.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';
import "../../constants/colors.dart" as colors;
import "../../constants/orders.dart" as orders;
import '../../models/restaurant.dart';
import '../../widgets/alert_dialog.dart';
import 'ethereum_transaction_tester.dart';

class ConnectWallet extends StatefulWidget {
  const ConnectWallet(
      {Key? key, required this.restaurant, required this.vatPercent})
      : super(key: key);
  final Restaurant restaurant;
  final double vatPercent;

  @override
  State<ConnectWallet> createState() => _ConnectWalletState();
}

class _ConnectWalletState extends State<ConnectWallet> {
  DeployedContract? deployedContract;
  String? account;
  SessionStatus? session;
  late WalletConnectEthereumCredentials credentials;
  Web3Client? ethClient = Web3Client(
      "https://ropsten.infura.io/v3/12ef93aae4f44b76b35986f5b79b8ed0",
      Client());

  String restaurantPublicKey = "";
  bool data = false;

  dynamic myCoins = 0;

  double subTotal = 0, delivery = 0, totalPriceWithVatAndDelivery = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      deployedContract = await getDeployedContract();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
        ),
        title: const Text(
          "Wallet Connection",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage("assets/images/payment_methods/metamask.png"),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.02), BlendMode.darken),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async => _walletConnect(),
              child: Text(
                "Connect to your Wallet",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: colors.buttonColorGreen,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DeployedContract> getDeployedContract() async {
    String abi = await rootBundle.loadString("assets/contract.abi.json");
    String contractAddress =
        "0xE9192608985af540D4e01d00a430B5c1DcF704da"; // the deployed contract

    final contract = DeployedContract(ContractAbi.fromJson(abi, "SampleToken"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  _walletConnect() async {
    debugPrint("method invocation");
    final connector = WalletConnect(
      bridge: "https://bridge.walletconnect.org",
      clientMeta: const PeerMeta(
        name: "WalletConnect",
        description: "Foodly Wallet Connect Developer App",
        url: "https://walletconnect.org",
        icons: [
          "https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media",
        ],
      ),
    );
    // Subscribe to events
    connector.on('connect', (session) async {
      Future.delayed(const Duration(seconds: 2), () async {
        if (account != null) {
          debugPrint("Client Public Key: ${account.toString()}");
          EthereumWalletConnectProvider provider =
              EthereumWalletConnectProvider(connector);
          credentials = WalletConnectEthereumCredentials(provider: provider);
          debugPrint("credentials : ${credentials.provider}");
          await getBalance(account!).then((value) async {
            debugPrint(myCoins.toString());
            orders.restaurantOrderedFoodItems[widget.restaurant]!
                .forEach((FoodItem foodItem, int numberOfOrders) {
              if (!foodItem.isPaid) {
                subTotal += (foodItem.price * numberOfOrders);
                delivery = (delivery < foodItem.shippingPrice)
                    ? foodItem.shippingPrice
                    : delivery;
              }
            });
            totalPriceWithVatAndDelivery =
                subTotal + (subTotal * (widget.vatPercent / 100)) + delivery;
            debugPrint(totalPriceWithVatAndDelivery.toString());
            if (totalPriceWithVatAndDelivery <= myCoins.toDouble()) {
              await scanQr().then((value) async {
                Future.delayed(const Duration(milliseconds: 1200), () async {
                  debugPrint(
                      "Restaurant Owner Public Key: $restaurantPublicKey");
                  if (restaurantPublicKey.length == 42) {
                    // to ensure that the data returned from the qr code is valid (is a valid public key) ..
                    await transferCoin().then((String value) {
                      Future.delayed(const Duration(seconds: 2), () {
                        debugPrint("Hash : $value");
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
                                  'You placed the orders successfully. you will get your food within 25 minutes. Thanks for using our services. Enjoy your food :)'),
                        ).then((value) {
                          setState(() {
                            orders
                                .restaurantOrderedFoodItems[widget.restaurant]!
                                .forEach(
                                    (FoodItem foodItem, int numberOfOrders) {
                              foodItem.isPaid = true;
                            });
                          });
                          Navigator.pop(context);
                        });
                      });
                    });
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => MyAlertDialog(
                          title: 'You don\'t scan the proper Qr Code!',
                          circleIcon: Icons.clear_rounded,
                          circleColor: Colors.red,
                          subTitle:
                              "The result data is not a valid public key!"),
                    );
                  }
                });
              });
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => MyAlertDialog(
                  title: 'The Total Price exceeds the coins you have!',
                  circleIcon: Icons.clear_rounded,
                  circleColor: Colors.red,
                  subTitle: "The Price of the invoice is : " +
                      totalPriceWithVatAndDelivery.ceil().toString() +
                      "\nwhereas the coins you have is : " +
                      myCoins.toDouble().toString(),
                ),
              );
            }
          });
        }
      });
    });
    connector.on('session_update',
        (payload) => debugPrint("Session Updating : " + payload.toString()));
    connector.on(
        'disconnect',
        (session) =>
            debugPrint("Session Disconnection: " + session.toString()));
    // Create a new Session
    if (!connector.connected) {
      session = await connector.createSession(
        chainId: 3,
        onDisplayUri: (String uri) async => {
          debugPrint(uri),
          await launchUrl(
            Uri.parse(uri),
          ),
        },
      );
    }
    setState(() {
      account = session!.accounts[0];
    });
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    // used in getBalance method below
    final contract = await getDeployedContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient!
        .call(contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<void> getBalance(String targetAddress) async {
    EthereumAddress address = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query("balanceOf", [address]);

    myCoins = result[0];
    data = true;
  }

  // submit a transaction
  Future<String> submit(String functionName, List<dynamic> args) async {
    // EthPrivateKey tempCredentials = EthPrivateKey.fromHex(
    //     "64d7dfd774689f8a307770b3cd2df75325e4ab6acd90359fec38d5d5311266a6");

    WalletConnectEthereumCredentials credentials = this.credentials;
    final ethFunction = deployedContract!.function(functionName);
    final result = await ethClient!.sendTransaction(
      credentials,
      Transaction.callContract(
        from: EthereumAddress.fromHex(account!),
        contract: deployedContract!,
        function: ethFunction,
        parameters: args,
        gasPrice: await ethClient!.getGasPrice(),
        maxGas: 100000,
      ),
      fetchChainIdFromNetworkId: false,
      chainId: 3,
    );

    // This is if we want to transfer ether between two different wallets (two accounts) ..

    // final result = await credentials.sendTransaction(
    //   Transaction(
    //     from: EthereumAddress.fromHex(account!),
    //     to: EthereumAddress.fromHex(restaurantPublicKey),
    //     value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 1),
    //   ),
    // );

    // if we need private key to be imported manually ..

    // final result = await ethClient!.sendTransaction(
    //   tempCredentials,
    //   Transaction.callContract(
    //     contract: deployedContract!,
    //     function: ethFunction,
    //     parameters: args,
    //   ),
    //   fetchChainIdFromNetworkId: false,
    //   chainId: 3,
    // );

    return result;
  }

  // Transferring between two different addresses
  Future<String> transferCoin() async {
    EthereumAddress address =
        EthereumAddress.fromHex(restaurantPublicKey); // restaurantOwner
    var numOfCoins = BigInt.from(totalPriceWithVatAndDelivery);
    var response = await submit("transfer", [address, numOfCoins]);

    debugPrint(
        "Deposited in restaurant owner wallet and withdrawn from the client wallet.");
    // txHash = response;
    setState(() {});
    return response;
  }

  // Scanning Qr to get the public key of the restaurant owner.
  Future<void> scanQr() async {
    restaurantPublicKey = "";
    try {
      await FlutterBarcodeScanner.scanBarcode(
              '#2A99CF', 'cancel', true, ScanMode.QR)
          .then((value) {
        setState(() {
          if (value.contains("ethereum:")) {
            restaurantPublicKey = value.split("ethereum:")[1];
          }
        });
      });
    } catch (exception) {
      setState(() {
        restaurantPublicKey = 'Unable To Read This!';
      });
    }
  }

// this method is just when we want to withdraw coins from our wallet in the metamask ...
// Future<String> withdrawCoin() async {
//   var bigAmount = BigInt.from(totalPriceWithVatAndDelivery);
//   var response = await submit("withdrawBalance", [bigAmount]);
//
//   return response;
// }
}
