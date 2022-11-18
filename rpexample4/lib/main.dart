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

const names = [
  'teddy',
  'yared',
  'nebwu',
  'halid',
  'abrham',
  'abrela',
  'kindu',
];

final tickerProvider = StreamProvider(
  ((ref) => Stream.periodic(
        const Duration(
          seconds: 1,
        ),
        ((i) => i + 1),
      )),
);

final nameProvider = StreamProvider(
  ((ref) => ref.read(tickerProvider.stream).map(
        (count) => names.getRange(0, count),
      )),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: names.when(
        data: ((names) {
          return ListView.builder(
            itemCount: names.length,
            itemBuilder: ((context, index) {
              print(index);
              return ListTile(
                title: Text(names.elementAt(index)),
              );
            }),
          );
        }),
        error: (error, stackTrace) => const Text('reach the limit'),
        loading: (() => const Center(
              child: CircularProgressIndicator(),
            )),
      ),
    );
  }
}
