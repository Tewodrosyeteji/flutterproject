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
  final String uuid;
  final int age;

  Person({
    required this.name,
    String? uuid,
    required this.age,
  }) : uuid = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) => Person(
        name: name ?? this.name,
        age: age ?? this.age,
        uuid: uuid,
      );

  String get displayName => '$name($age years old)';

  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

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
    final oldPerson = _person[index];
    if (oldPerson.name != updatedPerson.name ||
        oldPerson.age != updatedPerson.age) {
      _person[index] = oldPerson.updated(
        updatedPerson.name,
        updatedPerson.age,
      );
      notifyListeners();
    }
  }
}

final personProvider = ChangeNotifierProvider(((_) => DataModel()));

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Consumer(
        builder: ((context, ref, child) {
          final dataModel = ref.watch(personProvider);
          return ListView.builder(
            itemCount: dataModel.count,
            itemBuilder: ((context, index) {
              final person = dataModel.person[index];
              return ListTile(
                title: GestureDetector(
                  onTap: () async {
                    final updatedPerson =
                        await createorUpdatePerson(context, person);

                    if (updatedPerson != null) {
                      dataModel.update(updatedPerson);
                    }
                  },
                  child: Text(
                    person.displayName,
                  ),
                ),
              );
            }),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final person = await createorUpdatePerson(context);
          if (person != null) {
            final dataModel = ref.read(personProvider);
            dataModel.add(person);
          }
        },
      ),
    );
  }
}

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createorUpdatePerson(BuildContext context,
    [Person? existingPerson]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        title: const Text('create a person'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Enter a name...'),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Enter an age...'),
              onChanged: (value) => age = int.tryParse(value),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('cancel'),
          ),
          TextButton(
            onPressed: (() {
              if (name != null && age != null) {
                if (existingPerson != null) {
                  final newPerson = existingPerson.updated(
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
            }),
            child: const Text('Create'),
          ),
        ],
      );
    }),
  );
}
