import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/textstyles.dart';
import '../../customer_screen/view/widget/customer_card.dart';
import '../../single_customer_screen/controller/single_customer_controller.dart';
import '../../single_customer_screen/view/single_customer_screen.dart';
import '../controller/search_cusomer_controller.dart';

class SearchCustomerScreen extends StatefulWidget {
  const SearchCustomerScreen({super.key});

  @override
  State<SearchCustomerScreen> createState() => _SearchCustomerScreenState();
}

class _SearchCustomerScreenState extends State<SearchCustomerScreen> {
  TextEditingController searchControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Here",
          style: GLTextStyles.poppinsStyl(),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.width * .2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: size.width * .1,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: ColorTheme.black.withOpacity(.5),
                        width: 1.0,
                      ),
                    ),
                    child: TextFormField(
                      controller: searchControl,
                      decoration: InputDecoration(hintText: "Search Here"),
                    )),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<SearchCustomerController>(context,
                              listen: false)
                          .isSearchTapped = true;
                      Provider.of<SearchCustomerController>(context,
                              listen: false)
                          .fetchProduct(context, searchControl.text);
                    },
                    child: Text("Search",
                        style: GLTextStyles.ralewayStyl(
                            size: 18, color: ColorTheme.white)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorTheme.mainClr),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Consumer<SearchCustomerController>(
        builder: (context, sControl, child) {
          return sControl.isSearchTapped == false
              ? Center(
                  child: Text(
                    "Search For Details",
                    style: GLTextStyles.robotoStyl(),
                  ),
                )
              : sControl.isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * .05,
                        horizontal: size.width * .02,
                      ),
                      child: sControl.searchCustomerModel.data == null ||
                              sControl.searchCustomerModel.data!.isEmpty == true
                          ? Center(
                              child: Text(
                                "No data Found",
                                style: GLTextStyles.robotoStyl(),
                              ),
                            )
                          : ListView.builder(
                              itemCount:
                                  sControl.searchCustomerModel.data?.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Provider.of<SingleCustomerController>(
                                            context,
                                            listen: false)
                                        .fetchProduct(
                                            context,
                                            sControl.searchCustomerModel
                                                .data?[index].id)
                                        .then((value) =>
                                            Timer(Duration(milliseconds: 200),
                                                () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SingleCustomerScreen(
                                                            id: sControl
                                                                .searchCustomerModel
                                                                .data?[index]
                                                                .id,
                                                          )));
                                            }));
                                  },
                                  child: CustumerCard(
                                      size: size,
                                      image: sControl.searchCustomerModel
                                          .data?[index].profilePic,
                                      title: sControl.searchCustomerModel
                                          .data?[index].name,
                                      id: sControl
                                          .searchCustomerModel.data?[index].id
                                          .toString(),
                                      address:
                                          "${sControl.searchCustomerModel.data?[index].street} ${sControl.searchCustomerModel.data?[index].streetTwo}",
                                      state:
                                          "${sControl.searchCustomerModel.data?[index].city} ${sControl.searchCustomerModel.data?[index].state}"),
                                );
                              }),
                    );
        },
      ),
    ));
  }
}
