import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_list_travel_controller.dart';

class SearchListTravelView extends GetView<SearchListTravelController> {
  const SearchListTravelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchListTravelView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SearchListTravelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
