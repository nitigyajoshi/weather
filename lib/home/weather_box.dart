import 'package:flutter/material.dart';

Widget weatherBox(String title1,String data1,String title2,String data2){
return  Column(children: [SizedBox(height: 5,),
            //    Obx(()=>Text(controller.locationList[0].country)),
          Text('$title1',style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 18
          ),),
          Text('$data1',style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black
          )),
          Divider(),
             Text('$title2',style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 18
          )),
          Text('$data2',style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black
          )),
          SizedBox(height: 5,),
                ],);

}