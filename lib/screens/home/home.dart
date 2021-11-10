import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/controllers/searchController.dart';

import 'package:ichops/models/payments.dart';

import 'package:ichops/screens/home/widgets/drawer.dart';
import 'package:ichops/screens/home/widgets/favourite_Cart.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'widgets/products.dart';
import 'widgets/searchbox.dart';
import 'widgets/shopping_cart.dart';

PersistentTabController _controller;

class HomeScreen extends StatefulWidget {
  final int selectedIndex;
  HomeScreen({
    Key key,
    this.paymentsModel,
    this.myBatch,
    this.selectedIndex,
  }) : super(key: key);

  final String myBatch;
  final PaymentsModel paymentsModel;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  bool showSearchBox = false;
  QuerySnapshot snapshotData;

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(
      initialIndex: 0,
    );
    return Obx(
      () => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: DoubleBack(
          message: "Press back again to close iChops",
          background: myRed,
          child: Scaffold(
            drawer: DrawerMenu(),
            appBar: AppBar(
              shape: RoundedRectangleBorder(),
              actions: [
                IconButton(
                  onPressed: () {
                    showBarModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                            color: Colors.white, child: FavouriteWidget()));
                  },
                  icon: Icon(
                    FontAwesomeIcons.solidHeart,
                    color: myRed,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showBarModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                            color: Colors.white, child: ShoppingCartWidget()));
                  },
                  icon: Icon(
                    FontAwesomeIcons.shoppingCart,
                  ),
                ),
              ],
              backgroundColor: myPrimaryColor,
              elevation: 0.0,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                    40.0,
                  ), // here the desired height
                  child: Column(children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          "Welcome, " + userController.userModel.value.name ??
                              "",
                          style: GoogleFonts.barlowCondensed(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20)
                  ])),
            ),
            body: Stack(
              children: [
                Container(
                  color: myPrimaryColor,
                ),
                PersistentTabView(
                  context,
                  controller: _controller,
                  screens: _buildScreens(),
                  items: _navBarsItems(),
                  confineInSafeArea: true,
                  backgroundColor: myPrimaryColor,
                  handleAndroidBackButtonPress: true, // Default is true.
                  resizeToAvoidBottomInset:
                      true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                  stateManagement: true, // Default is true.
                  hideNavigationBarWhenKeyboardShows:
                      true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                  decoration: NavBarDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                    colorBehindNavBar: myPrimaryColor,
                  ),
                  popAllScreensOnTapOfSelectedTab: true,
                  popActionScreens: PopActionScreensType.all,
                  itemAnimationProperties: ItemAnimationProperties(
                    // Navigation Bar's items animation properties.
                    duration: Duration(milliseconds: 200),
                    curve: Curves.bounceInOut,
                  ),
                  screenTransitionAnimation: ScreenTransitionAnimation(
                    // Screen transition animation on change of selected tab.
                    animateTabTransition: true,

                    curve: Curves.ease,
                    duration: Duration(milliseconds: 200),
                  ),
                  navBarStyle: NavBarStyle
                      .style1, // Choose the nav bar style with this property.
                  onItemSelected: (int index) {
                    index = widget.selectedIndex;
                    print(index);
                  },
                ),
              ],
              //
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    FoodWidget(),
    DrinksWidget(),
    SnacksWidget(),
    MeatWidget(),
    OthersWidget(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        "assets/icons/food.svg",
        color: Colors.white,
      ),
      title: ("Food"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        "assets/icons/drinks.svg",
        color: Colors.white,
      ),
      title: ("Drinks"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        "assets/icons/snacks.svg",
        color: Colors.white,
      ),
      title: ("Snacks"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        "assets/icons/meat.svg",
        color: Colors.white,
      ),
      title: ("Meat"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        "assets/icons/others.svg",
        color: Colors.white,
      ),
      title: ("Others"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
