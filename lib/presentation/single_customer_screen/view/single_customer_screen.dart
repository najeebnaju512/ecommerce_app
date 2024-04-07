import 'dart:io';

import 'package:ecommerce_test/presentation/single_customer_screen/controller/single_customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../config/app_config.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/textstyles.dart';
import '../../../global_widget/image_icon_button.dart';

class SingleCustomerScreen extends StatefulWidget {
  const SingleCustomerScreen({super.key, required this.id});
  final int? id;
  @override
  State<SingleCustomerScreen> createState() => _SingleCustomerScreenState();
}

class _SingleCustomerScreenState extends State<SingleCustomerScreen> {
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    Provider.of<SingleCustomerController>(context, listen: false)
        .fetchProduct(context, widget.id);
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
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Consumer<SingleCustomerController>(
          builder: (context, sControl, child) {
            var imageUrl = sControl.singleCustomerModel.data?.profilePic == null
                ? "https://th.bing.com/th/id/OIP.y6HMdOJ4LiIUWk7n5ZGlpAHaHa?w=480&h=480&rs=1&pid=ImgDetMain"
                : AppConfig.mediaurl +
                    "${sControl.singleCustomerModel.data?.profilePic}";
            return Center(
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Card(
                  color: ColorTheme.white,
                  child: sControl.isLoading == false
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.arrow_back_ios)),
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  height: size.width * .7,
                                  width: size.width * .7,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                    "${sControl.singleCustomerModel.data?.name}",
                                    style: GLTextStyles.poppinsStyl(
                                        color: ColorTheme.black,
                                        weight: FontWeight.bold,
                                        size: 30)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                    "Mobile: ${sControl.singleCustomerModel.data?.mobileNumber}",
                                    style: GLTextStyles.kanitStyl(
                                        color: ColorTheme.black,
                                        size: 20,
                                        weight: FontWeight.w400)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                    "Email: ${sControl.singleCustomerModel.data?.email}",
                                    style: GLTextStyles.kanitStyl(
                                        color: ColorTheme.black,
                                        size: 20,
                                        weight: FontWeight.w400)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("Address",
                                    style: GLTextStyles.poppinsStyl(
                                        color: ColorTheme.black,
                                        weight: FontWeight.bold,
                                        size: 30)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                    "${sControl.singleCustomerModel.data?.street} ${sControl.singleCustomerModel.data?.streetTwo}",
                                    style: GLTextStyles.kanitStyl(
                                        color: ColorTheme.black,
                                        size: 20,
                                        weight: FontWeight.w400)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                    "${sControl.singleCustomerModel.data?.city} ${sControl.singleCustomerModel.data?.pincode}",
                                    style: GLTextStyles.kanitStyl(
                                        color: ColorTheme.black,
                                        size: 20,
                                        weight: FontWeight.w400)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _editCustommer(context, size);
                                  },
                                  child: Text(
                                    "Edit",
                                    style: GLTextStyles.poppinsStyl(
                                        weight: FontWeight.normal, size: 12),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorTheme.mainClr,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                              )
                            ],
                          ),
                        ),
                ),
              ),
            );
          },
        ));
  }

  Future<dynamic> _editCustommer(BuildContext context, Size size) async {
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
                            Provider.of<SingleCustomerController>(context,
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
                            child: Consumer<SingleCustomerController>(
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
                            child: Consumer<SingleCustomerController>(
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
                        Provider.of<SingleCustomerController>(context,
                                listen: false)
                            .onEditCustomer(
                                context,
                                image,
                                widget.id,
                                nameControl.text,
                                mobileControl.text,
                                mailControl.text,
                                streetControl.text,
                                street2Control.text,
                                cityControl.text,
                                pincodeControl.text,
                                Provider.of<SingleCustomerController>(context,
                                        listen: false)
                                    .selectedCountry
                                    .toString(),
                                Provider.of<SingleCustomerController>(context,
                                        listen: false)
                                    .selectedState
                                    .toString());
                        nameControl.clear();
                        mobileControl.clear();
                        mailControl.clear();
                        streetControl.clear();
                        street2Control.clear();
                        cityControl.clear();
                        pincodeControl.clear();
                        setState(() {
                          // fetchData();
                        });
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
