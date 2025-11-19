import 'package:videocalling_medical/common/utils/app_imports.dart';

class OtpLoginScreen extends StatelessWidget {
  OtpLoginScreen({super.key});

  final OtpLoginController controller = Get.put(OtpLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Obx(() =>
                  controller.showOtpView.value ? _buildOtpView() : _buildPhoneView()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildTermsSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Phone View ----------
  Widget _buildPhoneView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 30),
        // Illustration + logo
        SizedBox(
          height: 230,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(AppImages.otp1, fit: BoxFit.contain),
              ),
              Positioned(
                right: 10,
                child: Image.asset(AppImages.splashIcon, width: 60),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Get Started',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('Enter your Phone number', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 15),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller.phoneTextField,
            keyboardType: TextInputType.phone,
            onChanged: (value) => controller.phoneNumber.value = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.all(15),
            ),
          ),
        ),
        const SizedBox(height: 30),

        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: controller.sendOtp,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4FC3B7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.black),
              ),
            ),
            child: const Text(
              'SEND OTP',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  // ---------- OTP View ----------
  Widget _buildOtpView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            InkWell(
              onTap: controller.backToPhone,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.arrow_back_ios, color: Color(0xFF30455C)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        SizedBox(height: 230, child: Image.asset(AppImages.otp2)),
        const SizedBox(height: 30),
        const Text(
          'OTP Verification',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          'Enter the verification code we just sent on your\nphone number',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 60),

        OtpTextField(
          numberOfFields: 6,
          fieldWidth: Get.width*.11,
          borderColor: Colors.black,
          focusedBorderColor: const Color(0xFF4FC3B7),
          showFieldAsBox: true,
          borderRadius: BorderRadius.circular(18),
          onSubmit: (code) => controller.otpCode.value = code,
        ),
        const SizedBox(height: 30),

        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () => controller.verifyOtp(1),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4FC3B7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.black),
              ),
            ),
            child: const Text(
              'ENTER OTP',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 15),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: TextButton(
        //     onPressed: controller.resendOtp,
        //     child: const Text('Resend OTP', style: TextStyle(color: Colors.black)),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildTermsSection() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        children: const [
          TextSpan(text: 'By Signing In, you accept our ', style: TextStyle(fontSize: 14)),
          TextSpan(text: 'T&Cs', style: TextStyle(fontSize: 14, color: Color(0xFF4FC3B7))),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(fontSize: 14, color: Color(0xFF4FC3B7)),
          ),
        ],
      ),
    );
  }
}
