import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'package:my_app_flutter/datamodels/user_location.dart';
import 'package:my_app_flutter/views/home.dart';
import 'package:my_app_flutter/views/myJobs.dart';
import 'package:my_app_flutter/views/map.dart';
import 'package:my_app_flutter/service/location_service.dart';
import 'package:my_app_flutter/utilities/hexColor.dart';
import 'package:my_app_flutter/hoc/lifecycle_manager.dart';
import 'package:my_app_flutter/responsive/dimensions.dart';

void main() {
  final HttpLink httpLink =
      HttpLink("https://beta-api-upgrade.jobthai.com/v1/graphql/");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );

  var app = GraphQLProvider(
    client: client,
    child: const MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return StreamProvider<UserLocation>(
      create: (context) => LocationService().locationStream,
      initialData: UserLocation(
        latitude: 0,
        longitude: 0,
      ),
      child: LifeCycleManager(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MyJobsScreen(),
    Map(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: currentWidth < mobileWidth,
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: currentWidth < mobileWidth
                  ? Colors.transparent
                  : Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'JobThai',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              foregroundColor: HexColor.fromHex('#FE6D43'),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness:
                    Brightness.dark, //<-- For Android SEE HERE (dark icons)
                statusBarBrightness:
                    Brightness.light, //<-- For iOS SEE HERE (dark icons)
              ))
          : null,
      drawer: const NavigationDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30.0,
            ),
            label: 'My Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
              size: 30.0,
            ),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: HexColor.fromHex('#FE6D43'),
        onTap: _onItemTapped,
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItem(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: const <Widget>[
          CircleAvatar(
            radius: 52,
            backgroundImage: NetworkImage(
              'https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg',
            ),
          )
        ],
      ),
    );
  }

  Widget buildMenuItem(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.login),
          title: const Text('Login'),
          onTap: () {
            print('Tap!!!');
          },
        )
      ],
    );
  }
}
