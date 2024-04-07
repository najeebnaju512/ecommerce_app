import 'dart:async';
import 'dart:io';

import 'package:ecommerce_test/presentation/single_customer_screen/view/single_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/textstyles.dart';
import '../../../global_widget/image_icon_button.dart';
import '../../bottom_nav_bar/controller/bottom_nav_controller.dart';
import '../controller/customer_controller.dart';
import 'widget/customer_card.dart';

class CustumerScreen extends StatefulWidget {
  const CustumerScreen({super.key});

  @override
  State<CustumerScreen> createState() => _CustumerScreenState();
}

class _CustumerScreenState extends State<CustumerScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    Provider.of<CustomerController>(context, listen: false)
        .fetchProduct(context);
  }

  File? image;
  TextEditingController nameControl = TextEditingController();
  TextEditingController mobileControl = TextEditingController();
  TextEditingController mailControl = TextEditingController();
  TextEditingController streetControl = TextEditingController();
  TextEditingController street2Control = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController pincodeControl = TextEditingController();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorTheme.white,
            leading: IconButton(
                onPressed: () {
                  Provider.of<BottomNavigationController>(context,
                          listen: false)
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
          body: Consumer<CustomerController>(
            builder: (context, cControl, child) {
              return ListView.builder(
                  itemCount: cControl.customerModel.data?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Timer(Duration(milliseconds: 200), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleCustomerScreen(
                                      id: cControl
                                          .customerModel.data?[index].id)));
                        });
                      },
                      child: CustumerCard(
                          size: size,
                          image: cControl.customerModel.data?[index].profilePic,
                          title: cControl.customerModel.data?[index].name,
                          id: cControl.customerModel.data![index].id.toString(),
                          address:
                              "${cControl.customerModel.data?[index].street} ${cControl.customerModel.data?[index].streetTwo}",
                          state:
                              "${cControl.customerModel.data?[index].city} ${cControl.customerModel.data?[index].state}"),
                    );
                  });
            },
          )),
    );
  }

  Future<dynamic> _addCustommer(BuildContext context, Size size) async {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                10, 10, 10, MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Customer",
                        style: GLTextStyles.poppinsStyl(),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Provider.of<CustomerController>(context,
                                    listen: false)
                                .selectedCountry = null;
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ImageIconButton(
                        width: size.width * .35,
                        height: size.height * .06,
                        onPressed: () => _getImage(ImageSource.camera),
                        icon: Icons.camera_alt_outlined,
                        label: 'Camera',
                      ),
                      ImageIconButton(
                        width: size.width * .35,
                        height: size.height * .06,
                        onPressed: () => _getImage(ImageSource.gallery),
                        icon: Icons.photo,
                        label: 'Gallery',
                      ),
                    ],
                  ),
                  if (image != null)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 200,
                      width: 200,
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Text(
                    "Address",
                    style: GLTextStyles.poppinsStyl(),
                  ),
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
                            child: Consumer<CustomerController>(
                                builder: (context, cControl, child) {
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
                              child: TextFormField(
                                  controller: street2Control,
                                  decoration:
                                      InputDecoration(hintText: "Street two"))),
                          SizedBox(
                              width: size.width * .45,
                              child: TextFormField(
                                  controller: pincodeControl,
                                  decoration:
                                      InputDecoration(hintText: "Pincode"))),
                          SizedBox(
                            width: size.width * .45,
                            child: Consumer<CustomerController>(
                                builder: (context, cControl, child) {
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
                        Provider.of<CustomerController>(context, listen: false)
                            .addCustomer(
                                context,
                                image,
                                nameControl.text,
                                mobileControl.text,
                                mailControl.text,
                                streetControl.text,
                                street2Control.text,
                                cityControl.text,
                                pincodeControl.text);
                        nameControl.clear();
                        mobileControl.clear();
                        mailControl.clear();
                        streetControl.clear();
                        street2Control.clear();
                        cityControl.clear();
                        pincodeControl.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Submit",
                        style:
                            GLTextStyles.poppinsStyl(color: ColorTheme.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorTheme.mainClr),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
