import 'package:flutter/material.dart';
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/productrs_provider.dart';
import 'package:moto_365/providers/services_provider.dart';
import 'package:moto_365/screens/home/group_services.dart';
import 'package:moto_365/screens/search/products_expanded.dart';
import 'package:moto_365/screens/search/services_expanded.dart';
import 'package:provider/provider.dart';

class SearchList extends StatefulWidget {
  final bool mode;
  final String cat;
  final String x;

  SearchList(this.cat, this.mode, this.x);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List mix = [];
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      // Provider.of<Products>(context).fetchProductsSearch(widget.x);
      // Provider.of<Services>(context).fetchServicesSearch(widget.x);
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final services = Provider.of<Services>(context);
    if (widget.mode) {
      mix = products.itemSearch + services.itemSearch;
    } else {
      mix = products.items + services.items;
    }

    List list = [];
    List _getList(cat) {
      if (cat == 'Accessories') {
        list = products.items;
      } else {
        list = services.items;
      }
      return list;
    }

    final List item = _getList(widget.cat);
    bool _isService(Map value) {
      if (value.containsKey('image')) {
        return false;
      } else {
        return true;
      }
    }

    return Scaffold(
      body: list == null || list == []
          ? Center(child: Text('no item'))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: widget.cat != 'Accessories'
                  ? services.serviceGroup.length
                  : products.items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.cat != 'Accessories'
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GroupServices(
                                  id: services.serviceGroup[index]['id'],
                                )))
                        : Navigator.of(context).pushNamed(
                            ProductsExpanded.routeName,
                            arguments: products.items[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 8, right: 8),
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 1.5),
                            blurRadius: 1.5,
                          )
                        ],
                        borderRadius: BorderRadius.circular(8)),
                    child: widget.cat != 'Accessories'
                        ? Column(
                            children: <Widget>[
                              Expanded(
                                //flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        8), //BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                                    child: Image(
                                        image: services.serviceGroup[index]
                                                    ['image'] ==
                                                ""
                                            ? AssetImage(
                                                'assets/images/slice.png')
                                            : NetworkImage(
                                                "${Url.main}${services.serviceGroup[index]['image']}"),
                                        fit: BoxFit.cover,
                                        height: 125,
                                        width: 120),
                                  ),
                                ),
                              ),
                              //Expanded(child: Text(item[index]['name'])),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        8), //BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                                    child: Image(
                                      image: products.items[index]['image'] ==
                                              ""
                                          ? AssetImage(
                                              'assets/images/slice.png')
                                          : NetworkImage(
                                              "${Url.main}${products.items[index]['image']}"),
                                      fit: BoxFit.cover,
                                      height: 125,
                                      width: 120,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text(item[index]['name'] ?? "")),
                            ],
                          ),
                  ),
                );
              }),
    );
  }
}
