import 'package:flutter/material.dart';
import 'package:flutter_state/counter_controller.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {

    final CounterController controller = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Flutter GetX Counter'),
        ),
      ),
      body: Center(
        child: Obx(
          () => Text(
            'Counter: ${controller.counter.value}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
