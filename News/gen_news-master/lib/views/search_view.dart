
import 'package:flutter/material.dart';
import 'package:gennews/helper/search_keyword.dart';
import 'package:gennews/views/search_result.dart';
import 'package:page_transition/page_transition.dart';

//Search class for get the search key inputs

class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final _formKey = GlobalKey<FormState>();
  String keyword ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Ada",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              "Derana",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 20,)


          ],
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

             //SizedBox(height: 60,),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black,
                      fontFamily: 'Montserrat',
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please Enter Search Key';
                      }
                      else {
                        setState(() {
                          keyword = text;
                        });
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Search Key Here',
                      hintStyle: TextStyle(
                          color: Colors.grey
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),),
              //SizedBox(height: 20,),
              FlatButton.icon(
                    onPressed: (){
                      if (_formKey.currentState.validate()) {
                        keyData.text = keyword;
                        print(keyData.text);
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: SearchResults())
                        );
                      }
                    },

                    label: Text("Search",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat'
                    ),),
                icon: Icon(Icons.search,color: Colors.red,),


                ),

            ],
          ),
        ),
      ),
    );
  }
}
