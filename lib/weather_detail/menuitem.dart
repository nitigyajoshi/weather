import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MenuItem extends StatefulWidget {
  const MenuItem({super.key});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff416ea9),
      body: Container(height: (MediaQuery.of(context).size.height)-10,
        child: ListView(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Text(
                    'Json-nappi Weather',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'asset/logo-icon.png',
                    height: 60,
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            // Expansion Tile for About Us
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ExpansionTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text(
                  'About Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white.withOpacity(0.1),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Text(
                      'We at Json-nappi Weather provide real-time, accurate weather forecasts based on your location. Our mission is to make weather data accessible and accurate for everyone.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // Expansion Tile for Contact Us
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ExpansionTile(
                leading: Icon(Icons.contact_mail, color: Colors.white),
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white.withOpacity(0.1),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Text(
                      'For any inquiries or feedback, feel free to reach out to us at: jasonnappi319@gmail.com',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
        
        
              SizedBox(height: 20),
            // Expansion Tile for Contact Us
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ExpansionTile(
                leading: Icon(Icons.contact_mail, color: Colors.white),
                title: Text(
                  'Privacy Policy ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white.withOpacity(0.1),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Text(
                      '1.Information we collect \nWe collect location data to predict the weather information\n2 How we use the information?\n We will use the location data to get  accurate  weather information of your current location\n3. Data sharing \n We do not share,sell or rent your data ,your data is only used to provide core funtionality of the app\n4. Third Party Service \n App uses third party service like open weather api to provide weather data , google map and open weather weather map data to show weather map & we are fetching videos and photos related to weather information from firebase ',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}