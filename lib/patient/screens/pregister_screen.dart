import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/screens/uadd_image.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class RegisterAsPatient extends StatelessWidget {
  RegisterAsPatient({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterPatientController());

    return Scaffold(

      ///new code
        backgroundColor: const Color(0xFF49BFAB),


      // appBar: AppBar(
      //   elevation: 0,
      //   flexibleSpace: CustomAppBar(
      //     title: 'register'.tr,
      //     onPressed: () {
      //       Get.back();
      //     },
      //     isBackArrow: true,
      //   ),
      //   leading: Container(),
      // ),
      body:
      ///old code
      // Stack(
      //   children: [
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             AppTextWidgets.regularText(
      //                 text: 'already_have_an_account'.tr,
      //                 size: 12,
      //                 color: AppColors.BLACK),
      //             GestureDetector(
      //               onTap: () {
      //                 Get.back();
      //               },
      //               child: AppTextWidgets.mediumText(
      //                 text: " ${'login_now'.tr}",
      //                 color: AppColors.AMBER,
      //                 size: 12,
      //               ),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(
      //           height: 20,
      //         )
      //       ],
      //     ),
      //     SingleChildScrollView(
      //         child: Container(
      //       height: MediaQuery.of(context).size.height - 150,
      //       decoration: const BoxDecoration(
      //           color: AppColors.WHITE,
      //           borderRadius: BorderRadius.only(
      //               bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
      //       child: Padding(
      //         padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      //         child: Obx(() => Form(
      //               key: registerController.formKey,
      //               child: Column(
      //                 children: [
      //                   EditTextFormField(
      //                     labelText: 'enter_name'.tr,
      //                     errorText: registerController.isNameError.value
      //                         ? 'enter_name'.tr
      //                         : null,
      //                     onChanged: (val) {
      //                       registerController.name.value = val;
      //                       registerController.isNameError.value = false;
      //                     },
      //                     validator: (value) {
      //                       registerController.name.value = value ?? "";
      //                       if (registerController.name.value.isEmpty) {
      //                         return 'Please Enter Name';
      //                       }
      //                       return null;
      //                     },
      //                   ),
      //                   const SizedBox(
      //                     height: 3,
      //                   ),
      //                   EditTextFormField(
      //                     labelText: 'enter_number'.tr,
      //                     errorText: registerController.isPhoneNumberError.value
      //                         ? registerController.phnNumberError.value
      //                         : null,
      //                     onChanged: (val) {
      //                       registerController.phoneNumber.value = val;
      //                       registerController.isPhoneNumberError.value = false;
      //                     },
      //                     validator: (value) {
      //                       registerController.phoneNumber.value = value!;
      //                       if (registerController.phoneNumber.value.isEmpty) {
      //                         return 'mobile_error_1'.tr;
      //                       } else if (registerController.phoneNumber.value.length <
      //                           PHONE_LENGTH) {
      //                         return 'mobile_error_2'
      //                             .trParams({'length': PHONE_LENGTH.toString()});
      //                       }
      //                       return null;
      //                     },
      //                     keyboardType: TextInputType.phone,
      //                   ),
      //                   const SizedBox(
      //                     height: 3,
      //                   ),
      //                   EditTextFormField(
      //                     labelText: 'enter_email_hint'.tr,
      //                     errorText: registerController.isEmailError.value
      //                         ? 'enter_email_error'.tr
      //                         : null,
      //                     onChanged: (val) {
      //                       registerController.email.value = val;
      //                       registerController.isEmailError.value = false;
      //                     },
      //                     validator: (value) {
      //                       registerController.email.value = value!;
      //                       if (registerController.email.value.isEmpty) {
      //                         return 'enter_email_hint'.tr;
      //                       } else if (!GetUtils.isEmail(
      //                           registerController.email.value)) {
      //                         return 'enter_email_error'.tr;
      //                       }
      //                       return null;
      //                     },
      //                     keyboardType: TextInputType.emailAddress,
      //                   ),
      //                   const SizedBox(
      //                     height: 3,
      //                   ),
      //                   EditTextFormField(
      //                     suffixIcon: IconButton(
      //                       icon: Icon(
      //                         registerController.passwordVisible.value
      //                             ? Icons.visibility
      //                             : Icons.visibility_off,
      //                         color: Theme.of(context).primaryColorDark,
      //                       ),
      //                       onPressed: () {
      //                         registerController.passwordVisible.value =
      //                             !registerController.passwordVisible.value;
      //                       },
      //                     ),
      //                     labelText: 'password'.tr,
      //                     errorText: registerController.isPassError.value
      //                         ? 'password_error'.tr
      //                         : null,
      //                     onChanged: (val) {
      //                       registerController.password.value = val;
      //                       registerController.isPassError.value = false;
      //                     },
      //                     validator: (value) {
      //                       registerController.password.value = value!;
      //                       if (registerController.password.value.isEmpty) {
      //                         return 'password_error1'.tr;
      //                       } else if (registerController.password.value.length <
      //                           PASS_LENGTH) {
      //                         return 'password_error2'
      //                             .trParams({'length': '$PASS_LENGTH'});
      //                       }
      //                       return null;
      //                     },
      //                     keyboardType: TextInputType.visiblePassword,
      //                     obscureText: registerController.passwordVisible.value,
      //                   ),
      //                   const SizedBox(
      //                     height: 3,
      //                   ),
      //                   EditTextFormField(
      //                     suffixIcon: IconButton(
      //                       icon: Icon(
      //                         registerController.passwordVisible1.value
      //                             ? Icons.visibility
      //                             : Icons.visibility_off,
      //                         color: Theme.of(context).primaryColorDark,
      //                       ),
      //                       onPressed: () {
      //                         registerController.passwordVisible1.value =
      //                             !registerController.passwordVisible1.value;
      //                       },
      //                     ),
      //                     labelText: 'confirm_password'.tr,
      //                     errorText: registerController.isPassError.value
      //                         ? 'password_error'.tr
      //                         : null,
      //                     onChanged: (val) {
      //                       registerController.confirmPassword.value = val;
      //                       registerController.isPassError.value = false;
      //                     },
      //                     validator: (value) {
      //                       registerController.confirmPassword.value = value!;
      //                       if (registerController.confirmPassword.value.isEmpty) {
      //                         return 'password_error1'.tr;
      //                       } else if (registerController.confirmPassword.value.length <
      //                           PASS_LENGTH) {
      //                         return 'password_error2'
      //                             .trParams({'length': '$PASS_LENGTH'});
      //                       }
      //                       return null;
      //                     },
      //                     keyboardType: TextInputType.visiblePassword,
      //                     obscureText: registerController.passwordVisible1.value,
      //                   ),
      //                   const SizedBox(
      //                     height: 23,
      //                   ),
      //                   Container(
      //                     height: 50,
      //                     child: InkWell(
      //                       onTap: () {
      //                         Get.focusScope?.unfocus();
      //                         // Get.off(UserAddImage());
      //
      //                         if (registerController.formKey.currentState!.validate()) {
      //                           registerController.registerUser();
      //                         }
      //                       },
      //                       child: Stack(
      //                         children: [
      //                           ClipRRect(
      //                             borderRadius: BorderRadius.circular(25),
      //                             child: Container(
      //                               decoration: const BoxDecoration(
      //                                 gradient: LinearGradient(
      //                                   colors: [
      //                                     AppColors.color1,
      //                                     AppColors.color2,
      //                                   ],
      //                                   begin: Alignment.bottomLeft,
      //                                   end: Alignment.topRight,
      //                                 ),
      //                               ),
      //                               height: 50,
      //                               width: MediaQuery.of(context).size.width,
      //                             ),
      //                           ),
      //                           Center(
      //                             child: AppTextWidgets.mediumText(
      //                               text: 'register'.tr,
      //                               color: AppColors.WHITE,
      //                               size: 18,
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                 ],
      //               ),
      //             )),
      //       ),
      //     )),
      //   ],
      // ),

      ///new code
      SafeArea(
        child: Column(
          children: [
            // Header section with back button and title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Create Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // Profile picture section
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9FDCC9),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF7DD1B8), width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Form section
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Obx(() => _buildTextField(
                      hintText: 'Full Name',
                      onChanged: (val) => registerController.name.value = val,
                      errorText: registerController.isNameError.value ? 'Please enter your name' : null,
                    )),
                    const SizedBox(height: 16),

                    // Obx(() => _buildTextField(
                    //   hintText: 'Phone number',
                    //   keyboardType: TextInputType.phone,
                    //   onChanged: (val) {
                    //     registerController.phoneNumber.value = val;
                    //     registerController.isPhoneNumberError.value = false;
                    //   },
                    //   errorText: registerController.isPhoneNumberError.value ? registerController.phnNumberError.value : null,
                    // )),
                    //const SizedBox(height: 16),

                    Obx(() => _buildTextField(
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        registerController.email.value = val;
                        registerController.isEmailError.value = false;
                      },
                      errorText: registerController.isEmailError.value ? 'Please enter a valid email' : null,
                    )),
                    const SizedBox(height: 16),

                    _buildTextField(
                      hintText: 'Blood group',
                      onChanged: (val) => registerController.bloodGroup.value = val,
                    ),
                    const SizedBox(height: 16),

                    _buildDateField(),
                    const SizedBox(height: 24),

                    // Gender section
                    const Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Obx(() => Row(
                      children: [
                        _buildGenderButton('Male'),
                        const SizedBox(width: 12),
                        _buildGenderButton('Female'),
                        const SizedBox(width: 12),
                        _buildGenderButton('Others'),
                      ],
                    )),

                    const SizedBox(height: 16),
                    _buildTextField(
                      hintText: 'Enter Your Location',
                      onChanged: (val) => registerController.location.value = val,
                    ),


                    const SizedBox(height: 16),

                    _buildTextField(
                      hintText: 'Pin Code',
                      keyboardType: TextInputType.number,
                      onChanged: (val) => registerController.pinCode.value = val,
                    ),
                    const SizedBox(height: 16),

                    // Notification checkbox
                    Obx(() => Row(
                      children: [
                        Checkbox(
                          value: registerController.receiveNotifications.value,
                          onChanged: (value) {
                            registerController.receiveNotifications.value = value ?? false;
                          },
                          activeColor: const Color(0xFF49BFAB),
                        ),
                        const Expanded(
                          child: Text(
                            'Click to receive blood donation request notifications on your WhatsApp',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    )),

                    const SizedBox(height: 24),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _validateAndSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF49BFAB),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      )

    );



  }

  void _validateAndSave() {
    final controller = Get.find<RegisterPatientController>();
    // Reset errors
    controller.isNameError.value = false;
    controller.isPhoneNumberError.value = false;
    controller.isEmailError.value = false;

    // Validate fields
    if (controller.name.value.isEmpty) {
      controller.isNameError.value = true;
      return;
    }

    if (controller.email.value.isEmpty) {
      controller.isEmailError.value = true;
      return;
    }

    if (!GetUtils.isEmail(controller.email.value)) {
      controller.isEmailError.value = true;
      return;
    }

    if (controller.bloodGroup.value.isEmpty) {
      Get.snackbar('Error', 'Please enter blood group',backgroundColor: AppColors.buttonColor,colorText: AppColors.WHITE);
      return;
    }

    if (controller.selectedDate.value == null) {
      Get.snackbar('Error', 'Please select date of birth',backgroundColor: AppColors.buttonColor,colorText: AppColors.WHITE);
      return;
    }

    if (controller.location.value.isEmpty) {
      Get.snackbar('Error', 'Please enter location',backgroundColor: AppColors.buttonColor,colorText: AppColors.WHITE);
      return;
    }

    if (controller.pinCode.value.isEmpty) {
      Get.snackbar('Error', 'Please enter pin code',backgroundColor: AppColors.buttonColor,colorText: AppColors.WHITE);
      return;
    }

    // Set the phone number from arguments
    controller.phoneNumber.value = controller.phone;

    //set date
    controller.date.value='${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}';

    // All validations passed - now register the user
    print('Name: ${controller.name.value}');
    print('Email: ${controller.email.value}');
    print('Phone: ${controller.phoneNumber.value}');
    print('Blood Group: ${controller.bloodGroup.value}');
    print('Date: ${controller.date.value}');
    print('Gender: ${controller.selectedGender.value}');
    print('Location: ${controller.location.value}');
    print('Pin Code: ${controller.pinCode.value}');
    print('Receive Notifications: ${controller.receiveNotifications.value}');




    // Call register user
    controller.registerNewUser();
  }

  Widget _buildTextField({
    required String hintText,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: errorText != null ? Colors.red : Colors.grey[300]!,
            ),
          ),
          child: TextField(
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDateField() {
    final controller = Get.find<RegisterPatientController>();
    return Obx(() => InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: Get.context!,
          initialDate: controller.selectedDate.value ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          controller.selectedDate.value = picked;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.selectedDate.value != null
                  ? '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}'
                  : 'Date of birth',
              style: TextStyle(
                color: controller.selectedDate.value != null ? Colors.black : Colors.grey[400],
                fontSize: 15,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildGenderButton(String gender) {
    final controller = Get.find<RegisterPatientController>();
    final isSelected = controller.selectedGender.value == gender;
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.selectedGender.value = gender;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF49BFAB).withAlpha(38) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF49BFAB) : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Text(
            gender,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? const Color(0xFF49BFAB) : Colors.grey[600],
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

}
