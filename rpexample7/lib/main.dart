import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
//  1.provider
// final nameProvider = Provider<String>((ref) => 'teddy');

//  2.  StateProvider
// 2.1 final nameProvider = StateProvider(
//   ((ref) => 'teddy'),
// );


final nameProvider = StateProvider<String?>((ref) => null);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1 provider
    final name = ref.watch(nameProvider) ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod revision'),
      ),
      body: Column(
        children: [
          TextField(),
          Text(name),

        ],
      ),
    );
  }
}
