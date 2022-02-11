import 'package:flutter/material.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/providers/productrs_provider.dart';
import 'package:moto_365/providers/services_provider.dart';
import 'package:moto_365/screens/home/drawer.dart';
import 'package:moto_365/screens/search/forum_search.dart';
import 'package:moto_365/screens/search/search_list.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      // Provider.of<Products>(context).fetchProductsSearch(query);
      // Provider.of<Services>(context).fetchServicesSearch(query);
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final services = Provider.of<Services>(context);
    return DefaultTabController(
      length: 3,
      child: Background(
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                'SEARCH',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontFamily: 'Montserrat'),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: DataSearch(),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                      width: 70,
                      child: Image(image: AssetImage('assets/images/slice.png'))),
                )
              ],
              bottom: TabBar(tabs: <Widget>[
                Tab(
                  text: 'Forum',
                ),
                Tab(
                  text: 'Accessories',
                ),
                Tab(
                  text: 'Services',
                ),
              ])),
         // drawer: DrawerWidget(),
          body: TabBarView(
            children: <Widget>[
              ForumSearch(false, ''),
              SearchList('Accessories', false, ''),
              SearchList('Services', false, '')
            ],
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {

  bool mode;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
    //throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Background(
          child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
              title: TabBar(tabs: <Widget>[
                Tab(
                  text: 'Forum',
                ),
                Tab(
                  text: 'Accessories',
                ),
                Tab(
                  text: 'Services',
                ),
              ])
              
          ),
         
          body: TabBarView(
            children: <Widget>[
              ForumSearch(query.isEmpty?false: true, query.isEmpty?'':query),
              SearchList('Accessories', query.isEmpty?false: true, query.isEmpty?'':query),
              SearchList('Services', query.isEmpty?false: true, query.isEmpty?'':query)
            ],
          ),
        ),
      ),
    );
    //throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    return Background(
          child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
              title: TabBar(tabs: <Widget>[
                Tab(
                  text: 'Forum',
                ),
                Tab(
                  text: 'Accessories',
                ),
                Tab(
                  text: 'Services',
                ),
              ])
              
          ),
         
          body: TabBarView(
            children: <Widget>[
              ForumSearch(query.isEmpty?false: true, query.isEmpty?'':query),
              SearchList('Accessories', query.isEmpty?false: true, query.isEmpty?'':query),
              SearchList('Services', query.isEmpty?false: true, query.isEmpty?'':query)
            ],
          ),
        ),
      ),
    );
    //throw UnimplementedError();
  }
}
//query.isEmpty?false: true, query.isEmpty?'':query