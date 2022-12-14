import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
<<<<<<< HEAD

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
=======
import 'package:rpexample7/user.dart';

// 1. Provider->read only
// final nameProvider = Provider<String>(((ref) => 'teddy'));

// 2. StateProvider
// 2.1 final nameProvider = StateProvider(
//   (ref) => 'teddy',
// );
// 2.2
// final nameProvider = StateProvider<String?>(((ref) => null));

// 3.StateNotifier and StateNotifierProvider

// final userNotifier = StateNotifierProvider<UserNotifier, User>(
//   ((ref) => UserNotifier(
//         const User(
//           name: 'name',
//           age: 0,
//         ),
//       )),

//   // option 2
//   // ((ref) => UserNotifier()),
// );
// 4. FutureProvider

final featchData = FutureProvider((ref) {
  return FeatchUserData().fatch();
});

// 4.2 optional but not work for me
// final featchData = FutureProvider((ref) {
//   final userRepository = ref.watch(userRepositoryProvider);
//   return userRepository.fatch();
// });

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    ),
  ));
>>>>>>> c5e8063564b59b691759532579943069eae320f5
}
//  1.provider
// final nameProvider = Provider<String>((ref) => 'teddy');

<<<<<<< HEAD
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
=======
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

// 2.2
  // void onSubmit(WidgetRef ref, String value) {
  //   ref.read(nameProvider.notifier).update((state) => value);
  // }

  // 3
  // void onSubmit(WidgetRef ref, String value) {
  //   ref.read(userNotifier.notifier).nameUpdate(value);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1,2.1
    // final name = ref.watch(nameProvider);

    // 2.2
    // final name = ref.watch(nameProvider) ?? '';

    //  3.1
    // final user = ref.watch(userNotifier);

    // 3.2 option 2-> only the change is happening
    // final user=ref.watch(userNotifier.select((value) => value.name));

// 4
    return ref.watch(featchData).when(
          data: (data) {
            return Scaffold(
              appBar: AppBar(
                title: Text(data.name),
              ),
              body: Column(
                children: [Text(data.email)],
              ),
            );
          },
          error: (error, stackTrace) => Text(
            error.toString(),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
>>>>>>> c5e8063564b59b691759532579943069eae320f5
  }
}
