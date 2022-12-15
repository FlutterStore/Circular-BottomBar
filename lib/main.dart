import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late CircularBottomNavigationController _navigationController;

  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.home,
      "Menu 1",
      Colors.green,
      labelStyle: TextStyle(
        fontSize: 13,
      ),
    ),
    TabItem(
      Icons.search,
      "Menu 2",
      Colors.green,
      labelStyle: TextStyle(
        fontSize: 13,
      ),
    ),
    TabItem(
      Icons.layers,
      "Menu 3",
      labelStyle: TextStyle(
        fontSize: 13,
      ),
      Colors.green,
    ),
    TabItem(
      Icons.notifications,
      "Menu 4",
      labelStyle: TextStyle(
        fontSize: 13,
      ),
      Colors.green,
    ),
  ]);

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("Circular BottomBar",style: TextStyle(fontSize: 15),),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            child: bodyContainer(),
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }
   Widget bodyContainer() {
    Color? selectedColor = tabItems[selectedPos].circleColor;
    String slogan;
    switch (selectedPos) {
      case 0:
        slogan = "Menu 1";
        break;
      case 1:
        slogan = "Menu 2";
        break;
      case 2:
        slogan = "Menu 3";
        break;
      case 3:
        slogan = "Menu 4";
        break;
      default:
        slogan = "";
        break;
    }

    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            slogan,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
      ),
      onTap: () {
        if (_navigationController.value == tabItems.length - 1) {
          _navigationController.value = 0;
        } else {
          _navigationController.value = _navigationController.value! + 1;
        }
      },
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      iconsSize: 20,
      circleSize: 55,
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: 50,
      barBackgroundColor: Colors.white,
      backgroundBoxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}


