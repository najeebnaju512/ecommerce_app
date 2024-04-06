import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/textstyles.dart';
import '../../bottom_nav_bar/controller/bottom_nav_controller.dart';
import '../controller/customer_controller.dart';
import 'widget/customer_card.dart';

class CustumerScreen extends StatefulWidget {
  const CustumerScreen({super.key});

  @override
  State<CustumerScreen> createState() => _CustumerScreenState();
}

class _CustumerScreenState extends State<CustumerScreen> {
  TextEditingController nameControl = TextEditingController();
  TextEditingController mobileControl = TextEditingController();
  TextEditingController mailControl = TextEditingController();
  TextEditingController streetControl = TextEditingController();
  TextEditingController street2Control = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController pincodeControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var title = "title example";
    var id = "1234123";
    var address = "adress demo sample";
    var amt = "234";
    var image =
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorTheme.white,
          leading: IconButton(
              onPressed: () {
                Provider.of<BottomNavigationController>(context, listen: false)
                    .currentIndex = 0;
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            "Customers",
            style: GLTextStyles.poppinsStyl(
                size: size.width * .05,
                weight: FontWeight.w700,
                color: ColorTheme.black),
          ),
          centerTitle: true,
          actions: [
            Icon(Icons.menu),
            SizedBox(
              width: size.width * .05,
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(size.width * .1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: size.width * .1,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: ColorTheme.black.withOpacity(.5),
                    width: 1.0,
                  ),
                ),
                child: Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Wrap(
                        spacing: 10,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.search,
                            color: ColorTheme.black.withOpacity(.6),
                          ),
                          Text(
                            "Search",
                            style: GLTextStyles.kanitStyl(
                                color: ColorTheme.black.withOpacity(.6),
                                weight: FontWeight.w200),
                          )
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.qr_code,
                            color: ColorTheme.black.withOpacity(.6),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          VerticalDivider(
                            color: ColorTheme.black,
                            width: 1,
                            thickness: 1,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              //bottomsheet
                              _addCustommer(context, size);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorTheme.mainClr),
                              child: Icon(
                                Icons.add,
                                size: size.width * .08,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return CustumerCard(
                  size: size,
                  image: image,
                  title: title,
                  id: id,
                  address: address,
                  amt: amt);
            }),
      ),
    );
  }

  Future<dynamic> _addCustommer(BuildContext context, Size size) async {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 10, 10, MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add Customer"),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Provider.of<CustomerController>(context, listen: false).selectedCountry=
                                null;
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  Text("Customer Name"),
                  TextFormField(controller: nameControl),
                  TextFormField(
                    controller: mobileControl,
                    decoration: InputDecoration(hintText: "Mobile Number"),
                  ),
                  TextFormField(
                    controller: mailControl,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  Text("Address"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: size.width * .45,
                              child: TextFormField(
                                controller: streetControl,
                                decoration: InputDecoration(hintText: "Street"),
                              )),
                          SizedBox(
                              width: size.width * .45,
                              child: TextFormField(
                                controller: cityControl,
                                decoration: InputDecoration(hintText: "City"),
                              )),
                          SizedBox(
                            width: size.width * .45,
                            child: Consumer<CustomerController>(builder: (context, cControl, child) {
                              return DropdownButton<String>(
                                  isExpanded: true,
                                  items: cControl.dropdownItemsCountry,
                                  value: cControl.selectedCountry,
                                  hint: const Text("Country"),
                                  onChanged: (String? countrySelected) {
                                    cControl.setCountry(countrySelected!);
                                  });
                            }),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: size.width * .45,
                              child: TextFormField(controller: street2Control,decoration: InputDecoration(hintText: "Street two"))),
                          SizedBox(
                              width: size.width * .45,
                              child: TextFormField(controller: pincodeControl,decoration: InputDecoration(hintText: "Pincode"))),
                          SizedBox(
                            width: size.width * .45,
                            child: Consumer<CustomerController>(builder: (context, cControl, child) {
                              return DropdownButton<String>(
                                  isExpanded: true,
                                  items: cControl.dropdownItemsState,
                                  value: cControl.selectedState,
                                  hint: const Text("State"),
                                  onChanged: (String? stateSelected) {
                                    
                                    cControl.setStates(stateSelected);
                                  });
                            }),
                          )
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        log("customer name -> ${nameControl.text}");
                        log("customer mobile -> ${mobileControl.text}");
                        log("customer email -> ${mailControl.text}");
                        log("customer street -> ${streetControl.text}");
                        log("customer street two -> ${street2Control.text}");
                        log("customer city -> ${cityControl.text}");
                        log("customer pincode -> ${pincodeControl.text}");
                        log("country -> ${Provider.of<CustomerController>(context,listen: false).selectedCountry}");
                        log("state selected -> ${Provider.of<CustomerController>(context,listen: false).selectedState}");
                      },
                      child: Text(
                        "Submit",
                        style: GLTextStyles.poppinsStyl(color: ColorTheme.white),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: ColorTheme.mainClr),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
