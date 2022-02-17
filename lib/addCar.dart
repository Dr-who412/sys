import 'package:fayed/show_detals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'myprovider.dart';
class AddCar extends StatefulWidget {
   List<Transf>lp;
  var workId;
  AddCar(this.lp,this. workId);

  @override
  _AddCarState createState() => _AddCarState(lp,workId);
}

class _AddCarState extends State<AddCar> {
  String idcar;
  String note;
  String title;
  num money;
  double amount;
  List <Transf>lp;
  var workId;
  _AddCarState(this.lp,this.workId);
  var titleController = TextEditingController()..text = "";
  var noteController = TextEditingController()..text = "";
  var amountController = TextEditingController()..text = "";
  var idcarController = TextEditingController()..text = "";
  var workIdController = TextEditingController()..text = "";
  var moneyController = TextEditingController()..text = "";
  var dateController = TextEditingController()..text = "";
  String datenow="";


  @override
  Widget build(BuildContext context) {
    List<Transf>cars=Provider.of<MyProducts>(context,listen: true,).carlist;
    cars=lp;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('add cars'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(4),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
               TextField(
                 maxLength: 2,
                      maxLines: 1,

                      keyboardType: TextInputType.datetime,
                    decoration:
                    InputDecoration(labelText: "date of day", hintText: "enter a  day ",),
                    controller: dateController,
                  ),


              TextField(
                maxLines: 1,
                  maxLength: 7,
                  decoration:
                  InputDecoration(labelText: "car's Id", hintText: "enter a car number "),
                  controller: idcarController,
                ),


                TextField(
                  maxLength: 80,
                  maxLines: 4,

                  decoration: InputDecoration(
                      labelText: "title (driver name , from , to )", hintText: "اسم السائق و مكان التفريغ"),
                  controller: titleController,
                ),



                 TextField(
                   maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration:

                  InputDecoration(
                      labelText: "car's amount", hintText: "add amount\"number ten  الكمية يالطن\""),
                  controller: amountController,
                ),

              SizedBox(
                height: 1,
              ), TextField(
                maxLines: 1,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration:

                  InputDecoration(labelText: "money", hintText: "add a amount of money  \\ العهده "),
                  controller: moneyController,
                ),

              TextField(
                maxLines: 6,
                  maxLength: 280,
                  decoration: InputDecoration(
                      labelText: "note ", hintText: "notes"),
                  controller: noteController,
                ),

              Divider(
                height: 12,
              ),

              RaisedButton(
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    child: Text("Add a car"),
                    onPressed: () async{
                      if (titleController.text == "" ||
                          amountController.text == "" ||
                          moneyController.text == ""||
                          idcarController.text == "" ||
                          dateController.text == ""||
                      noteController.text==""
                      ) {
                        Toast.show("please enter all Fields", context,
                            duration: Toast.LENGTH_LONG);

                      }else{
                        try{
                           idcar=(idcarController.text.toString());
                         note= noteController.text.toString();
                       datenow="${dateController.text.toString()} - ${DateTime.now().month} - ${DateTime.now().year}";
                       title=titleController.text.toString();
                         money= num.parse(moneyController.text.toString(),);
                          amount=double.parse(amountController.text.toString());
                          cars.add(Transf( idCar: idcar, date: datenow, title: title, money: money, note: note, amountOfCar: amount)
                           );
                          await Navigator.pop(context, MaterialPageRoute(builder:(context)=>ShowDetals(cars,workId),),);

                        }catch(e){
                          Toast.show("please enter a valid amount ",context,duration: Toast.LENGTH_LONG);
                          print(e);

                        }
                      }
                    },
                  ),
            ],
          ),
        ),
      ),
    );}
}
