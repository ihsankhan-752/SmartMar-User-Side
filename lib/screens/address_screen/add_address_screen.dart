import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/services/user_profile_services.dart';
import 'package:smart_mart_user_side/widgets/custom_msg.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../widgets/buttons.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String? countryValue;
  late String stateValue;
  late String cityValue;
  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Address",
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.primaryBlack),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
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
            Consumer<LoadingController>(builder: (context, loadingController, child) {
              return loadingController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : PrimaryButton(
                      onTap: () {
                        if (countryValue != null) {
                          UserProfileServices.updateUserAddress(
                            context: context,
                            address: countryValue! + " " + stateValue + " " + cityValue,
                          );
                        } else {
                          showCustomMsg(context: context, msg: "Choose Country");
                        }
                      },
                      title: "Add New Address",
                    );
            }),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
