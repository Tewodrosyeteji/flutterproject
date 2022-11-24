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
  final String uuid;
  final int age;

  People({
    required this.name,
    String? uuid,
    required this.age,
  }) : uuid = uuid ?? const Uuid().v4();

<<<<<<< HEAD
  People updated([String? name, int? age]) => People(
=======
  Person updated([String? name, int? age]) => Person(
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4
        name: name ?? this.name,
        age: age ?? this.age,
      );
  String get displayName => '$name($age years old)';

  @override
<<<<<<< HEAD
  bool operator ==(covariant People other) => uuid == other.uuid;
=======
  bool operator ==(covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4

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

<<<<<<< HEAD
  void update(People updatePeople) {
    final index = _people.indexOf(updatePeople);
    print(index);
    final oldPerson = _people[index + 1];
    if (oldPerson.name != updatePeople.name ||
        oldPerson.age != updatePeople.age) {
      _people[index + 1] = oldPerson.updated(
        updatePeople.name,
        updatePeople.age,
=======
  void update(Person updatedPerson) {
    final index = _person.indexOf(updatedPerson);
    final oldPerson = _person[index];
    if (oldPerson.name != updatedPerson.name ||
        oldPerson.age != updatedPerson.age) {
      _person[index] = oldPerson.updated(
        updatedPerson.name,
        updatedPerson.age,
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4
      );
      notifyListeners();
    }
  }
}

<<<<<<< HEAD
final peopleProvider = ChangeNotifierProvider(
  ((_) => PeopleNotifier()),
);
=======
final personProvider = ChangeNotifierProvider(((_) => DataModel()));
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4

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
<<<<<<< HEAD
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
=======
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
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4
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

<<<<<<< HEAD
Future<People?> createOrUpdateDialog(BuildContext context,
    [People? existingPeople]) {
  String? name = existingPeople?.name;
  int? age = existingPeople?.age;
=======
Future<Person?> createorUpdatePerson(BuildContext context,
    [Person? existingPerson]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
<<<<<<< HEAD
        title: const Text(' Create a Person'),
=======
        title: const Text('create a person'),
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
<<<<<<< HEAD
              decoration: const InputDecoration(labelText: 'Enter your name'),
=======
              decoration: const InputDecoration(labelText: 'Enter a name...'),
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
<<<<<<< HEAD
              decoration: const InputDecoration(labelText: 'Enter your age'),
=======
              decoration: const InputDecoration(labelText: 'Enter an age...'),
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4
              onChanged: (value) => age = int.tryParse(value),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
<<<<<<< HEAD
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
=======
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
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4
                }
              } else {
                Navigator.of(context).pop();
              }
<<<<<<< HEAD
            },
            child: const Text('Create'),
          )
=======
            }),
            child: const Text('Create'),
          ),
>>>>>>> 7e4504153a645fec601e542a9ae46ae5ebb4d6c4
        ],
      );
    }),
  );
}
