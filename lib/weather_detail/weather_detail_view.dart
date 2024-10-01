import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:nappiweather/models/daily_frecast.dart';


class WeatherDetail extends StatefulWidget {
  const WeatherDetail({super.key});

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
   //GoogleMapController? _controller;
   var weatherlist=Get.arguments['data'] as WeatherList;

DateTime dateTime = DateTime.fromMillisecondsSinceEpoch((Get.arguments['data'].dt) * 1000);


  @override
  Widget build(BuildContext context) {

var aqi=0.0.obs;
var msg="".obs;
var lineValue=0.0.obs;
print(Get.arguments['air'][0].date);
print(dateTime);
for (var i = 0; i < Get.arguments['air'].length; i++) {
  if ((Get.arguments['air'][i].date.year==dateTime.year)&&(Get.arguments['air'][i].date.month==dateTime.month)&&(Get.arguments['air'][i].date.day==dateTime.day)) {
     aqi.value=Get.arguments['air'][0].averageAqi;
if (aqi.value==1) {
  msg.value="Good";
  lineValue.value=0.2;
}
else if (aqi.value==2) {
  msg.value="Fair";
    lineValue.value=0.4;

}
else if (aqi.value==3) {
  msg.value="Moderate";
    lineValue.value=0.6;

}
else if (aqi.value==4) {
  msg.value="Poor";
    lineValue.value=0.8;

}
else{
  msg.value=" Very Poor";
    lineValue.value=1;

}
    // Obx(()=>Text(Get.arguments['air'][0].averageAqi.toString())),
  }
 
}





    return Scaffold(
      backgroundColor: Color(0xff416ea9),
body: ListView(children: [
// Container(height: 300,


// ),
// Container(
// height:50,
// child:     FlutterMap(
//       options: MapOptions(
//         initialCenter: LatLng(51.505, -0.09), // Set initial position
//         minZoom: 5.0, // Set initial zoom level
//       ),
//       children: [
//         TileLayer(
//           urlTemplate: 'https://tile.openweathermap.org/map/precipitation_new/2/2/2.png?appid=f5bff1c82f39caaa08cb1f4316d0f9cc',
//           additionalOptions: {
//             'layer': 'precipitation_new', // Replace with the desired layer (e.g., 'temp', 'precipitation')
//           },
//        //   subdomains: ['a', 'b', 'c'],
//         ),
//       ],
//     )
// ),

Row(children: [
GestureDetector(onTap: (){

  Get.back();
},
  child: Padding(
    padding: const EdgeInsets.only(left:8.0,top: 8),
    child: CircleAvatar(child: Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: Center(
        child: Icon(Icons.arrow_back_ios
        ,color: Colors.black,size: 22,
        
        ),
      ),
    ),
    backgroundColor: Colors.white,
    ),
  ),
),

//Text(Get.arguments.toString())
],)
,
//Text('${Get.arguments['air'][0].date}'),


//Text('${dateTime.year}' ),
SizedBox(height: 30,),

Align(
  
  alignment: Alignment.topLeft,
  child: Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left:18.0),
        child:
         Image.network('http://openweathermap.org/img/wn/${Get.arguments['data'].weather[0].icon}.png')
        // Icon(Icons.cloud,size: 60,),
      ),

      Column(
        children: [
         // Text(aqi),
         
//aqi==null?Container():Text(aqi.toString()),
//Obx(()=>Text(Get.arguments['data'].dt.toString())),
        //  Obx(()=>Text(Get.arguments['air'][0].averageAqi.toString())),
          Padding(
            padding: const EdgeInsets.only(left:25.0),
            child:Text('${Get.arguments['city']}',style: TextStyle(
          
              fontSize: 22,fontWeight: FontWeight.bold
            ),),
          ),
        
          Padding(
            padding: const EdgeInsets.only(left:25.0),
           child:
            Text('${Get.arguments['data'].feelsLike.day.toString()}° K',style: TextStyle(
          
              fontSize: 22,fontWeight: FontWeight.bold
           ),),
          ),
        
          Padding(
            padding: const EdgeInsets.only(left:25.0),
            child:Text('${Get.arguments['data'].weather[0].description}',style: TextStyle(
          
              fontSize: 22,fontWeight: FontWeight.bold,
              color: Colors.white
            ),),
          ),
        
        //dateTime==Get.arguments['air'][0].date?Text('data1'):Text('data2')
        
        ],
      ),

    ],
  )),
  Align(alignment: Alignment.topLeft,child: Padding(
      padding: const EdgeInsets.only(left:30.0),
    child: Text('${Get.arguments['day']}',style: TextStyle(

      fontWeight: FontWeight.bold,
      fontSize: 18
    ),),
  ),),
