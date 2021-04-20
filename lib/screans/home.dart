import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_test_app/DB/dbhelper.dart';
import 'package:flutter_test_app/constants/constants.dart';
import 'package:flutter_test_app/custum_widget/custum_widget.dart';
import 'package:flutter_test_app/screans/allproducts.dart';
import 'package:flutter_test_app/screans/cart.dart';
import 'package:flutter_test_app/screans/drawer.dart';
import 'package:toast/toast.dart';

class HomeScrean extends StatefulWidget {
  @override
  _HomeScreanState createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  @override
  void initState() {
    super.initState();
  }

  var cartlength = 0;

  getCartlength() {
    DBHelper db = new DBHelper();
    return db.allproducts().then((value) {
      cartlength = value.length;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    getCartlength();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          Badge(
              badgeContent: Text(cartlength.toString()),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => CartScrean()));
                },
              )),
          SizedBox(
            width: 30,
          )
        ],
      ),
      drawer: MainDrawer(),
      body: homeBody(),
    );
  }

  Widget homeBody() {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 120,
              child: buildRaisedButton(
                  text: "Products",
                  pressed: () {
                    if (getToken() != null) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AllProducts()));
                    } else {
                      Toast.show('you must login first!!', context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    }
                  })),
          SizedBox(
            height: 100,
          ),
          Container(
              height: 120,
              child: buildRaisedButton(
                  text: "Cart",
                  pressed: () async {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => CartScrean()));
                  })),
        ],
      ),
    );
  }
}
