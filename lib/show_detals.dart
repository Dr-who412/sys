import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'myprovider.dart';
import 'package:provider/provider.dart';

import 'addCar.dart';

class ShowDetals extends StatefulWidget {
  var lp = [];
  var workId;
  ShowDetals(this.lp, this.workId);

  @override
  _ShowDetalsState createState() => _ShowDetalsState(lp, workId);
}

class _ShowDetalsState extends State<ShowDetals> {
  List<Transf> lp;
  var workId;
  _ShowDetalsState(this.lp, this.workId);

  @override
  Widget build(BuildContext context) {
    List<Transf> cars = Provider.of<MyProducts>(
      context,
      listen: true,
    ).carlist;
    cars = lp;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(
              "cars in $workId",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: lp.isEmpty
              ? Center(
                  child: Text("No cars in work Id:$workId",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black12,
                      )))
              : GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    maxCrossAxisExtent: 500,
                    childAspectRatio: 2,

                  ),
                  children: lp
                      .map(
                        (item) => Container(

                          width: 320,
                          height: 340,
                          child: Card(color:Colors.deepOrangeAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 6,
                            margin: EdgeInsets.all(10),
                            child: Container(
                              width: 340,
                              height: 320,
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(2),
                                    padding: EdgeInsets.only(
                                        left: 2, bottom: 2, top: 2, right: 2),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      child: buildPositioned(
                                        workId,
                                        item.idCar,
                                        item.date,
                                        item.title,
                                        item.money,
                                        item.note,
                                        item.amountOfCar,
                                      ),
                                      onDoubleTap: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),

          floatingActionButton: Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(4),
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.indigoAccent,
              ),
              child: Row(

                  children: <Widget>[

                FlatButton.icon(
                  splashColor: Colors.orangeAccent,
                  label: Text("Add car",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => AddCar(lp, workId)),
                  ),
                )
              ])), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  Widget buildPositioned(
    workId,
    idCar,
    date,
    title,
    money,
    note,
    double amountofCat,
  ) {
    return Positioned(
      bottom: 4,
      right: 4,
      height: 470,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.indigo,
        ),
        width: 340,
        margin: EdgeInsets.only(left: 1, top: 1, right: 1, bottom: 1),
        padding: EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  texts("work date :$date"),
                  Divider(
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(

                          margin: EdgeInsets.all(1),
                          child: texts("order Id:$workId\n \n Car Id: $idCar\n ")),
                      Container(
                        margin: EdgeInsets.all(1),
                        child:
                      texts(
                          "amount to car :$amountofCat ten \n\n money:$money EGP"),),

                    ],

                  ),
                  Container( decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                    height: 40,
                    width: 100,
                    child: FlatButton(
                        onPressed: () {
                          var about = AlertDialog(
                            title: Text("info"),
                            content: Container(
                                color: Colors.deepOrangeAccent,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                  text_about("order Id:$workId\n \n Car Id: $idCar\n "), Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  text_about(
                                      "amount to car :$amountofCat ten \n\n money:$money EGP"),
                                  Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  text_about("title (driver ,from , to  ): $title"),
                                  Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  text_about("Notes:$note ..."),
                                  Divider(height: 4,color: Colors.deepOrange,),
                                  InkWell(child: Text("Back",style: TextStyle(color:Colors.indigo),
                                  ),
                                    onTap: ()=>Navigator.of(context).pop(),
                                  )
                                ])),
                          );
                          showDialog(
                            context: context,
                            builder: (context) => about,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.0),
                            color: Colors.deepOrange, ),
                          width: 80,
                          child: Row(

                            children: [ Icon(
                              Icons.add_chart,
                              color: Colors.white,
                            ),
                              Text("About",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold)),

                            ],
                          ),
                        )),
                  ),
                ],

              ),
            ),

          ],
        ),
      ),
    );
  }

  Container texts(title) {
    return Container(
      padding: EdgeInsets.all(1),
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.black38,
      ),
      child: text_card("$title"),
    );
  }

  Text text_card(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      softWrap: true,
      overflow: TextOverflow.fade,
      maxLines: 4,
    );
  }
  Text text_about(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      softWrap: true,
      overflow: TextOverflow.fade,
      maxLines: 4,
    );
  }
}
