import 'package:flutter/material.dart';
import 'package:matcron/core/constants/constants.dart';
import 'dart:developer';
import 'package:matcron/core/resources/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
//import 'package:matcron/app/features/auth/presentation/pages/login.dart';
//import 'package:matcron/app/features/auth/presentation/pages/register.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'features/mattress/presentation/pages/mattress_page.dart';

Future<void> main() async {
  await initializeDependencies(); // Initialize all dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: HexColor("#E5E5E5"), // Set background color for the whole app
      ),
      //This is set to register for now, will change to the starting screen  once done. Wee need to show page depending on if user is logged in or not
      home: const MyHomePage(title: 'Flutter Demo Home Page'), 
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   /// Controller to handle PageView and also handles initial page
 final _pageController = PageController(initialPage: 0);

   /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

    int maxCount = 4;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }


 @override
  Widget build(BuildContext context) {
    /// widget list
    final List<Widget> bottomBarPages = [
      Dashboard(controller: _controller),
      MattressPage(),
      Container(color: Colors.green), //placeholder pages
      Container(color: Colors.yellow), //placeholder pages
    ]; 
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: matcronPrimaryColor,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,

              // notchShader: const SweepGradient(
              //   startAngle: 0,
              //   endAngle: pi / 2,
              //   colors: [Colors.red, Colors.green, Colors.orange],
              //   tileMode: TileMode.mirror,
              // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
              notchColor: const Color.fromARGB(228, 197, 197, 197),

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,

              itemLabelStyle: const TextStyle(fontSize: 10),

              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Color.fromARGB(255, 248, 250, 248),
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                     color:Color.fromRGBO(30, 167, 169, 1),
                  ),
                  itemLabel: 'Dashboard',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.star,
                   color:  Color.fromARGB(255, 248, 250, 248)),
                  activeItem: Icon(
                    Icons.star,
                    color:  Color.fromRGBO(30, 167, 169, 1),
                  ),
                  itemLabel: 'Mattress',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.settings,
                    color:  Color.fromARGB(255, 248, 250, 248),
                  ),
                  activeItem: Icon(
                    Icons.settings,
                    color:  Color.fromRGBO(30, 167, 169, 1),
                  ),
                  itemLabel: 'Type',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                  color: Color.fromARGB(255, 248, 250, 248),
                  ),
                  activeItem: Icon(
                    Icons.person,
                  color: Color.fromRGBO(30, 167, 169, 1) ,
                  ),
                  itemLabel: 'Firm',

                ),
              ],
              onTap: (index) {
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
}


  // @override
  // Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //         title: const Text('Login Page'),
  //       ),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
              
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => const MattressPage()),
  //                 );
  //               },
  //               child: const Text("Go to Mattress Page"),
  //             ),
  //             const SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => const RegisterPage()),
  //                 );
  //               },
  //               child: const Text("Go to Register Page"),
  //             ),
  //             const SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => const LoginPage()),
  //                 );
  //               },
  //               child: const Text("Go to Login Page"),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  // }
}
/// add controller to check weather index through change or not. in page 1
class Dashboard extends StatelessWidget {
  final NotchBottomBarController? controller;

  const Dashboard({super.key, this.controller}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 248, 250, 248),
      child: Center(
        /// adding GestureDetector
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller?.jumpTo(2);
          },
          child: const Text('Dashboard'),
        ),
      ),
    );
  }
}








  
