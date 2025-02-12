import 'package:flutter/material.dart';
import 'package:flutter_state/api_service.dart';
import 'package:flutter_state/counter_controller.dart';
import 'package:flutter_state/reactive_controller.dart';
import 'package:get/get.dart';

void main() {
  Get.lazyPut<ApiService>(() => ApiService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NamePage extends StatelessWidget {
  const NamePage({super.key});

  @override
  Widget build(BuildContext context) {

    final ReactiveController reactiveController = Get.put(ReactiveController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX Reactive State Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text('Name: ${reactiveController.name}',
                  style: const TextStyle(fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                onChanged: reactiveController.changeName,
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  border: OutlineInputBorder(),
                ),
              ),
            )
          ],
        ),
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const NextPage());
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Next Page',
          style: TextStyle(fontSize: 24),
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
