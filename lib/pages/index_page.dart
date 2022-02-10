import 'package:escolamobile/components/custom_bottom_bar_component.dart';
import 'package:escolamobile/pages/render_page.dart';
import 'package:escolamobile/services/pref_services.dart';
// import 'package:escolamobile/pages/render_page.dart';
// import 'package:escolamobile/services/pref_services.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);
  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Inicio',
      icon: Icon(Icons.house, size: 25),
    ),
    Tab(
      text: 'Novidades',
      icon: Icon(Icons.new_releases, size: 25),
    ),
    Tab(
        text: 'Perfil',
        icon: Icon(
          Icons.face_sharp,
          size: 25,
        )),
  ];

  late TabController _tabController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _selectedIndex;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'APP',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {
              PrefServices.logout();
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
        //backgroundColor: Colors.purple,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.blue.shade900),
        ),
        bottom: TabBar(
          labelStyle: const TextStyle(
              fontSize: 22.0, fontFamily: 'Family Name'), //For Selected tab
          unselectedLabelStyle:
              const TextStyle(fontSize: 15.0, fontFamily: 'Family Name'),
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          final String label = tab.text!.toLowerCase();
          return RenderPage(label: label, index: _tabController.index);
        }).toList(),
      ),
      bottomNavigationBar: Container(
          color: Colors.blue.shade900, child: CustomBottomBarWidget()),
    );
  }
}
