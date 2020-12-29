import 'package:flutter/material.dart';
import 'package:flutter_template/res.dart';
import 'package:flutter_template/ui/dashboard/settings_screen.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';

class DashboardScreen extends StatefulWidget {
		static const routeName = '/dashboard';
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> with
    AutomaticKeepAliveClientMixin<DashboardScreen>{

  bool get wantKeepAlive => true;

  int _selectedIndex = 0;
  PageController _c;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    super.initState();
    _c = PageController(
      initialPage: _selectedIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   brightness: Brightness.light,
      //   elevation: 0,
      //   title: xText(text: "Select plan", color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17.0),
      //   centerTitle: true,
      // ),
      body: preparePageView(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _prepareIcon(Res.ic_circular_google, 0),
            activeIcon: _prepareIcon(Res.ic_circular_google, 0),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: _prepareIcon(Res.ic_circular_google, 0),
            activeIcon: _prepareIcon(Res.ic_circular_google, 0),
            label: "Calls",
          ),
          BottomNavigationBarItem(
            icon: _prepareIcon(Res.ic_circular_google, 0),
            activeIcon: _prepareIcon(Res.ic_circular_google, 0),
            label: "Credits",
          ),
          BottomNavigationBarItem(
            icon: _prepareIcon(Res.ic_circular_google, 0),
            activeIcon: _prepareIcon(Res.ic_circular_google, 0),
            label: "Settings",
          ),
        ],
        onTap: (index) {
          this._c.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        currentIndex: _selectedIndex,
        selectedItemColor: ColorsX.watermelon,
        unselectedItemColor: ColorsX.coolGrey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 20,
      ),
    );
  }
  Widget preparePageView() {
    return PageView(
      controller: _c,
      onPageChanged: (newPage) {
        setState(() {
          this._selectedIndex = newPage;
        });
      },
      children: <Widget>[

        SettingsScreen()
       
      ],
    );
  }

  Widget _prepareIcon(String icon, int count) {
    return Container(
      width: 32,
      height: 28,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: ImageIcon(AssetImage(icon), size: scale.size(32)),
          ),
          count > 0
              ? Positioned(
            right: 0,
            child: new Container(
              width: 6,
              height: 6,
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                color: ColorsX.error,
                borderRadius: BorderRadius.circular(8),
              ),
              child: new Text(
                '',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
              : Container(
            width: 0,
            height: 0,
          )
        ],
      ),
    );
  }
}