import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/coingecko_result.dart';
import 'package:coingecko_api/data/coin.dart';
import 'package:coingecko_api/data/market.dart';

// Fetching top 100 Coins from Coin Gecko Api
class GeckoData {
  Future<List<Market>> fetchMarketData() async {
    CoinGeckoApi api = CoinGeckoApi();

    final marketChart =
        await api.coins.listCoinMarkets(vsCurrency: "usd", sparkline: true);
    return marketChart.data;
  }

//Fetching individual coins for the Bottom Modal Details Widget
  Future<CoinGeckoResult<Coin?>> fetchCoinData(String id) async {
    CoinGeckoApi api = CoinGeckoApi();

    final marketChart = await api.coins.getCoinData(
        id: id,
        localization: false,
        marketData: true,
        communityData: false,
        developerData: true,
        sparkline: true);
    return marketChart;
  }

//CoinGecko Api returns 7 days of sparkline data.
// I am splitting the data so that I am grabbing just the last 24 hrs of Data.
  List<double> sparkline24hr(List<double> li) {
    num days = 7;
    num indexlength = li.length;
    num positions = indexlength ~/ days;
    num startPosition = indexlength - positions;

    List<double> list24 = [];

    for (var i = startPosition.toInt(); i < li.length; i++) {
      list24.add(li[i]);
    }

    return list24;
  }

  //Parsing the data to make it more readable with 2 decimal places instead of 8
  List<double> cleanData(List<double> li) {
    List<double> cleanedList = [];

    for (var i = 0; i < li.length; i++) {
      cleanedList.add(double.parse(li[i].toStringAsFixed(2)));
    }

    return cleanedList;
  }
}
