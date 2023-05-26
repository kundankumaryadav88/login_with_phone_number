import 'package:authenticationapp/components/common_button.dart';
import 'package:authenticationapp/components/common_text_box.dart';
import 'package:authenticationapp/screens/fourth_screen.dart';
import 'package:authenticationapp/services/api_service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ThirdScreen extends StatelessWidget {
  final String token;
  ThirdScreen({Key? key, required this.token}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(alignment: Alignment.topLeft, child: BackButton()),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Column(
                children: const [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome',
                      style: TextStyle(fontSize: 24, color: Colors.blueAccent),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Looks like you are new here. Tell us a bit about yourself.',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 21, 48, 94)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: screenWidth * 0.75,
                child: CommonTextBox(
                    controllerValue: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(),
                      ),
                    ))),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: screenWidth * 0.75,
                child: CommonTextBox(
                  controllerValue: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenWidth * 0.75,
              height: 40,
              child: CommonButton(
                  buttonLabel: 'Submit',
                  apiFunction: () {
                    final otpService = ApiService();
                    final name = nameController.text;
                    final email = emailController.text;
                    otpService
                        .submitProfile(name, email, token)
                        .then((response) {
                      if (response['status'] == true &&
                          name.isNotEmpty &&
                          email.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FourthScreen(),
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
          ],
        ),
      ),
    );
  }
}
