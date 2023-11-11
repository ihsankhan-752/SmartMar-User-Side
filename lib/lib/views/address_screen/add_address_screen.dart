import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/buttons.dart';
import '../../utils/styles/colors.dart';
import '../../utils/styles/text_styles.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isLoading = false;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Add Address Screen",
          style: AppTextStyles.APPBAR_HEADING_STYLE,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              SizedBox(height: 20),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                  ),
                  onSaved: (v) {
                    setState(() {
                      firstName = v.toString();
                    });
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "First Name Must Be Filled";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10, left: 5),
                    hintText: 'First Name',
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10, left: 5),
                    hintText: 'Last Name',
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                  onSaved: (v) {
                    setState(() {
                      lastName = v.toString();
                    });
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Last Name Must Be Filled";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                  ),
                  onSaved: (v) {
                    setState(() {
                      phoneNumber = v.toString();
                    });
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Phone number Must Be Filled";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10, left: 5),
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SelectState(
                style: TextStyle(
                  color: AppColors.grey,
                ),
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value;
                  });
                },
              ),
              SizedBox(height: 50),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : PrimaryButton(
                      onTap: () async {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          var uid = FirebaseAuth.instance.currentUser!.uid;
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseFirestore.instance.collection("users").doc(uid).update({
                              "address": countryValue + " " + stateValue + " " + cityValue,
                              "userName": firstName + " " + lastName,
                              "phone": phoneNumber,
                            });
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            print(e);
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Please Fill All Requirements")));
                        }
                      },
                      title: "Add New Address",
                    ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
