
import 'package:flutter/material.dart';
import 'package:gennews/helper/news.dart';
import 'package:gennews/helper/search_keyword.dart';
import 'package:gennews/models/search_model.dart';
import 'package:provider/provider.dart';
import 'article_view.dart';

//search result class for view the search outputs

class SearchResults extends StatefulWidget {
  const SearchResults({Key key}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Future<List> _future;

  @override
  void initState() {
    final searchList = Provider.of<SearchList>(context, listen: false);
    _future = searchList.getSearchList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final searchList = Provider.of<SearchList>(context, listen: false);
    searchList.searchListFinal.clear();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
      appBar: AppBar(
       // backgroundColor: Color(0xff8B0000),
        //foregroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Ada",
              style: TextStyle(
                  color: Colors.black,
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
        //backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                "Search Result For ${keyData.text}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Playfair'),
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder(
                future: _future,
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        final searchList = Provider.of<SearchList>(context, listen: false);
                        searchList.searchListFinal.clear();
                        Future.delayed(Duration(seconds: 2));
                        _future =  searchList.getSearchList();
                        print("Future Reloaded");
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          SearchModel _searchHeadlines = snapshot.data[index];
                          if(_searchHeadlines.urlImage == "null"){
                            return InkWell(
                              child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20)
                                          ),

                                          color: Colors.white,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:  BorderRadius.circular(25.0),
                                            ),
                                            elevation: 0.0,
                                            color: Colors.white,
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Text(
                                                      _searchHeadlines.title,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 28,
                                                          fontFamily: 'Playfair'),
                                                    )),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                                  child: Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: Text(
                                                      "${(_searchHeadlines.sourceName).toString()}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Montserrat'),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                              onTap: () async {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticleView(
                                          blogUrl:  _searchHeadlines.url,
                                        )));
                              },
                            );
                          }
                          else if (_searchHeadlines.urlImage != "null"){
                            return InkWell(
                              child: Container(

                                  //color: Colors.white,
                                  height: MediaQuery.of(context).size.height / 2.2,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:  BorderRadius.circular(25.0),
                                    ),

                                    elevation: 0.0,
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color: Colors.black12

                                      ),
                                      child: Column(

                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(40),
                                                color: Colors.black12

                                              ),
                                              child: Image.network(_searchHeadlines.urlImage,
                                                fit: BoxFit.cover,
                                              ),
                                              width: MediaQuery.of(context).size.width,
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                _searchHeadlines.title,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontFamily: 'Playfair'),
                                              )),
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                "${(_searchHeadlines.sourceName).toString()}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Montserrat'),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticleView(
                                          blogUrl:  _searchHeadlines.url,
                                        )));
                              },
                            );
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Center(
                      child: Text(
                        "Can't Fetch API data\n"
                            "     Try again Later",
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    );
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }),
          ),
        ],
      ),
    );
  }
}
