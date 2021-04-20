import 'package:flutter/material.dart';
import 'package:flutter_test_app/DB/dbhelper.dart';
import 'package:flutter_test_app/constants/constants.dart';
import 'package:flutter_test_app/custum_widget/custum_widget.dart';
import 'package:flutter_test_app/screans/allproducts.dart';
import 'package:toast/toast.dart';

class CartScrean extends StatefulWidget {
  @override
  _CartScreanState createState() => _CartScreanState();
}

class _CartScreanState extends State<CartScrean> {
  var cartList = [];
  var amount = 1;

  @override
  void initState() {
    super.initState();
    DBHelper db = new DBHelper();
    db.allproducts().then((value) {
      cartList = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    DBHelper db = new DBHelper();
    db.allproducts().then((value) {
      cartList = value;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),
      body: cartList.length > 0
          ? cartBody()
          : Center(
              child: Text("Cart is Empty!!"),
            ),
    );
  }

  cartitem(product) {
    amount= product['amount'];
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(product['photo']),
            ),
            title: Row(
              children: [
                Text(product['product_name']),
                SizedBox(
                  width: 20,
                ),
                Text('\$ ' + product['price'].toString()),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                deleteproduct(product['id']);
                setState(() {});
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline_outlined),
                onPressed: () {
                  amount++;
                  updateamount(amount, product, product['id']);
                  setState(() {});
                },
              ),
              SizedBox(
                width: 10,
              ),
              Text(product['amount'].toString()),
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(Icons.remove_circle_outline_rounded),
                onPressed: () {
                  if (amount > 1) {
                    amount--;
                    updateamount(amount, product, product['id']);
                    setState(() {});
                  }
                },
              ),
              Spacer(),
              Text((product['amount'] * product['price']).toString()),
              SizedBox(
                width: 100,
              ),
            ],
          )
        ],
      ),
    );
  }

  cartBody() {
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (c, i) => cartitem(cartList[i])),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    "Total  \$ " + calctotal().toString(),
                    style: TextStyle(fontSize: 28),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: buildRaisedButton(
                        text: "Empty Cart", pressed: () => deleteallproduct()),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: buildRaisedButton(
                        text: "Continue Shopping",
                        pressed: () {
                          if (getToken()() != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => AllProducts()));
                          } else {
                            Toast.show('you must login first!!', context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          }
                        }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: buildRaisedButton(text: "CheckOut", pressed: () {}),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  updateamount(amount, product, id) {
    DBHelper db = DBHelper();
    final productMap = {
      "id":product['id'],
      "product_name": product['product_name'],
      "price": product['price'],
      "photo": product['photo'],
      "amount": amount
    };
    db.updateproduct(productMap, id);
  }

  deleteproduct(id) {
    DBHelper db = DBHelper();
    db.deleteproduct(id);
  }

  deleteallproduct() {
    DBHelper db = DBHelper();
    db.deleteAllproduct();
    setState(() {});
  }

  calctotal() {
    num sum = 0;
    cartList.forEach((element) {
      sum += (element['amount'] * element['price']);
    });
    return sum;
  }
}
