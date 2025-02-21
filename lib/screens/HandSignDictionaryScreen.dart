import 'package:flutter/material.dart';
import 'package:flutter_hand_sign/screens/AlphabetScreen.dart';
import 'package:flutter_hand_sign/screens/NumberScreen.dart';

class HandSignDictionaryScreen extends StatefulWidget {
  final String title;
  const HandSignDictionaryScreen({super.key, required this.title});

  @override
  State<HandSignDictionaryScreen> createState() =>
      _HandSignDictionaryScreenState();
}

class _HandSignDictionaryScreenState extends State<HandSignDictionaryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _tabs = const [
    Tab(text: 'Numbers'),
    Tab(text: 'Alphabets'),
  ];

  final List<Widget> _tabViews = const [
    NumberScreen(),
    AlphabetScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabViews,
      ),
    );
  }
}
