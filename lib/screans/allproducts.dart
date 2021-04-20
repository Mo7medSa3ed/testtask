import 'package:flutter/material.dart';
import 'package:flutter_test_app/DB/dbhelper.dart';
import 'package:flutter_test_app/api/API.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  static const int PAGE_SIZE = 4;
  var controller = TextEditingController();
  var keySearch;
  var listdata = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DBHelper db = new DBHelper();
    db.allproducts().then((value) => listdata = value);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: Column(
        children: [
          searchwidget(),
          SizedBox(
            height: 10,
          ),
          FutureBuilder<List<dynamic>>(
              future: API.getAllProducts(
                  page: 1, norecord: PAGE_SIZE, key_search: keySearch),
              builder: (ctx, snapshot) {
                if (keySearch != null && !snapshot.hasData) {
                  return Center(
                    child: Text('No data Found'),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final data = snapshot.data;
                  return Expanded(
                    child: PagewiseGridView<dynamic>.count(
                        pageSize: PAGE_SIZE,
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 0.8,
                        padding: EdgeInsets.all(15.0),
                        itemBuilder: (c, d, i) {
                          return productItem(d);
                        },
                        pageFuture: (pageIndex) {
                          return API.getAllProducts(
                              page: pageIndex + 1,
                              norecord: PAGE_SIZE,
                              key_search: keySearch);
                        }),
                  );
                }
              }),
        ],
      ),
    );
  }

  Widget searchwidget() {
    return Container(
      color: Colors.grey[300],
      child: TextField(
        maxLines: 1,
        controller: controller,
        onChanged: (String v) {
          if (v.isNotEmpty && v.length > 1) {
            keySearch = v.toLowerCase().trim();
          } else {
            keySearch = null;
          }
          setState(() {});
        },
        decoration: InputDecoration(
            hintText: 'Search here.....',
            suffixIcon: controller.text.toString().isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: () {
                          controller.clear();
                          keySearch = null;
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.close,
                        )),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: Icon(Icons.search),
                  ),
            contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            border: InputBorder.none),
      ),
    );
  }

  productItem(product) {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 200,
              child: Image.network(
                product['photo'],
                fit: BoxFit.cover,
              ),
            ),
            Text(product['product_name']),
            Text(
              '\$\t' + product['price'],
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            Container(
                width: double.infinity,
                child: RaisedButton(
                    color: Colors.blue,
                    onPressed: check(product['product_name'])
                        ? null
                        : () {
                            DBHelper db = new DBHelper();
                            final productMap = {
                              "product_name": product['product_name'],
                              "price": product['price'],
                              "photo": product['photo'],
                              "amount":1
                            };
                            db.createproduct(productMap).then((value) {
                              print(value);
                              listdata.add(productMap);
                            });
                            setState(() {});
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        check(product['product_name'])
                            ? "Added before !!"
                            : "Add To Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  bool check(name) {
    var value = null;
    value = listdata.firstWhere((e) => e['product_name'] == name,
        orElse: () => null);
    return value != null ? true : false;
  }
}
