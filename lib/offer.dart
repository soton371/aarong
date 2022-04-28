import 'package:aarong/login.dart';
import 'package:flutter/material.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Align(
                 alignment: Alignment.centerLeft,
                 child: Text('30% off continue with facebook\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.deepOrange
              ),
              ),
               ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('images/ezgif.com-gif-maker (1).jpg',),
              ),
              const SizedBox(height: 60,),
              ElevatedButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen())),
                  child: const Text("Let's Start",
                    style: TextStyle(fontSize: 16),
                  ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: const StadiumBorder(),
                  elevation: 0
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
