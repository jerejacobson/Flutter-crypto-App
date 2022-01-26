import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto_app/Custom%20Widgets/list_view_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                toolbarHeight: 130,
                backgroundColor: const Color(0xFF221F33),
                elevation: 0.0,
                centerTitle: true,
                title: PreferredSize(
                    child: (SizedBox(
                        height: 100,
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              Image.asset(
                                  'assets/images/transparent_logomark.png'),
                              Center(
                                child: Text(
                                  "Crypto App",
                                  style: GoogleFonts.oxygen(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36,
                                    color: const Color(0xFFEEE5E9),
                                  ),
                                ),
                              ),
                            ])))),
                    preferredSize: const Size.fromHeight(50.0))),
            body: Center(
                child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF221F34),
                        Color(0xFF272441),
                      ],
                    )),
                    child: const ListViewBuilder()))));
  }
}
