import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/controllers/user_controller.dart';
import 'package:smart_mart_user_side/services/user_profile_services.dart';
import 'package:smart_mart_user_side/widgets/custom_text_fields.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../widgets/buttons.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context).userModel;
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
            SizedBox(height: 50),
            AuthTextInput(
              controller: _countryController,
              hintText: userController!.country!.isEmpty ? " Country" : _countryController.text,
            ),
            SizedBox(height: 20),
            AuthTextInput(
              controller: _stateController,
              hintText: userController.state!.isEmpty ? " State" : _countryController.text,
            ),
            SizedBox(height: 20),
            AuthTextInput(
              controller: _cityController,
              hintText: userController.state!.isEmpty ? " City" : _countryController.text,
            ),
            SizedBox(height: 40),
            Consumer<LoadingController>(builder: (context, loadingController, child) {
              return loadingController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : PrimaryButton(
                      onTap: () {
                        UserProfileServices.updateUserAddress(
                          context: context,
                          country: _countryController.text.isEmpty ? userController.country : _countryController.text,
                          state: _stateController.text.isEmpty ? userController.state : _stateController.text,
                          city: _cityController.text.isEmpty ? userController.city : _cityController.text,
                        );
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
