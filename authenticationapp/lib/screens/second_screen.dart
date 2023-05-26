// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:authenticationapp/components/common_button.dart';
import 'package:authenticationapp/components/common_logo.dart';
import 'package:authenticationapp/screens/first_screen.dart';
import 'package:authenticationapp/screens/fourth_screen.dart';
import 'package:authenticationapp/screens/third_screen.dart';
import 'package:authenticationapp/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class SecondScreen extends StatelessWidget {
  final String requestId;
  final String mobileNumber;
  SecondScreen({
    Key? key,
    required this.requestId,
    required this.mobileNumber,
  }) : super(key: key);
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(alignment: Alignment.topLeft, child: const BackButton()),
            const SizedBox(height: 30),
            const Align(
              // alignment: AlignmentDirectional(-0.8, 0),
              child: CommonLogo(),
            ),
            const SizedBox(height: 60),
            Align(
              alignment: const AlignmentDirectional(-0.5, 0),
              child: Text.rich(
                TextSpan(
                  text: "Enter OTP",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                  children: [
                    const TextSpan(text: "\n"),
                    TextSpan(
                        text: "OTP has been sent to +91-$mobileNumber",
                        style: const TextStyle(fontStyle: FontStyle.normal)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 46, top: 30, right: 45),
              child: Semantics(
                label: "OTP",
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.number,
                  autoDismissKeyboard: true,
                  enableActiveFill: true,
                  cursorColor: Colors.black,
                  controller: otpController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {},
                  textStyle: const TextStyle(
                    color: Colors.blueAccent,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                  pinTheme: PinTheme(
                    fieldHeight: 60.00,
                    fieldWidth: 45.00,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(
                      5.00,
                    ),
                    selectedFillColor: const Color(0xffEAEDF3),
                    activeFillColor: const Color(0xffEAEDF3),
                    inactiveFillColor: const Color(0xffEAEDF3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: screenWidth * 0.75,
              height: 45,
              child: CommonButton(
                  buttonLabel: 'Verify',
                  apiFunction: () {
                    final otpService = ApiService();
                    final otp = otpController.text;

                    otpService.verifyOtp(requestId, otp).then((response) {
                      if (response['status'] == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                response["profile_exists"] == true
                                    ? const FourthScreen()
                                    : ThirdScreen(token: response['jwt']),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${response['response']}"),
                          ),
                        );
                      }
                    });
                  }),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Retry button action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirstScreen(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Retry(this button send back to first screen. with number entered)',
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
