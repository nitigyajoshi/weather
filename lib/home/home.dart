import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nappiweather/home/home_controller.dart';
import 'package:nappiweather/home/weather_box.dart';
import 'package:nappiweather/models/fore_cast_response_model.dart';
import 'package:nappiweather/weather_detail/menuitem.dart';
import 'package:nappiweather/weather_detail/weather_detail_view.dart';


import 'package:video_player/video_player.dart';

import 'package:webview_flutter/webview_flutter.dart';


class WeatherData{
String temp;
String day;
String probablity;
IconData icon;
WeatherData(this.temp,this.day,this.probablity,this.icon);
}
List <WeatherData>data=[

WeatherData('25°C', 'Sunday', '30 % chances of rain', Icons.sunny),
WeatherData('22°C', 'Monday', '40 % chances of rain', Icons.cloudy_snowing),
WeatherData('45°C', 'Tuesday', '50 % chances of rain', Icons.cloud),
WeatherData('35°C', 'Wednesday', '70 % chances of rain', Icons.water),
];
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
   
   HomeController controller=Get.find();
 late final WebViewController _controller;

  Future<void> openDialog(HttpAuthRequest httpRequest) async {
    final TextEditingController usernameTextController =
        TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${httpRequest.host}: ${httpRequest.realm ?? '-'}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  autofocus: true,
                  controller: usernameTextController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: passwordTextController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // Explicitly cancel the request on iOS as the OS does not emit new
            // requests when a previous request is pending.
            TextButton(
              onPressed: () {
                httpRequest.onCancel();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                httpRequest.onProceed(
                  WebViewCredential(
                    user: usernameTextController.text,
                    password: passwordTextController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Authenticate'),
            ),
          ],
        );
      },
    );
  
}



  Stream<List<Map<String, dynamic>>> fetchRecentUploads() {
    return FirebaseFirestore.instance
        .collection('uploads')
        .orderBy('date', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }
  HomeController hcontroller=Get.find();
   // hcontroller.fetchWeatherForecast16Days();
late Future<WeatherResponse> weatherData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    weatherData =hcontroller. fetchWeatherForecast16Days();

   // controller.getPosition();
   // #docregion platform_features

  }

    WebViewController webViewController = WebViewController();

 
  @override
  Widget build(BuildContext context) {
      late VideoPlayerController _controller;
        late Future<void> _initializeVideoPlayerFuture;





       controller. getPosition();
       DateTime now = DateTime.now();
        int sunriseTimestamp=0;
if (controller.currentWeatherData.isNotEmpty) {
   sunriseTimestamp = controller.currentWeatherData[0].sys.sunrise ?? 0;
controller.sunriseHour.value=sunriseTimestamp;

  // Now you can safely use sunriseTimestamp
}
      // int sunriseTimestamp = 
       //0;
    //   controller.currentWeatherData[0].sys.sunrise??0; // Sunrise timestamp in seconds
int sunsetTimestamp =0;

//= 
//0;
if (controller.currentWeatherData.isNotEmpty) {
//sunsetTimestamp
controller.sunsetHour.value=controller.currentWeatherData[0].sys.sunset;   // Now you can safely use sunriseTimestamp
}
// controller.currentWeatherData[0].sys.sunset; 
DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
DateTime sunset = DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);
       List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
       String dayOfWeek = now.weekday.toString();
       String dayName = days[now.weekday - 1];



       
    return Scaffold(
   backgroundColor: Color(    0xff416ea9),
   
      body: SafeArea(
        child: Container(padding: EdgeInsets.all(12),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color:
         Color(
        
          0xff416ea9
          
         )
         
         
        
          ),
          child: SingleChildScrollView(
            child: Stack(children: [
              
                    
                    SizedBox(height: 5,),
                    
                    // bros code 
                    //   child:
                    
                    
                    Container(
            
                     // color: Colors.red,
            constraints: BoxConstraints(
              maxHeight:
              800
              // MediaQuery.of(context).size.height * 0.8, // Limit max height but allow it to grow
            ),
            child: Column(
              children: [
                    
                // GestureDetector(
                  
                //   onTap: (){
                //     print('ooo');
                //   },
                //   child: Container(
                    
                //     height: 50,color: Colors.green,
                //     child: Icon(Icons.abc))),
                    
                    Container(height: 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      // GestureDetector(
                      //   onTap: (){
            
                      //     print('ooo');
                      //   },
                      //   child: Container(
                      //     height: 50,
                      //     child: Icon(Icons.abc))),
                      Padding(
                        padding: const EdgeInsets.only(top:
                        0
                        //10.0
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MenuItem()));
                              
                             //  Get.to(()=>MenuItem());
                               
                               //      _showOptionsDialog(context);
                    
                        
                          },
                          child: Icon(Icons.menu,size: 30,)),
                    
                    
                      ),
                          Padding(
                          padding: const EdgeInsets.only(
                            left: 50
                          //  left:250.0,
                                               //   bottom: 15
                            //top:
                          //5
                          //,bottom: 30
                          // 10
                          ),
                          child: 
                          Image.asset('asset/logo-icon.png',height: 60,)
                                            
                                      ),
                        ],
                      ),
                    ),
                StreamBuilder<List<Map<String, dynamic>>>(
              stream: fetchRecentUploads(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No recent uploads.'));
                }
                
                final uploads = snapshot.data!;
                
                return Padding(
                  padding:  EdgeInsets.only(bottom:
                  MediaQuery.of(context).size.height/1.86
                  
                  //380.0
                  ),
                  child: Container(height:
                  MediaQuery.of(context).size.hashCode>1500?250:
                   200,
                    child: ListView.builder(
                      //shrinkWrap: true,
                    
                      scrollDirection: Axis.horizontal,
                      itemCount: uploads.length,
                      itemBuilder: (context, index) {
                        final upload = uploads[index];
                        if (upload['isVideo']) {
                          return SizedBox(
                            height: 600,
                              width: MediaQuery.of(context).size.width /1.1,
                              
                              //* 0.7,
                            child: VideoItem(videoUrl: upload['url']));
                        } else {
                          return SizedBox(height: 200,
                              width: MediaQuery.of(context).size.width * 0.7,
                            child: ImageItem(imageUrl: upload['url']));
                        }
                      },
                    ),
                  ),
                );
              },
            ),
              ],
            ),
                    ),
                    
            //  _controller = VideoPlayerController.network('https://firebasestorage.googleapis.com/v0/b/jason-nappi-weather.appspot.com/o/videos%2F2024-09-21%2020%3A26%3A03.620451.mp4?alt=media&token=fd7ab5a5-c1bf-454d-b6db-bda894cac6d0')
            //     ..addListener(() {
            //       setState(() {}); // Refresh the UI when the video's state changes
            //     });
             
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
            Padding(
              padding: const EdgeInsets.only(top:
              
              360.0,
              //left: 50
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    
                Obx(()=>controller.currentWeatherData.isEmpty?Container(): Image.network('http://openweathermap.org/img/wn/${controller.currentWeatherData[0].weather[0].icon}.png'
                
                ,height: 60,width: 60,
                
                ),
                
                
                
                ),
               // Obx(()=>Text('${DateTime.fromMillisecondsSinceEpoch(controller.sunriseHour.value * 1000)}')),
                //Icon(Icons.cloud,size: 44,),
              Text('${dayName}',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),)
                    ],)
             ,Padding(
               padding: const EdgeInsets.only(left:38.0),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                
                Column(
                 children: [
                 // Obx(()=>Text(controller.dayForecasts.length.toString())),
                   Obx(()=>controller.currentWeatherData.isEmpty?Container():
                   Text('${controller.currentWeatherData[0].main.temp} °K',style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize:  19
                                   ),),
                   ),
                 //  Obx(()=>
                //  Text('${controller.currentWeatherData[0].main.}  
                  //Mariene Beach ,USA',style: TextStyle(    fontWeight: FontWeight.bold,    fontSize: 21
                            //       )),
                 //  ),
                         //      Obx(()=>Text(controller.airPollutionSummaries.length.toString(),style: TextStyle(color: Colors.red),)),
                 Obx(()=>
                 
                 controller.currentWeatherData.isEmpty?Container():
                 Text(controller.currentWeatherData[0].name,style: TextStyle(   fontSize: 19,fontWeight: FontWeight.bold),)),
                   Obx(
                    ()=> controller.currentWeatherData.isEmpty?Container(): Text('  ${controller.currentWeatherData[0].weather[0].description}',style: TextStyle(color:
                     
                      Colors.white
                     
                      
                     ,fontSize: 19,fontWeight: FontWeight.bold
                     ),),
                   ),
               
                  
                 ],
               )],),
             ) ],),
                    
            ],),
            
            ),
                    
                    Padding(padding: EdgeInsets.only(top: 450),child: Column(
            children: [
             //       Obx(()=>controller.currentWeatherData.isEmpty?Center():Text(')),
                    Container(height: 150,
            child: 
            Obx(
            ()=>controller.currentWeatherData.isEmpty?Center(child: CircularProgressIndicator(),):
            controller.currentWeatherData.length==0?Center(child: CircularProgressIndicator(),)
            : Padding(
              padding:  EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width>500?100:0  ),
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                      
                   
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    
                    color: Color.lerp(Colors.blue, Colors.white, 0.3),
                  ),
                    height: 80,width:
                    MediaQuery.of(context).size.width>500?250:
                     150,
                          child:     Obx(()=> weatherBox('Sunrise','${DateTime.fromMillisecondsSinceEpoch(controller.currentWeatherData[0].sys.sunrise * 1000).hour}: ${DateTime.fromMillisecondsSinceEpoch(controller.currentWeatherData[0].sys.sunrise * 1000).minute}','Sunset','${DateTime.fromMillisecondsSinceEpoch(controller.currentWeatherData[0].sys.sunset * 1000).hour}: ${DateTime.fromMillisecondsSinceEpoch(controller.currentWeatherData[0].sys.sunrise * 1000).minute}')),
                  // :i==1?
                
                    //Text('data')
                    
                  //  i==0?
                
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    
                    color: Color.lerp(Colors.blue, Colors.white, 0.3),
                  ),
                    height: 80,width: 
                    
                    MediaQuery.of(context).size.width>500?250:
                    150,
                          child:                
                   //:
                    weatherBox('Wind', '${controller.currentWeatherData[0].wind.speed} m/s', 'Pressure', '${controller.currentWeatherData[0].main.pressure} mbar')
                  // :i==1?
                
                    //Text('data')
                    
                  //  i==0?
                
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    
                    color: Color.lerp(Colors.blue, Colors.white, 0.3),
                  ),
                    height:
                    
                   // MediaQuery.of(context).size.width>500?120:
                     80,width:
                    
                    MediaQuery.of(context).size.width>500?250:
                     150,
                          child:               weatherBox('Humidity','${controller.currentWeatherData[0].main.humidity}%','Rain','${controller.currentWeatherData[0].rain?.oneHour??0}mm'),
                  // :i==1?
                
                    //Text('data')
                    
                  //  i==0?
                
                  ),
                ),
                ],),
            ),
            )
            
            // ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemBuilder: (context,i){
            // return Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(40),
                
            //     color: Color.lerp(Colors.blue, Colors.white, 0.3),
            //   ),
            //     height: 80,width: 150,
                    
            //     child:
            //     //Text('data')
                
            //   //  i==0? weatherBox('Sunrise','${controller.currentWeatherData[0].sys.sunrise}','Sunset','${controller.currentWeatherData[0].sys.sunset}',):i==1?weatherBox('Sunrise','','Sunset',''):
            //  //   weatherBox('Wind', '${controller.currentWeatherData[0].wind.speed} m/s', 'Pressure', '${controller.currentWeatherData[0].main.pressure}')
            //   ),
            // );
            // },itemCount: 3,),
                    )
                    ,
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Weather Map',style: TextStyle(fontSize: 18),)),
                SizedBox(height: 15,),
              Container(height:MediaQuery.of(context).size.height>1500?800:   MediaQuery.of(context).size.height>1000?500: 
            //  MediaQuery.of(context).size.height>600?500:
              300,
             // 240,
              width: MediaQuery.of(context).size.width,
                        child: WebViewWidget(
                      controller: webViewController  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    
                        ..loadRequest(Uri.parse('https://jason-nappi-weather.web.app')),
                        gestureRecognizers: {
              Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer()
              ),
                    
                    
               Factory<HorizontalDragGestureRecognizer>(
                      () => HorizontalDragGestureRecognizer()
              )
            },
                        )
                    
                    
                    
                    
              //child:
            //      Webview(url: "https://www.wechat.com/en")
              
              
              // Colors.black,
              
              
              )
                  ,
                  
            // Obx(()=>Text(controller.currentWeatherData.length.toString())),
                    //         FutureBuilder(future: controller.fetchWeather(), builder: (context,snapshot){
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //               return CircularProgressIndicator();
                    //             } else if (snapshot.hasError) {
                    //               return Text('${snapshot.error}');
                    //             } else if (snapshot.hasData) {
                    //               controller.fetchWeather();
                    //               final weather = snapshot.data!;
                    
                    //       //     print('wwwws${controller.fetchWeather()}');
                    //               return Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
              
                    //                   Text('Location: ${weather.name}, ${weather.sys.country}'),
                    //                   Text('Temperature: ${(weather.main.temp - 273.15).toStringAsFixed(2)}°C'),
                    //                   Text('Weather: ${weather.weather[0].description}'),
                    //                 ],
                    //               );
                    //             } else {
                    //               return Text('No weather data available');
                    //             }
                    
                    //         })
                  
                  
                  
            ],
                    ),),
                    
             
                
                    
                    
                    
                    ],),
          )
        
        
        //,
        ),
      ),
      bottomNavigationBar: Container(height: MediaQuery.of(context).size.height>1500?350:
      
      MediaQuery.of(context).size.height>1000?250:
      170
      ,decoration: BoxDecoration(
color: 
Colors.blue,

//Color.lerp(Colors.blue, Colors.white, 0.3),
//Colors.white,

borderRadius: BorderRadius.only(topLeft: Radius.circular(50),
topRight: Radius.circular(50),
),
      ),
      
      child: Column(children: [
      SizedBox(height:MediaQuery.of(context).size.height>1500?50: 10,),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('       Weekly',style: TextStyle(
      color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18
          ),),
      
      
        ],
      )
      ,
      Container(height:MediaQuery.of(context).size.height>1500?200:
       MediaQuery.of(context).size.height>1000?160:
      
       120
      
      , width: MediaQuery.of(context).size.width,
      child:
      
     
      Container(height:
      MediaQuery.of(context).size.height>1500?280:
       MediaQuery.of(context).size.height>1000?140:
      100
      ,width: MediaQuery.of(context).size.width,
        child: Obx(
          ()=>controller.dayForecasts.isEmpty?Center(child: CircularProgressIndicator(),): Padding(padding: 
         EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width>500?  MediaQuery.of(context).size.width/7:     10),
      child: ListView.builder(
        
        itemCount: controller.dayForecasts[0].weatherList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) { 
       
      int timestamp = controller.dayForecasts[0].weatherList[index].dt;
      
      //1726225200; // example timestamp from the API
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000); 
      String dayOfWeek = getDayOfWeek(dateTime);
      
      return 
                    GestureDetector(
                      onTap: (){
                         print('ii ${index}');
                 //       Get.toNamed(Routes.weatherDetail);
                        Get.to(()=>WeatherDetail(),arguments: {
      
                       'data' :  controller.dayForecasts[0].weatherList[index],
                       'air':controller.airPollutionSummaries.value,
                       'city':controller.dayForecasts[0].city.name,
                       'day':dayOfWeek
                        });
                       
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 
                          MediaQuery.of(context).size.height>1500?250:
                          MediaQuery.of(context).size.width>500?150:
                          125
                          ,width: MediaQuery.of(context).size.width>1100?160:
                          MediaQuery.of(context).size.width>=800?140:100,
                          //100:
                           //85,
                          
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                          
                            borderRadius: BorderRadius.circular(50)
                        
                          ),
                          child: Center(
                            child: Column(children: [
                                               SizedBox(height: 5,),
                              Text('$dayOfWeek',style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width>1100?22: 15),),
                            Obx(()=>
                            
                                            Image.network('http://openweathermap.org/img/wn/${controller.dayForecasts[0].weatherList[index].weather[0].icon}.png',height:MediaQuery.of(context).size.width>1100? 100:50,)
                                             // Image.network('${controller.dayForecasts[0].weatherList[index].weather[0].icon}')
                            
                            ),
                              //Text('data'),
                             Obx(()=>Text('${controller.dayForecasts[0].weatherList[index].feelsLike.day.toString()}°K',style: TextStyle(

                              fontSize: MediaQuery.of(context).size.width>1100?22: 15
                             ),))
                                           //, SizedBox(height: 10,),
                              ,  SizedBox(height: 5,),             
                            ],),
                          ),
                          ),
                      ),
                    );
         },),
          ),
        ),
      )
      
      //             }
      //             else{
      //   return Text('No data found');}
      // }),
      )
      
      
      
      ],),
      ),
    );
  }

  data()async{
 //   print('hhhg');
var d=await controller.fetchWeatherForecast16Days();
print('hhhg${d}');


}
String getDayOfWeek(DateTime dateTime) {
  return DateFormat('E').format(dateTime); // 'EEEE' returns the full name of the day (e.g., Sunday, Monday)
}



  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About Us'),
                onTap: () {
                  // Handle About Us action
                  Navigator.pop(context);
                  _showAboutUs(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Contact Us'),
                onTap: () {
                  // Handle Contact Us action
                  Navigator.pop(context);
                  _showContactUs(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }


  void _showAboutUs(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('About Us'),
          content: Text('We aims to provide weather data to all  .'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showContactUs(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contact Us'),
          content: Text('You can contact us at: jasonnappi319@gmail.com'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}




class VideoItem extends StatefulWidget {
  final String videoUrl;

  const VideoItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    
    super.initState();
  
    // weatherData = fetchWeatherForecast16Days();

   // hcontroller.fetchWeatherForecast16Days();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        setState(() {}); // Refresh the UI when the video's state changes
      });
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //HomeController hcontroller=Get.find();
  //  hcontroller.fetchWeatherForecast16Days();
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height:
                //  500,
                   400, 
                  width: 
                  MediaQuery.of(context).size.width,
               //   MediaQuery.of(context).size.width/1.5,
                //  600,// Set a fixed height for the video container
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              // Play icon overlay
              if (!_controller.value.isPlaying || _controller.value.position == _controller.value.duration)
                IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    size: 64,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.play();
                    });
                  },
                ),
              // Pause icon overlay when playing
              if (_controller.value.isPlaying)
                IconButton(
                  icon: Icon(
                    Icons.pause,
                    size: 64,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.pause();
                    });
                  },
                ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
class ImageItem extends StatelessWidget {
  final String imageUrl;

  const ImageItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        child: Container(
          
          height: 200,width: 500,

          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(imageUrl, )
            
            
            ,fit: BoxFit.cover)
          ),)
        //  child: Image.network(imageUrl, fit: BoxFit.cover)),
      )
      // subtitle: Center(
      //   child: Container(
          
      //     height: 200,width: 500,

      //     decoration: BoxDecoration(
      //       image: DecorationImage(image: NetworkImage(imageUrl, )
            
            
      //       ,fit: BoxFit.cover)
      //     ),)
      //   //  child: Image.network(imageUrl, fit: BoxFit.cover)),
      // ),
    );
  }
}