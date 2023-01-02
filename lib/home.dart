import 'package:flutter/material.dart';
import 'todo_page.dart';

class Home extends StatelessWidget {
  static String id = 'Home Page';
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('HOMIE')),
      ),
      body: Container(
        child: Column(
          children: [
            TextButton(
                onPressed: () => Navigator.pushNamed(context, TodoPage.id),
                child: Text('To do page')),
          ],
        ),
      ),
    );
  }
}
