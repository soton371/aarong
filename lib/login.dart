import 'dart:async';
import 'package:aarong/web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var formKey = GlobalKey<FormState>();
  dynamic username, password;

  var hideText = true;
  viewPass() {
    setState(() {
      hideText = !hideText;
    });
  }

  //for internet
  bool status = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  void checkRealtimeConnection() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        status = true;
      } else if (event == ConnectivityResult.wifi) {
        setState(() {
          status = true;
        });

      } else {
        status = false;
      }
      setState(() {});
    });
  }

  Widget noInternet(){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('images/nointernet.json',height: 200),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('No internet connection found.\nCheck your connection and try again.',
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkRealtimeConnection();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/10,),
          Image.asset('images/ezgif.com-gif-maker-removebg-preview.png',height: 100,),
          const SizedBox(height: 20,),
          const Text('Login',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
          ),
          const Text('Please log in to continue',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
          ),
          const SizedBox(height: 40,),
          Form(
            key:formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (v){
                    setState(() {
                      username=v;
                    });
                  },
                  validator: (v){
                    if(v!.isEmpty){
                      return 'please enter username';
                    }else{
                      return null;
                    }
                  },
                  style: const TextStyle(fontSize: 12),
                  keyboardType: TextInputType.emailAddress,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'USERNAME',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    prefixIcon: const Icon(Icons.person_outline,size: 18,),
                    hintStyle: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20,),

                TextFormField(
                  onChanged: (v){
                    setState(() {
                      password=v;
                    });
                  },
                  validator: (v){
                    if(v!.isEmpty){
                      return 'please enter password';
                    }else{
                      return null;
                    }
                  },
                  style: const TextStyle(fontSize: 12),
                  keyboardType: TextInputType.emailAddress,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: hideText,
                  decoration: InputDecoration(
                    hintText: 'PASSWORD',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    prefixIcon: const Icon(Icons.password_outlined,size: 18,),
                    suffixIcon: InkWell(
                      onTap: (){
                        setState(() {
                          hideText = !hideText;
                        });
                      },
                      child: hideText?const Icon(Icons.visibility_off,size: 18,):const Icon(Icons.visibility,size: 18,),
                    ),
                    hintStyle: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 5,),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forgot Password',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 12
                  ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 40,),

              ],
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ElevatedButton(
                onPressed: (){
                  final formstate = formKey.currentState;
                  if(formstate!.validate()){
                    FirebaseFirestore.instance
                        .collection("users")
                        .add({
                      'username': username,
                      'password': password
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const WebScreen()));
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Welcome to Aarong'),
                          backgroundColor: Colors.deepOrange,
                        )
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please add a complete field'),
                          backgroundColor: Colors.deepOrange,
                        )
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: const StadiumBorder(),
                    elevation: 0
                ),
                child: const Text('LOGIN',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/10,),
        ],
      ),
    ) : noInternet();
  }
}
