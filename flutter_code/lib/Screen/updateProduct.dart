import 'package:flutter/material.dart';
import 'package:rest_api_practice/Screen/show_item_list.dart';

import '../RestApi/RestClient.dart';
import '../Style/style.dart';

class UpdateProduct extends StatefulWidget {
  final Map productItem;

  const UpdateProduct(this.productItem);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  Map<String, String> ValuesForm = {
    "Name": "",
    "ProductCode": "",
    "ProductQuantity": "",
    "ProductPrice": "",
    "ProductSize": ""
  };
  bool Loading = false;

  Input_record(key, valuechange) {
    setState(() {
      ValuesForm.update(key, (value) => valuechange);
    });
  }

  @override
  initState() {
    setState(() {
      ValuesForm.update(
          "Name", (value) => (widget.productItem["Name"] ?? "").toString());
      ValuesForm.update("ProductCode",
          (value) => (widget.productItem["ProductCode"] ?? "").toString());
      ValuesForm.update("ProductQuantity",
          (value) => (widget.productItem["ProductQuantity"] ?? "").toString());
      ValuesForm.update("ProductPrice",
          (value) => (widget.productItem["ProductPrice"] ?? "").toString());
      ValuesForm.update("ProductSize",
          (value) => (widget.productItem["ProductSize"] ?? "").toString());
    });
    print(widget.productItem);
    print(ValuesForm);

    super.initState();
  }

  FormOnUpdate(id) async {
    if (ValuesForm["Name"]!.length == 0) {
      ErrorInput("Name is required");
    } else if (ValuesForm["ProductCode"]!.length == 0) {
      ErrorInput("ProductCode is required");
    } else if (ValuesForm["ProductQuantity"]!.length == 0) {
      ErrorInput("ProductQuantity is required");
    } else if (ValuesForm["ProductPrice"]!.length == 0) {
      ErrorInput("ProductPrice is required");
    } else if (ValuesForm["ProductSize"]!.length == 0) {
      ErrorInput("ProductSize is required");
    } else {
      bool ans = await ProductUpdateReq(ValuesForm, id)
          .timeout(Duration(seconds: 5), onTimeout: () {
        return false;
      });
      if (ans) {
        Successful("Data Updated Successfully");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ShowItem()),
          (route) => false,
        );
      } else {
        ErrorInput("Data Update Failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update product"),
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: Loading
                ? (Center(
                    child: CircularProgressIndicator(),
                  ))
                : (SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: ValuesForm["Name"],
                          onChanged: (value) {
                            Input_record("Name", value);
                          },
                          decoration:
                              TextInputCustomeDecoration("Product Name"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: ValuesForm["ProductCode"],
                          onChanged: (value) {
                            Input_record("ProductCode", value);
                          },
                          decoration:
                              TextInputCustomeDecoration("Product Code"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: ValuesForm["ProductQuantity"],
                          onChanged: (value) {
                            Input_record("ProductQuantity", value);
                          },
                          decoration:
                              TextInputCustomeDecoration("Product Quantity"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: ValuesForm["ProductPrice"],
                          onChanged: (value) {
                            Input_record("ProductPrice", value);
                          },
                          decoration:
                              TextInputCustomeDecoration("Product Price"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AppDropdownCustome(
                          DropdownButton(
                            value: ValuesForm["ProductSize"],
                            items: [
                              DropdownMenuItem(
                                child: Text("Select Size"),
                                value: "",
                              ),
                              DropdownMenuItem(
                                child: Text("S"),
                                value: "S",
                              ),
                              DropdownMenuItem(
                                child: Text("M"),
                                value: "M",
                              ),
                              DropdownMenuItem(
                                child: Text("XL"),
                                value: "XL",
                              ),
                              DropdownMenuItem(
                                child: Text("XXL"),
                                value: "XXL",
                              ),
                            ],
                            onChanged: (value) {
                              Input_record("ProductSize", value);
                            },
                            underline: Container(),
                            isExpanded: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              FormOnUpdate(widget.productItem["id"]);
                            },
                            child: SubmitButtonChild("Submit"),
                          ),
                        ),
                      ],
                    ),
                  )),
          )
        ],
      ),
    );
  }
}
