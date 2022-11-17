import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    ),
  ));
}

final currentDate = Provider<DateTime>((ref) => DateTime.now());

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(currentDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Center(
        child: Text(
          date.toIso8601String(),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}