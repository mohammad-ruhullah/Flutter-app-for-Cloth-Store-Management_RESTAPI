import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_practice/Screen/create_item.dart';
import 'package:rest_api_practice/Screen/updateProduct.dart';
import '../RestApi/RestClient.dart';
import '../Style/style.dart';

class ShowItem extends StatefulWidget {
  const ShowItem({super.key});

  @override
  State<ShowItem> createState() => _ShowItemState();
}

class _ShowItemState extends State<ShowItem> {
  List product_data = [];
  bool Loading = false;

  @override
  void initState() {
    Calldata();
    super.initState();
  }

  Calldata() async {
    setState(() {
      Loading = true;
    });
    Map allproducts = await AllProductGet().timeout(
      Duration(seconds: 5),
      onTimeout: () {
        setState(() {
          Loading = false;
        });
        ErrorInput("Data Fetch Failed!");
        return {};
      },
    );
    setState(() {
      Loading = false;
    });
    setState(() {
      product_data = allproducts["All Products"];
    });
  }

  GotoUpdate(context, product_data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProduct(product_data),
      ),
    );
  }

  ConfirmDelete(index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete!!"),
            content: Text("Do you really want to delete the product details?"),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    Loading = true;
                  });
                  bool res = await ProductDelete(index);
                  setState(() {
                    Loading = false;
                  });
                  if (res == true) {
                    Successful("Product Deleted");
                  } else {
                    ErrorInput("Try Again!!");
                  }
                  Calldata();
                  Navigator.pop(context);
                },
                child: Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest API"),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateItem(),
            ),
          );
        },
        style: buttonStyleCustomElevated(),
        child: const Icon(Icons.add),
      ),
      body: Stack(
        // here Stack is used because of using background image.
        children: [
          ScreenBackground(context),
          Loading
              ? (const Center(
                  child: CircularProgressIndicator(),
                ))
              : (RefreshIndicator(
                  onRefresh: () async {
                    await Calldata();
                  },
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: product_data.length,
                    gridDelegate: GridStyle(),
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                child: Image.asset(
                              'assets/images/tshirt.jpg',
                              fit: BoxFit.fill,
                            )),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "${product_data[index]["Name"]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Price: ${product_data[index]["ProductPrice"]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              // height: ,
                              // width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      GotoUpdate(context, product_data[index]);
                                    },
                                    icon: Icon(CupertinoIcons
                                        .arrow_right_arrow_left_square),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      ConfirmDelete(product_data[index]["id"]);
                                    },
                                    icon: const Icon(CupertinoIcons.delete),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )),
        ],
      ),
    );
  }
}
