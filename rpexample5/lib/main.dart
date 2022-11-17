import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

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

@immutable
class Person {
  final String name;
  final int age;
  final String uuid;

  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  Person update([String? name, int? age]) => Person(
        name: name ?? this.name,
        age: age ?? this.age,
        uuid: uuid,
      );

  String get displayName => '$name($age years old)';

  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;
  @override
  int get HashCode => uuid.hashCode;

  @override
  String toString() => 'Person(name=$name,age=$age,uuid=$uuid)';
}

class DataModel extends ChangeNotifier {
  final List<Person> _person = [];

  int get count => _person.length;

  UnmodifiableListView<Person> get person => UnmodifiableListView(_person);

  void add(Person person) {
    _person.add(person);
    notifyListeners();
  }

  void remove(Person person) {
    _person.remove(person);
    notifyListeners();
  }

  void update(Person updatedPerson) {
    final index = _person.indexOf(updatedPerson);
    final oldperson = _person[index];
    if (oldperson.name != updatedPerson.name ||
        oldperson.age != updatedPerson.age) {
      _person[index] = oldperson.update(
        updatedPerson.name,
        updatedPerson.age,
      );
      notifyListeners();
    }
  }
}

final peopleProvider = ChangeNotifierProvider(
  (_) => DataModel(),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final dataModel = ref.watch(peopleProvider);
          return ListView.builder(
              itemCount: dataModel.count,
              itemBuilder: ((context, index) {
                final person = dataModel.person[index];
                return ListTile(
                  title: GestureDetector(
                    onTap: () async {
                      final updatePerson =
                          await createOrUpdateDialog(context, person);
                      if (updatePerson != null) {
                        dataModel.update(updatePerson);
                      }
                    },
                    child: Text(
                      person.displayName,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final person = await createOrUpdateDialog(context);
          if (person != null) {
            final dataModel = ref.read(peopleProvider);
            dataModel.add(person);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdateDialog(
  BuildContext context, [
  Person? existingPerson,
]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog<Person?>(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text('create a person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter you name...',
                ),
                onChanged: (value) => name = value,
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Enter you age...',
                ),
                onChanged: (value) => age = int.tryParse(value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                if (name != null && age != null) {
                  if (existingPerson != null) {
                    final newPerson = existingPerson.update(
                      name,
                      age,
                    );
                    Navigator.of(context).pop(newPerson);
                  } else {
                    Navigator.of(context).pop(
                      Person(
                        name: name!,
                        age: age!,
                      ),
                    );
                  }
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      }));
}
