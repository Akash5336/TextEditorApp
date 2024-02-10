import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffCADCFC),
          title: Text("Text Editor",style: GoogleFonts.merriweather(
            color: Color(0xff00246B),
            fontSize: 30,
            fontStyle: FontStyle.italic
          ),),
        ),
        resizeToAvoidBottomInset: false,
        body: const HomePage(),
      ),
    ));
  }
}
