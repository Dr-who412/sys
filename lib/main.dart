import 'dart:io';
import 'package:fayed/show_detals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addscrean.dart';
import 'myprovider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseReference _ref=FirebaseDatabase.instance.reference().child("product");
  runApp(
ChangeNotifierProvider(
  create:(_)=>MyProducts(),
      child:MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),

      home: MyHomePage(title: 'Fayed company '),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void show(context,item){
    Navigator.of(context).pushNamed(
      '/showdetals',
      arguments:{
        'workId':item.id,
      },

    );}
  @override
  Widget build(BuildContext context) {
    List<Product>pro=Provider.of<MyProducts>(context).productList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("work spaces",style: TextStyle(color: Colors.white),),
      ),
      body:pro.isEmpty?Center(child:Text("No work space",style:TextStyle(fontSize: 24,color: Colors.black12,)))
      :GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          maxCrossAxisExtent: 500,
          childAspectRatio: 2,
        ),
        children:pro
            .map(
              (item) => Card(
                color: Colors.indigo,
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
          elevation: 6,
          margin: EdgeInsets.all(4),
          child: Stack(

            children: [
                Container(
                  color: Colors.deepOrangeAccent,
                  padding: EdgeInsets.all(3),
                  width: 150,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(item.image,fit:BoxFit.cover),
                  ),
                ),


              Container(
                width: 350,
                height: double.infinity,
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.only(left: 50,bottom: 2,top: 2,right: 2),
                child:InkWell(
                  borderRadius: BorderRadius.circular(15),
                child: buildPositioned(

                    item.title,item.descrip,item.price,item.id),

                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowDetals(item.lcar,item.id),));}


              ),
              ),


                      ],
          ),
        ),
        ).toList(),

        ),
      floatingActionButton: Container(
          width:95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.deepOrange,
      ),
      child:Row(
         children:<Widget>[
          FlatButton.icon(
            label: Text("Add",style:TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)),
            icon: Icon(Icons.add,color: Colors.white,),
            onPressed: ()=>Navigator.push(
              context,MaterialPageRoute(builder: (ctx)=> AddProduct())
            ),


          )
        ]

      )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

 Widget buildPositioned( title,  desct, double price,workID) {
    var dsc=desct.length>=50? desct.replaceRange(30, desct.length, '....'):
        desct;
    return Positioned(bottom: 5,
    right: 12,
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.deepOrangeAccent,
        ),
        width: 180,
        margin: EdgeInsets.only(left:100.0,top: 2,),
        padding: EdgeInsets.all(2),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(  padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.black38
                ,
              ),
              child: text_card("work ID: $workID"),
            ),
            Container(  padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.black38
                ,
              ),
              child: text_card("custam: $title"),
            ),
            SizedBox(height: 1,),
            Container(
              width: 320,
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.black38,
              ),
              child:text_card( "$dsc",)
            ),
            Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.black54,
              ),
              child:text_card("amount: $price ten")
            ),
          ],
        ),
      ),
    );
 }

 Text text_card(String text) {
   return Text(
              text,
              style: TextStyle(color: Colors.white,fontSize: 14,),
              softWrap: true,
              overflow: TextOverflow.fade,
            );
 }
}
