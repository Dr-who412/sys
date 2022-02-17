import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Product {
  final num id;
  final String title;
  final String descrip;
  final double price;
final List <Transf>lcar=[];
  File image;
  Product(
      {@required this.id,
      @required this.title,
      @required this.descrip,
      @required this.price,
      @required this.image,

      });
}
class Transf{
  final String idCar;
  final String date;
  final String title;
  final int money;
  final String note;
  final double amountOfCar;

  Transf(
      {
        @required this.idCar,
        @required this.date,
        @required this.title,
        @required this.money,
        @required this.note,
        @required this.amountOfCar,
      });
}
class MyProducts with ChangeNotifier {
  List<Product>productList=[];
  List<Transf>carlist=[];
  File image;

  @override
  Future<void> add({num id,String title="",String descrip="",double price=0.0,List<Transf>carlist,}) {
   final String url="https://fayed-comp-default-rtdb.europe-west1.firebasedatabase.app/workSpace${id}N.json";
   DatabaseReference _ref=FirebaseDatabase.instance.reference().child("product:${productList.length}");
http.post(url,body:json.encode({
  "id":id,"custam":title,"description":descrip,"amount":price,"trans":carlist
})).then((res){
  print(json.decode(res.body));
});

    productList.add(Product(id:id, title: title, descrip: descrip, price: price,image:image));
    notifyListeners();
  }
  Future<void> AddCar({String idCar,String date,String title,int money,String note,double amountOfCars,}){
    carlist.add(Transf(idCar: idCar, date: date, title: title, money: money, note: note, amountOfCar:amountOfCars,));
  }
  Future getImage(ImageSource src)async{
    final pickFiled=await ImagePicker().getImage(source: src);
    if (pickFiled!=null){
      image=File(pickFiled.path);
      notifyListeners();
      print('image selected');
    }else{
      print('no image selected');
    }
    }

  }




