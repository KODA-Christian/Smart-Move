import 'package:flutter/material.dart';
import 'package:smart_move/helpers/names.dart';
import 'package:smart_move/views/common/fullsize_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppNames.appName),
      ),
      body: const FullSizePage(
        child: Center(
          child: Text("HELLO WORLD"),
        ),
      ),
    );
  }
}
