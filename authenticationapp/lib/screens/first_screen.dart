import 'package:authenticationapp/components/common_button.dart';
import 'package:authenticationapp/components/common_logo.dart';
import 'package:authenticationapp/components/common_text_box.dart';
import 'package:authenticationapp/screens/second_screen.dart';
import 'package:authenticationapp/services/api_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class FirstScreen extends StatelessWidget {
  TextEditingController phoneNumberController = TextEditingController();

  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
                // alignment: AlignmentDirectional(-0.8, 0),
                child: CommonLogo()),
            const SizedBox(height: 60),
            const Align(
              // alignment: AlignmentDirectional(-0.85, 0),
              child: Text(
                'Get Started',
                style: TextStyle(
                    fontSize: 24, color: Color.fromARGB(255, 10, 49, 80)),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: screenWidth * 0.75, // Adjust the width as needed
              decoration: BoxDecoration(
                // boxShadow: [BoxShadow(blurRadius: 0)],
                border: Border.all(
                  width: 1,
                  color: Colors.blueAccent,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: const Text(
                      '+91',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Text(
                    "|",
                    style: TextStyle(fontSize: 33, color: Colors.grey),
                  ),
                  Expanded(
                    child: CommonTextBox(
                      controllerValue: phoneNumberController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your mobile number',
                        contentPadding: EdgeInsets.all(10),
                      ),
                      inputFormate: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: screenWidth * 0.75,
              height: 45,
              child: CommonButton(
                apiFunction: () {
                  final otpService = ApiService();
                  final mobileNumber = phoneNumberController.text;
                  if (mobileNumber.length == 10) {
                    otpService.sendOtp(mobileNumber).then((response) {
                      if (response["status"] == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondScreen(
                              mobileNumber: mobileNumber,
                              requestId: response["request_id"],
                            ),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${response["response"]}"),
                          ),
                        );
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Enter a Valid Number"),
                      ),
                    );
                  }
                },
                buttonLabel: 'Continue',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
