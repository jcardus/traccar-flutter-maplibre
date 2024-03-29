import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:traccar_flutter_maplibre/screens/devices.dart';
import 'package:traccar_flutter_maplibre/screens/login.dart';
import 'package:traccar_flutter_maplibre/screens/reports.dart';
import 'package:traccar_flutter_maplibre/screens/settings.dart';
import 'package:traccar_flutter_maplibre/screens/map.dart';
import 'package:go_router/go_router.dart';
import 'models/devices.dart';
import 'models/user.dart';

void main() {
  runApp(const App());
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const _App(),
      )
    ],
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ListenableProvider(create: (context) => UserModel()),
      ChangeNotifierProxyProvider<UserModel, DevicesModel>(
        create: (context) => DevicesModel(),
        update: (context, user, devices) {
          if (devices == null) throw ArgumentError.notNull('devices');
          devices.user = user;
          return devices;
        },
      )
    ],
    child: MaterialApp.router(
      title: 'Traccar',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router()
    ));
  }
}

class _App extends StatefulWidget {
  const _App();

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0
      ),
      body: getBody(),
      drawer: const Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Devices()
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: AppLocalizations.of(context)!.mapTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.article),
            label: AppLocalizations.of(context)!.reportTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settingsTitle,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget getBody() {
    switch (_selectedIndex) {
      case 1:
        return const Reports();
      case 2:
        return const Settings();
      default:
        return const Map();
    }
  }
}
