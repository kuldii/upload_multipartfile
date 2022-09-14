import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<HomeController>(
              builder: (_) {
                return Text(controller.filePicked?.name ?? "no data");
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.pilihFile();
              },
              child: const Text("choose file"),
            ),
          ],
        ),
      ),
      floatingActionButton: GetBuilder<HomeController>(
        builder: (_) {
          if (controller.filePicked != null) {
            return FloatingActionButton(
              onPressed: () {
                controller.submit();
              },
              child: const Icon(Icons.download),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
