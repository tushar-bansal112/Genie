import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectss/feature_box.dart';
import 'package:projectss/openAI_services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName="";
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  String lastWords ='';
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
    getCurrentUser();
  }
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
    messageStream();
  }
  void messageStream() async {
    await for (var snapshot in _firestore.collection('users').snapshots()) {
      for (var message in snapshot.docs) {
        if(message.data()['e-mail']==loggedInUser.email) {
          userName=message.data()['name'];
          print(userName);
        }
      }
    }
  }
  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }
  Future<void>initSpeechToText() async{
    await speechToText.initialize();
    setState(() {

    });
  }
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
    print("----------------- $lastWords");
  }
  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }
  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(
          child: const Text(
            'Genie',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(30.0),
          children: [
            ListTile(
              title: const Text(
                  'Sign Out',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: (){
                Navigator.pushNamed(context, '/');
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ZoomIn(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightBlue.shade100,
                      ),
                    ),
                  ),
                  Container(
                    height: 123,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/image/virtualAssistant.png',
                        )
                      )
                    ),
                  ),
                ],
              ),
            ),
            FadeInRight(
              child: Visibility(
              visible: generatedImageUrl==null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 25),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                    borderRadius: BorderRadius.circular(20).copyWith(
                      topLeft: Radius.zero,
                    )
                ),
                child:  Padding(
                  padding:  const EdgeInsets.symmetric(vertical: 6),
                  child:  Text(
                    generatedContent==null?'Hello $userName, what task can I do for you?':
                    generatedContent!,
                    style: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontSize: generatedContent==null?20:15,
                      color: const Color.fromRGBO(19, 61, 95, 1),
                    ),
                  ),
                ),
              ),
            ),
            ),

            if (generatedImageUrl != null) Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(generatedImageUrl!),
              ),
            ),


            SlideInLeft(
              child: Visibility(
                visible: generatedContent==null && generatedImageUrl==null,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 6, left: 22),
                  child: const Text(
                    'Here are a few features',
                    style: TextStyle(
                      fontFamily: 'Cera Pro',
                      color: Color.fromRGBO(19, 61, 95, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: generatedContent==null && generatedImageUrl==null,
              child: Column(
                children:  [
                  SlideInLeft(
                    delay: Duration(milliseconds: start),
                    child: const FeatureBox(
                        color:  Color.fromRGBO(165, 231, 244, 1),
                        headerText: 'ChatGPT',
                        descriptionText: 'A smarter way to stay organized and informed with ChatGPT',
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start+delay),
                    child: const FeatureBox(
                      color: Color.fromRGBO(157, 202, 235, 1),
                      headerText: 'Dall-E',
                      descriptionText:
                      'Get inspired and stay creative with your personal assistant powered by Dall-E',
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start+2*delay),
                    child: const FeatureBox(
                      color: Color.fromRGBO(162, 238, 239, 1),
                      headerText: 'Smart Voice Assistant',
                      descriptionText:
                      'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start+3*delay),
        child: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(165, 231, 244, 1),
          onPressed: () async{
            if(await speechToText.hasPermission && speechToText.isNotListening){
              await startListening();
            }else if(speechToText.isListening){
              final speech = await openAIService.isArtPromptAPI(lastWords);
              if (speech.contains('https')) {
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
              await stopListening();
            }else{
              initSpeechToText();
            }
          },
          child: Icon(
            speechToText.isListening ? Icons.stop : Icons.mic,
          ),
        ),
      ),
    );
  }
}
