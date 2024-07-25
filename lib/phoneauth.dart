import 'package:authphone/otpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text("Phone Auth"),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 90.0,
            ),
            Image.asset(
              "assets/images/android.png",
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "OTP Verification.",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 30,right: 30,top: 10),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'We will send you an',
                      style: TextStyle(color: Colors.grey,fontSize: 16),
                    ),
                    TextSpan(
                      text: ' One Time Password ',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Text("on this mobile number.",style: TextStyle(color: Colors.grey,fontSize: 16),),
            SizedBox(
              height: 35.0,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  Material(
                    elevation: 20,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(25.0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: "+91-0000-00-000",
                          prefixIcon:
                              Icon(Icons.phone, color: Color(0xff224597)),
                          // labelText: "Enter Phone Number",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white70,
                              width: 5.0,
                            ),
                          )),
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          'Get OTP',
                          style: TextStyle(
                            fontSize: 20,
                            height: 3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),

                        FloatingActionButton(
                          backgroundColor: Colors.deepPurpleAccent,
                          onPressed: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                                verificationCompleted: (PhoneAuthCredential credential) {},
                                verificationFailed: (FirebaseException ex) {},
                                codeSent: (String verificationid, int? resendtoken) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Otpscreen(verificationid: verificationid,)));
                                },
                                codeAutoRetrievalTimeout: (String verificationId) {},
                                phoneNumber: "+91${phoneController.text}");
                          },
                          child: Icon(Icons.arrow_forward,color: Colors.white,),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 145),

                  Text('Don\'t you have an Phone Number?EXIT'),

                ],
              ),
            )

          ],
        ),
      ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 25),
      //       child: TextField(
      //         controller: phoneController,
      //         decoration: InputDecoration(
      //             hintText: "Enter Phone Number",
      //             suffixIcon: Icon(Icons.phone),
      //             border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(24))),
      //       ),
      //     ),
      //     SizedBox(height: 30),
      //     ElevatedButton(
      //         onPressed: () async {
      //           await FirebaseAuth.instance.verifyPhoneNumber(
      //               verificationCompleted: (PhoneAuthCredential credential) {},
      //               verificationFailed: (FirebaseException ex) {},
      //               codeSent: (String verificationid, int? resendtoken) {
      //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Otpscreen(verificationid: verificationid,)));
      //               },
      //               codeAutoRetrievalTimeout: (String verificationId) {},
      //               phoneNumber: phoneController.text.toString());
      //         },
      //         child: Text("Verify Phone Number"),
      //     )
      //   ],
      //),
    );
  }
}
