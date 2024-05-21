import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_riverpod/view/tabs/business_tab.dart';
import 'package:intern_riverpod/view/tabs/enter_tab.dart';
import 'package:intern_riverpod/view/tabs/health_tab.dart';
import 'package:intern_riverpod/view/tabs/tech_tab.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  int currentPageIndex = 0;

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'NEWS APP',
                style:
                    GoogleFonts.oswald().copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              // indicatorColor: Colors.purpleAccent[100],
              selectedIndex: currentPageIndex,
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.business),
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
                NavigationDestination(
                  icon: Badge(child: Icon(Icons.favorite)),
                  label: 'Health',
                ),
                NavigationDestination(
                  icon: Badge(
                    child: Icon(Icons.phone_android),
                  ),
                  label: 'Technology',
                ),
                NavigationDestination(
                  icon: Badge(
                    child: Icon(Icons.video_call),
                  ),
                  label: 'Entertainment',
                ),
              ],
            ),
            body: <Widget>[
              const BusinessTab(),
              const HealthTab()
              ,const TechTab(),
              const EntertainmentTab(),
            ]
            [currentPageIndex],
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'NEWS APP',
                style:
                    GoogleFonts.oswald().copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideMenu(
                  controller: sideMenu,
                  style: SideMenuStyle(
                    displayMode: SideMenuDisplayMode.open,
                    showHamburger: false,
                    hoverColor: Colors.blue[100],
                    selectedHoverColor: Colors.blue[100],
                    selectedColor: Colors.lightBlue,
                    selectedTitleTextStyle:
                        const TextStyle(color: Colors.white),
                    selectedIconColor: Colors.white,
                  ),
                  items: [
                    SideMenuItem(
                      title: 'Business',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.home),
                      tooltipContent: "This is a tooltip for Dashboard item",
                    ),
                    SideMenuItem(
                      title: 'Health',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.favorite),
                    ),
                    SideMenuItem(
                      title: 'Technology',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.phone_android),
                    ),
                    SideMenuItem(
                      title: 'Entertainment',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.video_call),
                    ),
                    SideMenuItem(
                      builder: (context, displayMode) {
                        return const Divider(
                          endIndent: 8,
                          indent: 8,
                        );
                      },
                    ),
                    SideMenuItem(
                      title: 'General News',
                      icon: const Icon(Icons.exit_to_app),
                      onTap: (index, _) {},
                    ),
                  ],
                ),
                const VerticalDivider(
                  width: 0,
                ),
                Expanded(
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    controller: pageController,
                    children: const [
                      BusinessTab(),
                      HealthTab(),
                      TechTab(),
                      EntertainmentTab(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
