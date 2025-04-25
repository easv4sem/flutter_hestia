import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/core/routes.dart';
import 'package:hestia/presentation/widgets/app_bar_widget.dart';

class LandingPage extends StatelessWidget{
  
  const LandingPage({super.key});

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(),
      

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Green Tech for a\n",
                style: TextStyle(
                  fontFamily: 'LeagueSpartan',
                  fontWeight: FontWeight.bold,
                  fontSize: 128,
                  shadows: const <Shadow>[
                    BoxShadow(
                      offset: Offset(5, 10),
                      blurRadius: 20.0,
                      color: Color.fromARGB(255, 91, 91, 91),
                      spreadRadius: 0.1,
                    ),
                  ],
                  
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: " Burning",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 252, 151, 1),
                    ),
                  ),
                  TextSpan(
                    text: " Issue",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),

            const Text('See the fire before the smoke'),
            const Text('Real-time wildfire detection that makes a difference.'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: null, // Add your onPressed function here
                  child: Text('Get in contact'),
                ),

                ElevatedButton(
                  onPressed: () => context.go(Routes.home.path),
                  child: Text('Get started'),
                  )
              ],
            ),
          ],
        ),
      ),
    );  
  }

}