SizedBox(height: 10,),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
   
    child: Container(
    height: 150,
    
    width: 
    200,
    //MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
    color: Color.lerp(Colors.blue, Colors.white, 0.3)
    //(
    //0xffEF5C2A
    //),
    
    
      ),
    child:Stack(children: [


   //   dateTime==Get.arguments['air'][0].date?
Align(
  
  alignment: Alignment.topLeft,
  child: Padding(
    padding: const EdgeInsets.only(left:28.0,top: 15),
    child: Row(
      children: [
        Text('Air Quality ',style: TextStyle(
        fontSize: 22,fontWeight: FontWeight.bold
        
        ),),


       
      ],
    ),
  )),



//Text(Get.arguments['air'].toString()),
Padding(
  padding: const EdgeInsets.only(top:100.0,left: 25),
  child: Row(

    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Obx(
        ()=>msg.value!=""? Text('$msg  ',style: TextStyle(
        fontSize: 22,fontWeight: FontWeight.bold
        
          ),
          
          ):Text('No Data  '),
      ),


       Obx(()=>aqi.value!=0.0?Text('${aqi.value}    ',style: TextStyle(
        fontSize: 22,fontWeight: FontWeight.bold
        
          ),
          ):Text('No data   ',style: TextStyle(
        fontSize: 22,fontWeight: FontWeight.bold
        
          ),
          ))
    ],
  ),
)
,
Padding(
  padding: const EdgeInsets.only(top:60.0
  ,left: 20,right: 20
  
  ),
  child: Obx(
    ()=> LinearProgressIndicator(
    value:
    lineValue.value,
    // 1,
    minHeight: 10,
    
    ),
  ),
),


// Align(
//   alignment: Alignment.bottomRight,
//   child: Padding(
//     padding: const EdgeInsets.only(top:100.0,),
//     child: Text('More >  ',style: TextStyle(
//   fontSize: 22,fontWeight: FontWeight.bold
  
//       ),),
//   ),
// )
    ],)
    ),
  )
