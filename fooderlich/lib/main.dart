import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Matkul_Eval_theme.dart';
import 'models/models.dart';
import 'navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appStateManager = AppStateManager();
  await appStateManager.initializeApp();
  runApp(Matkul_Eval(appStateManager: appStateManager));
}

class Matkul_Eval extends StatefulWidget {
  final AppStateManager appStateManager;

  const Matkul_Eval({
    super.key,
    required this.appStateManager,
  });

  @override
  Matkul_EvalState createState() => Matkul_EvalState();
}

class Matkul_EvalState extends State<Matkul_Eval> {
  late final _groceryManager = GroceryManager();
  late final _profileManager = ProfileManager();
  late final _appRouter = AppRouter(
    widget.appStateManager,
    _profileManager,
    _groceryManager,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider(
          create: (context) => widget.appStateManager,
        ),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = Matkul_EvalTheme.dark();
          } else {
            theme = Matkul_EvalTheme.light();
          }

          final router = _appRouter.router;

          return MaterialApp.router(
            theme: theme,
            title: 'Mahasiswa Space',
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
          );
        },
      ),
    );
  }
}
