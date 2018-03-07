import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TabBar makeTabBar() {
    return TabBar(tabs: <Tab>[
      Tab(
        icon: Icon(Icons.home),
      ),
      Tab(
        icon: Icon(Icons.settings_power),
      ),
    ], controller: tabController);
  }

  TabBarView makeTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          bottom: makeTabBar(),
        ),
        body: makeTabBarView(<Widget>[TheGridView().build(), SimpleWidget()]),
      ),
    );
  }
}

class SimpleWidget extends StatefulWidget {
  @override
  SimpleWidgetState createState() => SimpleWidgetState();
}

class SimpleWidgetState extends State<SimpleWidget> {
  int stepCounter = 0;
  List<Step> steps = [
    Step(
      title: Text("Step One"),
      content: Text("This is the first step"),
      isActive: true,
    ),
    Step(
      title: Text("Step Two"),
      content: Text("This is the second step"),
      isActive: true,
    ),
    Step(
      title: Text("Step Three"),
      content: Text("This is the Third step"),
      state: StepState.editing,
      isActive: true,
    ),
    Step(
      title: Text("Step Four"),
      content: Text("This is the fourth step"),
      isActive: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        currentStep: this.stepCounter,
        steps: steps,
        type: StepperType.vertical,
        onStepTapped: (step) {
          setState(() {
            stepCounter = step;
          });
        },
        onStepCancel: () {
          setState(() {
            stepCounter > 0 ? stepCounter -= 1 : stepCounter = 0;
          });
        },
        onStepContinue: () {
          setState(() {
            stepCounter < steps.length - 1 ? stepCounter += 1 : stepCounter = 0;
          });
        },
      ),
    );
  }
}

class TheGridView {
  Card makeGridCell(String name, IconData icon) {
    return Card(
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Center(child: Icon(icon)),
          Center(child: Text(name)),
        ],
      ),
    );
  }

  GridView build() {
    return GridView.count(
        primary: true,
        padding: EdgeInsets.all(1.0),
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          makeGridCell("Home", Icons.home),
          makeGridCell("Email", Icons.email),
          makeGridCell("Chat", Icons.chat_bubble),
          makeGridCell("News", Icons.new_releases),
          makeGridCell("Network", Icons.network_wifi),
          makeGridCell("Options", Icons.settings),
        ]);
  }
}
