import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    ),
  ));
}

extension optionalInfxAddtion<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() {
    state = state == null ? 1 : state + 1;
  }
}

final countProvider = StateNotifierProvider<Counter, int?>(
  ((ref) => Counter()),
);

void onPress(WidgetRef ref) {
  ref.read(countProvider.notifier).increment();
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(countProvider);
            final text =
                count == null ? 'Press to Increment' : count.toString();
            return Text(text);
          },
          child: const Text('Home page'),
        ),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: (() => onPress(ref)),
            child: const Text('Increment count '),
          )
        ],
      ),
    );
  }
}