,
SizedBox(height: 20,),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
Container(
    height: 150,
    
    width: 
    150,
    //MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
     color: Color.lerp(Colors.blue, Colors.white, 0.3)
    
      ),
    child: Stack(children: [
      Padding(
  padding: const EdgeInsets.only(top:20.0,left: 28),
  child: Text('Probablity of Rain',style: TextStyle(
fontSize: 15,fontWeight: FontWeight.bold

    ),),
),
Padding(
  padding: const EdgeInsets.only(top:70.0,left: 28),
  child: Text('${((Get.arguments['data'].pop ?? 0) * 100).toStringAsFixed(2).toString()} %',style: TextStyle(
fontSize: 22,fontWeight: FontWeight.bold

    ),),
),

Padding(
  padding: const EdgeInsets.only(top:110.0,left: 50),
  child:
  Icon(Icons.water_drop,size: 30,)
)
 
 
    ],),
    ),Container(
    height: 150,
    
    width: 
    150,
    //MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
   color: Color.lerp(Colors.blue, Colors.white, 0.3)
    
      ),
    child: Stack(children: [
 Padding(
  padding: const EdgeInsets.only(top:25.0,left: 28),
  child: Text('  Humidity',style: TextStyle(
fontSize: 15,fontWeight: FontWeight.bold

    ),),
),
Padding(
  padding: const EdgeInsets.only(top:70.0,left: 28),
  child: Text('    ${Get.arguments['data'].humidity.toString()} %',style: TextStyle(
fontSize: 22,fontWeight: FontWeight.bold

    ),),
),
      Padding(
  padding: const EdgeInsets.only(top:110.0,left: 55),
  child:Icon(Icons.thermostat,size: 30,)
)
 
    ],),
    ),


    ],),
    ),
      SizedBox(height: 20,),
     Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
   
    child: Container(
    height: 150,
    
    width: 
    200,
    //MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
    color: Color.lerp(Colors.blue, Colors.white, 0.3)
    
      ),
      child: Stack(children: [

 Padding(
  padding: const EdgeInsets.only(top:20.0,left: 28),
  child: Text('High',style: TextStyle(
fontSize: 15,fontWeight: FontWeight.bold

    ),),
),
Padding(
  padding: const EdgeInsets.only(top:70.0,left: 28),
  child: Text('Low',style: TextStyle(
fontSize: 15,fontWeight: FontWeight.bold

    ),),
),


 Padding(
  padding: const EdgeInsets.only(top:16.0,left: 80),
  child: Text('${Get.arguments['data'].temp.max.toString()}',style: TextStyle(
fontSize: 20,fontWeight: FontWeight.bold

    ),),
),
Padding(
  padding: const EdgeInsets.only(top:68.0,left: 80),
  child: Text('${Get.arguments['data'].temp.max.toString()}°K',style: TextStyle(
fontSize: 20,fontWeight: FontWeight.bold

    ),),
),



////
 Padding(
  padding:  EdgeInsets.only(top:25.0,left: 
  
  MediaQuery.of(context).size.width/1.8
  //190
  
  ),
  child: Text('Feels like',style: TextStyle(
fontSize: 15,fontWeight: FontWeight.bold

    ),),
),
Padding(
  padding:  EdgeInsets.only(top:50.0,left:
  MediaQuery.of(context).size.width/1.82
   //190
  ),
  child: Text('${Get.arguments['data'].feelsLike.day.toString()}°F',style: TextStyle(
fontSize: 22,fontWeight: FontWeight.bold

    ),),
),
// Padding(
//   padding:  EdgeInsets.only(top:30.0,left:
//   MediaQuery.of(context).size.width>=800? MediaQuery.of(context).size.width/1.7:
//   MediaQuery.of(context).size.width/1.4
//   // 280
  
//   ),
//   child: Icon(Icons.thermostat,size: 50,)
// ),


      ],),
    
    ),
  ),
  SizedBox(height: 20,),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
Container(
    height: 150,
    
    width: 
    150,
    //MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
 color: Color.lerp(Colors.blue, Colors.white, 0.3)
    
      ),
    child: Stack(children: [
Padding(
  padding: const EdgeInsets.only(top:40.0,left: 30),
  child: Text('Rainfall',style: TextStyle(
fontSize: 22,fontWeight: FontWeight.bold

    ),),
),


Padding(
  padding: const EdgeInsets.only(top:65.0,left: 30),
  child:Get.arguments['data'].rain==null?Text('No data',style: TextStyle(
fontSize: 22,fontWeight: FontWeight.bold

    )): Text('${Get.arguments['data'].rain.toString()} mm',style: TextStyle(
fontSize: 22,fontWeight: FontWeight.bold

    ),),
),

Padding(
  padding: const EdgeInsets.only(top:100.0,left: 60),
  child: Icon(Icons.water_drop),
)

    ],),
    ),Container(
    height: 150,
    
    width: 
    150,
    //MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
    color: Color.lerp(Colors.blue, Colors.white, 0.3)
    
      ),
    child: Stack(children: [

      Padding(
  padding: const EdgeInsets.only(top:5.0,left: 60),
  child: SvgPicture.asset('asset/north_icon.svg',height: 20,),
  ),
 

Padding(
  padding: const EdgeInsets.only(top:30.0,left: 30),
  child: Container(
    height: 90,width: 90,
decoration: BoxDecoration(
    color: Colors.white,
borderRadius: BorderRadius.circular(55)

),

child: Center(child: CircleAvatar(
radius: 30,
backgroundColor: Color.lerp(Colors.blue, Colors.white, 0.3),

child: Column(
  children: [
    SizedBox(height: 4,),
    Text('${Get.arguments['data'].speed.toString()} '),
    Text('m/s'),
  ],
),
),),
  )

),

Padding(
  padding: const EdgeInsets.only(top:125.0,left: 60),
  
  
  child: Text('Wind'),
  )

    ],),



    ),


    ],),
    ),
    SizedBox(height: 20,)
],),

    );
  }
}