import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';
import 'home.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
//   Widget build(BuildContext context) {
//     final theme = FooderlichTheme.light();

//     return MaterialApp(
//       title: 'Fooderlich',
//       theme: theme,
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Fooderlich')),
//         body: const Center(
//           child: Text('Let\'s get cooking 🥘'),
//         ),
//       ),
//     );
//   }
// }

  Widget build(BuildContext context) {
    final theme = FooderlichTheme.dark();

    return MaterialApp(
      title: 'Fooderlich',
      theme: theme,
      home: Home(),
    );
  }
}
