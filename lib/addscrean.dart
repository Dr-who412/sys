
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'main.dart';
import 'myprovider.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var titleController = TextEditingController()..text = "";
  var descController = TextEditingController()..text = "";
  var priceController = TextEditingController()..text = "";
  var workIdController = TextEditingController()..text = "";
  bool _isloading=false;
  @override
  Widget build(BuildContext context) {
    File _image = Provider.of<MyProducts>(
      context,
      listen: true,
    ).image;
    return _isloading?Center(child: CircularProgressIndicator(),) : MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add New work space'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              TextField(
                maxLines: 1,
                decoration:
                    InputDecoration(labelText: "custom", hintText: "add custem name"),
                controller: titleController,
              ), TextField(
                maxLines: 1,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "work Id", hintText: "id of work"),
                controller: workIdController,
              ), TextField

                (
                maxLines:1 ,
                keyboardType: TextInputType.number,
                decoration:
                InputDecoration(labelText: "amount", hintText: "add amount\"number\""),
                controller: priceController,
              ),
              TextField(
                maxLength: 80,
                maxLines: 2,
                decoration: InputDecoration(
                    labelText: "description", hintText: "add description:period,kind,from & to ? where"),
                controller: descController,
              ),

              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.orangeAccent,
                  child: Text("Choose Image"),
                  onPressed: () {
                    var ad = AlertDialog(
                      title: Text("Choose picture from:"),
                      content: Container(
                        height: 150,
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.black,
                            ),
                            Builder(
                              builder: (innerContext) => Container(
                                color: Colors.orangeAccent,
                                child: ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text("Gallery"),
                                  onTap: () {
                                    context
                                        .read<MyProducts>()
                                        .getImage(ImageSource.gallery);
                                    Navigator.of(innerContext).pop();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Builder(
                              builder: (innerContext) => Container(
                                color: Colors.orangeAccent,
                                child: ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text("camera"),
                                  onTap: () {
                                    context
                                        .read<MyProducts>()
                                        .getImage(ImageSource.camera);
                                    Navigator.of(innerContext).pop();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    showDialog(
                      context: context,
                      builder: (context) => ad,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Consumer<MyProducts>(
                  builder: (ctx, value, child) => RaisedButton(
                        color: Colors.deepOrangeAccent,
                        textColor: Colors.white,
                        child: Text("Add new work space"),
                        onPressed: () async{
                          if (titleController.text == "" ||
                              descController.text == "" ||
                              priceController.text == ""
                          || workIdController.text == "") {
                            Toast.show("please enter all Fields", ctx,
                                duration: Toast.LENGTH_LONG);
                          } else if (_image == null) {
                            Toast.show("please enter a image", ctx,
                                duration: Toast.LENGTH_LONG);
                          }else{
                            try{
                              setState(() {
                                _isloading=true;
                              });
                              value.add( title: titleController.text.toString(),
                                id:num.parse(workIdController.text.toString(),),
                                descrip: descController.text.toString(),
                                price:double.parse(priceController.text.toString()),).then((_) async {
                                  setState(() {
                                    _isloading=false;
                                  });
                              await Navigator.pop((ctx), MaterialPageRoute(builder:(ctx)=>MyHomePage(),),);
                                    });
                            }catch(e){
                              Toast.show("please enter a valid amount ",ctx,duration: Toast.LENGTH_LONG);
                              print(e);

                            }
                          }
                        },
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
