import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto_app/api/gecko.dart';
import 'bottom_modal_widget.dart';
import 'package:intl/intl.dart';

final numF = NumberFormat.simpleCurrency();

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GeckoData().fetchMarketData(),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final coinData = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Center(child: Text('Error Fetching Data!'));
            } else {
              return buildMarketInfo(coinData);
            }
        }
      },
    );
  }

  Widget buildMarketInfo(List<Market> coinData) => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: coinData.length,
        itemBuilder: (context, index) {
          final singleData = coinData[index];
          return Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: GestureDetector(
                  onTap: () => showModalBottomSheet(
                      backgroundColor: Colors.black.withOpacity(0.8),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      context: context,
                      builder: (context) => buildInfo(singleData)),
                  child: Card(
                      color: const Color(0xFF473F73),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Column(
                                children: [
                                  Container(
                                      width: 50.0,
                                      height: 50.0,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: fetchImage(
                                                  singleData.image!)))),
                                  Text(
                                    singleData.symbol,
                                    style: GoogleFonts.oxygen(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: const Color(0xFFEEE5E9),
                                    ),
                                  ),
                                ],
                              )),
                          const Spacer(),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Price:   ",
                                        style: GoogleFonts.oxygen(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: const Color(0xFFEEE5E9),
                                        ),
                                      ),
                                      Text(
                                        "24 hr:   ",
                                        style: GoogleFonts.oxygen(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: const Color(0xFFEEE5E9),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        numF.format(singleData.currentPrice!),
                                        style: GoogleFonts.oxygen(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: const Color(0xFFEEE5E9),
                                        ),
                                      ),
                                      Text(
                                        (singleData.priceChangePercentage24h!
                                                .toStringAsFixed(2) +
                                            " %"),
                                        style: GoogleFonts.oxygen(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: singleData.priceChange24h! < 0
                                              ? Colors.redAccent
                                              : Colors.green,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: SizedBox(
                              width: 200,
                              height: 100,
                              child: buildSparkline(
                                  singleData.sparklineIn7d!.price,
                                  singleData.priceChange24h!),
                            ),
                          )
                        ],
                      ))));
        },
      );
}

Widget buildSparkline(List<double> data, double changePercent) {
  return Column(
    children: [
      Sparkline(
        data: GeckoData().sparkline24hr(data),
        fillMode: FillMode.below,
        fillGradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: changePercent < 0
                ? ([
                    Colors.redAccent.withOpacity(0.0),
                    Colors.redAccent.withOpacity(0.6),
                  ])
                : ([
                    Colors.green.withOpacity(0.0),
                    Colors.green.withOpacity(0.9),
                  ])),
        fillColor: changePercent < 0
            ? Colors.redAccent.withOpacity(0.3)
            : Colors.green.withOpacity(0.3),
        lineColor: changePercent < 0 ? Colors.redAccent : Colors.green,
        lineWidth: 2,
      )
    ],
  );
}

ImageProvider fetchImage(String imgUrl) {
  ImageProvider tempImage;
  tempImage = NetworkImage(imgUrl);
  return tempImage;
}

//Fetching the single coin details when a user clicks a list card.
Widget buildInfo(Market singledata) {
  return FutureBuilder(
    future: GeckoData().fetchCoinData(singledata.id),
    //initialData: InitialData,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      final coinData = snapshot.data;
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return const Center(child: CircularProgressIndicator());
        default:
          if (snapshot.hasError) {
            return const Center(child: Text('Error Fetching Data!'));
          } else {
            return buildDetailModal(coinData, singledata);
          }
      }
    },
  );
}
