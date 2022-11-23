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
class People {
  final String name;
  final int age;
  final String uuid;

  People({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  People updated([String? name, int? age]) => People(
        name: name ?? this.name,
        age: age ?? this.age,
      );
  String get displayName => '$name($age years old)';

  @override
  bool operator ==(covariant People other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() => 'People(name=$name,age=$age,uuid=$uuid)';
}

class PeopleNotifier extends ChangeNotifier {
  final List<People> _people = [];

  int get count => _people.length;

  UnmodifiableListView<People> get people => UnmodifiableListView(_people);

  void add(People people) {
    _people.add(people);
    notifyListeners();
  }

  void remove(People people) {
    _people.remove(people);
    notifyListeners();
  }

  void update(People updatePeople) {
    final index = _people.indexOf(updatePeople);
    print(index);
    final oldPerson = _people[index + 1];
    if (oldPerson.name != updatePeople.name ||
        oldPerson.age != updatePeople.age) {
      _people[index + 1] = oldPerson.updated(
        updatePeople.name,
        updatePeople.age,
      );
      notifyListeners();
    }
  }
}

final peopleProvider = ChangeNotifierProvider(
  ((_) => PeopleNotifier()),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier'),
      ),
      body: Consumer(
        builder: ((context, ref, child) {
          final dataModel = ref.watch(peopleProvider);
          return ListView.builder(
            itemCount: dataModel.count,
            itemBuilder: ((context, index) {
              final person = dataModel.people[index];
              return ListTile(
                title: GestureDetector(
                  onTap: (() async {
                    final updatedPerson =
                        await createOrUpdateDialog(context, person);
                    if (updatedPerson != null) {
                      dataModel.update(updatedPerson);
                    }
                  }),
                  child: Text(person.displayName),
                ),
              );
            }),
          );
        }),
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

Future<People?> createOrUpdateDialog(BuildContext context,
    [People? existingPeople]) {
  String? name = existingPeople?.name;
  int? age = existingPeople?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        title: const Text(' Create a Person'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Enter your age'),
              onChanged: (value) => age = int.tryParse(value),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (name != null && age != null) {
                if (existingPeople != null) {
                  final newperson = existingPeople.updated(
                    name,
                    age,
                  );
                  Navigator.of(context).pop(newperson);
                } else {
                  Navigator.of(context).pop(People(
                    name: name!,
                    age: age!,
                  ));
                }
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Create'),
          )
        ],
      );
    }),
  );
}
