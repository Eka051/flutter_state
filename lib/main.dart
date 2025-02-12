import 'package:flutter/material.dart';
import 'package:flutter_state/api_service.dart';
import 'package:flutter_state/counter_controller.dart';
import 'package:get/get.dart';

void main() {
  Get.lazyPut<ApiService>(() => ApiService());
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
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('GetX Depedency Management')),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: apiService.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Text(snapshot.data ?? 'No Data');
            } else {
              return const Text('Error in fetching data');
            }
          },
        ),
      ),
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
