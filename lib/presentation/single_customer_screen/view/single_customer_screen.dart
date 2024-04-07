import 'package:ecommerce_test/presentation/single_customer_screen/controller/single_customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_config.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/textstyles.dart';

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
                                  onPressed: () {},
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
}
