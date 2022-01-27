import 'package:flutter/material.dart';
import 'package:hskl_portal/constants.dart';
import 'package:hskl_portal/main.dart';
import 'package:url_launcher/url_launcher.dart';



class LandingPage extends StatelessWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage())) , 
                child: const Text("Anmeldung", style: TextStyle(fontSize: 23),),
                style: ElevatedButton.styleFrom(primary: secondaryColor, minimumSize: const Size(175,75), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(width: 25),
                ElevatedButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage())) , 
                child: const Text("Registrierung", style: TextStyle(fontSize: 23),),
                style: ElevatedButton.styleFrom(primary: secondaryColor, minimumSize: const Size(175,75), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                ),
              ],
            ),
          ),

          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/logo.png'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Willkommen auf dem HS-KL Portal", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 50),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Alle Tools auf einer Plattform vereint", style:  TextStyle(color: Colors.black,fontSize: 30),)
            ],
          ),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Whitebird
              Container(
                height: 425,
                width: 375,
                decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/images/whitebird.png', height: 100),
                    const SizedBox(height: 10),
                    const Text('Whitebird', style: TextStyle(fontSize: 45),),
                    const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                      child: Text('Whitebird ist ein quelloffenes, webbasiertes, kollaboratives, digitales Whiteboard, das mit NestJS, MongoDB, NuxtJs und FabricJs entwickelt wurde', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),)
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding*2),
                      child: ElevatedButton(
                        onPressed: (){
                          launchWhitebird();
                        },
                        child: const Text('Erfahre mehr', style: TextStyle(fontSize: 20),),
                         style: ElevatedButton.styleFrom(primary: primaryColor, minimumSize: const Size(125,70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ],
                ),
              ),

              //Beebusy
              const SizedBox(width: 50),
              Container(
                height: 425,
                width: 375,
                decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/images/beebusy.png', height: 100, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text('beebusy', style: TextStyle(fontSize: 45),),
                    const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                      child: Text('Tool zum operativen Projektmanagement à la Jira oder Wekan', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),)
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding*2),
                      child: ElevatedButton(
                        onPressed: (){
                          launchbeebusy();
                        },
                        child: const Text('Erfahre mehr', style: TextStyle(fontSize: 20),),
                         style: ElevatedButton.styleFrom(primary: primaryColor, minimumSize: const Size(125,70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ],
                ),
              ),

              //Brainwriter
              const SizedBox(width: 50),
               Container(
                height: 425,
                width: 375,
                decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/images/brainwriter.png', height: 100, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text('Brainwriter', style: TextStyle(fontSize: 45),),
                    const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                      child: Text('Brainstorming Technik, die es ermöglicht, in relativ kurzer Zeit viele Ideen zu entwickeln', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),)
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding*2),
                      child: ElevatedButton(
                        onPressed: (){
                          launchBrainwriter();
                        },
                        child: const Text('Erfahre mehr', style: TextStyle(fontSize: 20),),
                         style: ElevatedButton.styleFrom(primary: primaryColor, minimumSize: const Size(125,70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ],
                ),
              ),

              
            ],
          ),
          const Spacer(),
          Container(
            height: 100,
            width: double.infinity,
            color: secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                InkWell(
                  onTap: () => {launchImpressum()},
                  child: const Text('Impressum', style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding*2),
                  child: InkWell(
                    onTap: () => {launchHSKL()},
                    child: const Text('Hochschule Kaiserslautern', style: TextStyle(fontSize: 20)),
                  ),
                ),
                InkWell(
                  onTap: () => {launchGitHub()},
                  child: const Text('GitHub', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> launchWhitebird() async {
  await launch('https://github.com/BuchholzTim/Whitebird');
}

Future<void> launchbeebusy() async {
  await launch('https://github.com/Informatik-HS-KL/beebusy');
}

Future<void> launchBrainwriter() async {
  await launch('https://github.com/BuchholzTim/6-3-5-Brainwriter');
}

Future<void> launchHSKL() async {
  await launch('https://www.hs-kl.de');
}

Future<void> launchImpressum() async {
  await launch('https://www.hs-kl.de/en/about');
}

Future<void> launchGitHub() async {
  await launch('https://github.com/kibu7/HSKL-Portal');
}
