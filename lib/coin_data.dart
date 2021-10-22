import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'crypto_icons_icons.dart';

const String apikey = 'B97003A5-3B1B-42CB-B9D9-C535A5AA4625';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC', 'DOGE', 'ADA'];
const Map<String, IconData> cryptoIcons = {
  'BTC': CryptoIcons.bitcoin,
  'ETH': CryptoIcons.ethereum,
  'LTC': CryptoIcons.litecoin,
  'DOGE': CryptoIcons.doge,
  'ADA': CryptoIcons.cordana
};

class CoinData {
  Future getCompleteCoinData(String selectedCurrency) async {
    Map<String, String> coinData = {};
    for (String crypto in cryptoList) {
      http.Response response = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=$apikey'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        double price = data['rate'];
        coinData[crypto] = price.toStringAsFixed(2);
      } else {
        print(response.statusCode);
      }
    }
    return coinData;
  }
}
