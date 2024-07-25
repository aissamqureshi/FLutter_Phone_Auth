import 'dart:math';
import 'package:authphone/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Otpscreen extends StatefulWidget {
  final String verificationid;
  Otpscreen({super.key, required this.verificationid});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 55,
      height: 55,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Image.asset(
              "assets/images/checkbox_2.png",
              fit: BoxFit.cover,
            ),
            Text(
              "OTP Verification.",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Enter The ',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    TextSpan(
                      text: 'OTP ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: Colors.blueAccent),
                    ),
                    TextSpan(
                      text: 'Here!',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 35.0,
            ),

            Pinput(
              length: 6,
              controller: otpController,
              keyboardType: TextInputType.phone,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: Colors.green),
                ),
              ),
              textInputAction: TextInputAction.next,
              showCursor: true,
              validator: (s) {
                print('validating code: $s');
              },
              onCompleted: (pin) => debugPrint(pin),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don\'t receive the OTP?',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    TextSpan(
                      text: ' RESEND OTP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blueAccent.shade200),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        await PhoneAuthProvider.credential(
                            verificationId: widget.verificationid,
                            smsCode: otpController.text.toString());
                    FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage(title: "MyHomePage")));
                    });
                  } catch (ex) {
                    log(ex.toString() as num);
                  }
                },
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blueAccent.shade200),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                child: Text("Verify And Proceed"))
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Phone Auth"),
    //     centerTitle: true,
    //   ),
    //   body: Column(
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 25),
    //         child: TextField(
    //           controller: otpController,
    //           keyboardType: TextInputType.phone,
    //           decoration: InputDecoration(
    //               hintText: "Enter The Otp",
    //               suffixIcon: Icon(Icons.phone),
    //               border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(25))),
    //         ),
    //       ),
    //       SizedBox(height: 30),
    //       ElevatedButton(
    //           onPressed: () async {
    //             try {
    //               PhoneAuthCredential credential =
    //               await PhoneAuthProvider.credential(
    //                   verificationId: widget.verificationid,
    //                   smsCode: otpController.text.toString());
    //               FirebaseAuth.instance.signInWithCredential(credential).then((value){
    //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "MyHomePage")));
    //               });
    //             } catch (ex) {
    //               log(ex.toString() as num );
    //             }
    //           },
    //            child: Text("OTP"))
    //     ],
    //   ),
    // );
  }
}
