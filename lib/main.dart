import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}


class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}


class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;


  final RestorableInt tabIndex = RestorableInt(0);


  @override
  String get restorationId => 'tab_non_scrollable_demo';


  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }


  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }


  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
// For the ToDo task hint: consider defining the widget and name of the tabs here
    final tabs = ['Alert Dialog', 'Bottom App Bar', 'Text Inputs', 'Card Widget'];
    final tabColors = [
      Colors.red.shade100,
      Colors.green.shade100,
      Colors.blue.shade100,
      Colors.purple.shade100,
    ];


     return Scaffold(
      appBar: AppBar(
        title: Text('Customized Tabs'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Alert Dialog
          Container(
            color: tabColors[0],
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Alert Dialog'),
                      content: Text('This is an alert dialog.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Show Alert Dialog'),
              ),
            ),
          ),
          // Tab 2: Bottom App Bar
          Container(
            color: tabColors[1],
            child: Center(
              child: Scaffold(
                bottomNavigationBar: BottomAppBar(
                  color: Colors.green,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {},
                  ),
                ),
                body: Center(child: Text('Bottom App Bar Demo')),
              ),
            ),
          ),
          // Tab 3: Text Inputs
          Container(
            color: tabColors[2],
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter text',
                  ),
                ),
              ),
            ),
          ),
          // Tab 4: Card Widgets
          Container(
            color: tabColors[3],
            child: Center(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'This is a card widget.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}