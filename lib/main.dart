import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' ;
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:nappiweather/firebase_options.dart';
import 'package:nappiweather/home/home.dart';
import 'package:nappiweather/home/home_controller.dart';
import 'package:nappiweather/route/app_page.dart';
import 'package:nappiweather/route/app_routes.dart';


//import 'package:permission_handler/permission_handler.dart';

void main()async {

WidgetsFlutterBinding.ensureInitialized();
// ...

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  Get.put(HomeController());

bool serviceEnabled;
LocationPermission permission;

// Test if location services are enabled.
serviceEnabled = await Geolocator.isLocationServiceEnabled();


permission = await Geolocator.checkPermission();
if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
        Get.snackbar('', 'Location Permission Denied');
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

if (permission == LocationPermission.deniedForever) {
 // Permissions are denied forever, handle appropriately.
 return Future.error(
     'Location permissions are permanently denied, we cannot request permissions.');
}


  runApp(
    
    //DevicePreview(
      
      
     //enabled: true,
    //builder: (context) =>
     MyApp(),
    
    //)
    
    );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  StreamSubscription<ServiceStatus>? _locationServiceStatusStream;

bool _loading = true;
  String? _error;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _locationServiceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status == ServiceStatus.enabled) {
        // Location services turned on - recheck permissions
        requestLocationPermission();
      }
    });


        WidgetsBinding.instance.addPostFrameCallback((_) {
      requestLocationPermission();
    });
  }



  void dispose() {
  _locationServiceStatusStream?.cancel();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
   // requestLocationPermission(context);
print('dwidth${MediaQuery.of(context).size.width}');
print('dheight${MediaQuery.of(context).size.height}');

    return
    //MaterialApp(
     //home: 
     
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
     // initialRoute: Routes.HOME,
      home:  _loading
          ? SplashScreen() // Show a splash screen or loading screen
          : _error != null
              ? ErrorScreen(error: _error!) // Show error screen if permission is denied
              : HomeView(),
      );
   // );
    //  MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData.dark(),
    //   home: 
    //   HomeView()
     
    //  //WeatherMap()
    //  // WeatherDetail(),
    // );
  }

  Future<void> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _error = 'Location services are disabled. Please enable them.';
        _loading = false;
      });
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _error = 'Location permissions are denied. Please grant permission.';
          _loading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _error = 'Location permissions are permanently denied.';
        _loading = false;
      });
      return;
    }

    // If permission is granted, navigate to home screen
    setState(() {
      _loading = false;
    });
    Get.offAllNamed(Routes.HOME);
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(    0xff416ea9),
      body: Center(
        child: 
        Image.asset('asset/logo-icon.png',height: 60,)
        
        //CircularProgressIndicator(),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(error),
      ),
    );
  }
}