import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:coingecko_api/coingecko_result.dart';
import 'package:coingecko_api/data/coin.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto_app/api/gecko.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

final numF = NumberFormat.simpleCurrency();

Widget buildDetailModal(CoinGeckoResult<Coin?> coin, Market singledata) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      child: Column(
        children: [
          Text(
            coin.data!.name,
            style: GoogleFonts.oxygen(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFEEE5E9),
              fontSize: 24,
            ),
          ),
          Text(
            "7 Day Chart",
            style: GoogleFonts.oxygen(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: const Color(0xFFEEE5E9),
            ),
          ),
          SizedBox(
            height: 200,
            child: Sparkline(
              data: GeckoData()
                  .cleanData(coin.data!.marketData!.sparkline7d!.price),
              kLine: const ['max', 'min'],
              lineWidth: 2,
              gridLineLabelColor: Colors.white,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Linkify(
              onOpen: (link) async {
                if (await canLaunch(link.url)) {
                  await launch(link.url);
                } else {
                  throw 'Could not launch $link';
                }
              },
              text: coin.data!.links!.homepage![0].toString(),
              style: GoogleFonts.oxygen(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "\$ " + singledata.currentPrice!.toStringAsFixed(2),
              style: GoogleFonts.oxygen(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: const Color(0xFFEEE5E9),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 2, 50, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Market Cap: ",
                  style: GoogleFonts.oxygen(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFFEEE5E9),
                  ),
                ),
                Text(
                  numF.format(singledata.marketCap!),
                  style: GoogleFonts.oxygen(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFFEEE5E9),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 2, 50, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Market Cap: ",
                  style: GoogleFonts.oxygen(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFFEEE5E9),
                  ),
                ),
                Text(
                  numF.format(coin.data!.marketData!.circulatingSupply),
                  style: GoogleFonts.oxygen(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFFEEE5E9),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 2, 50, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Supply: ",
                  style: GoogleFonts.oxygen(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFFEEE5E9),
                  ),
                ),
                Text(
                  numF.format(singledata.totalVolume),
                  style: GoogleFonts.oxygen(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFFEEE5E9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
}
