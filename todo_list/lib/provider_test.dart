import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ProviderApp());

class ProviderApp extends StatelessWidget {
  String data = 'hello';

  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      create: (context) => data,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(data),
          ),
          body: Title1(),
        ),
      ),
    );
  }
}

class Title1 extends StatelessWidget {
  const Title1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Title2(),
    );
  }
}

class Title2 extends StatelessWidget {
  const Title2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Title3(),
    );
  }
}

class Title3 extends StatelessWidget {
  const Title3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(Provider.of<String>(context)),
    );
  }
}
