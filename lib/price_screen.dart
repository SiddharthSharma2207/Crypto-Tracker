
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedValue = 'USD';
  String exchange_BTC;
  bool isWaiting = false;
  Map<String, String> coinData = {};
  void getCompleteData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCompleteCoinData(selectedValue);
      setState(() {
        coinData = data;
      });
      isWaiting = false;
    } catch (e) {
      print(e);
    }
  }

  Column cryptoCards() {
    List<CryptoCardNew> cardList = [];
    for (String crypto in cryptoList) {
      cardList.add(CryptoCardNew(
          crypto: crypto,
          selectedCurrency: selectedValue,
          value: isWaiting ? '??' : coinData[crypto]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: cardList,
    );
  }

  @override
  void initState() {
    print('hello');
    super.initState();
    getCompleteData();
  }

  Widget getDropDown() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var item = DropdownMenuItem<String>(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      dropDownList.add(item);
    }
    return DropdownButton<String>(
      value: selectedValue,
      icon: Icon(FontAwesomeIcons.moneyBillAlt),
      style: TextStyle(fontSize: 21, fontFamily: 'Oxanium'),
      items: dropDownList,
      onChanged: (value) {
        setState(() {
          selectedValue = value;
          getCompleteData();
        });
        print(selectedValue);
      },
    );
  }

  Widget getPicker() {
    List<Text> PickerList = [];
    for (String string in currenciesList) {
      var item = Text(
        string,
        style: TextStyle(color: Colors.white),
      );
      PickerList.add(item);
    }
    return CupertinoPicker(
      children: PickerList,
      backgroundColor: Color(0xFF082032),
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedValue = PickerList[selectedIndex].data;
          getCompleteData();
          print(PickerList[selectedIndex].data);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crypto Exchange',
          style: TextStyle(
              fontFamily: 'Oxanium', fontWeight: FontWeight.w800, fontSize: 25),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          cryptoCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF082032),
            child: Platform.isIOS ? getPicker() : getDropDown(),
            //child: getPicker(),
          ),
        ],
      ),
    );
  }
}

// class CryptoCard extends StatelessWidget {
//   CryptoCard({
//     @required this.crypto,
//     @required this.selectedCurrency,
//     @required this.value,
//   });
//
//   final String crypto;
//   final String selectedCurrency;
//   final String value;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//       child: Card(
//         color: Color(0xFFFF4C29),
//         elevation: 5.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//           child: Text(
//             '1 $crypto = $value $selectedCurrency',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 20.0,
//               color: Colors.white,
//               fontFamily: 'Oxanium',
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CryptoCardNew extends StatelessWidget {
  CryptoCardNew({
    @required this.crypto,
    @required this.selectedCurrency,
    @required this.value,
  });

  final String crypto;
  final String selectedCurrency;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Color(0xFFFF4C29),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          leading: Icon(
            cryptoIcons[crypto],
            size: 30,
          ),
          title: Text(
            '1 $crypto = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontFamily: 'Oxanium',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
