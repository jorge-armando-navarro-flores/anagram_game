import 'package:anagram_game/AnagramDictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

AnagramDictionary anagramDictionary = AnagramDictionary();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anagram game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnagramGame(),
    );
  }
}

class AnagramGame extends StatefulWidget {
  const AnagramGame({Key? key}) : super(key: key);

  @override
  _AnagramGameState createState() => _AnagramGameState();
}

class _AnagramGameState extends State<AnagramGame> {
  TextEditingController  textControl = TextEditingController();

  List<Text> wordsTyped = [];

  @override
  Widget build(BuildContext context) {
    anagramDictionary.getFileData("assets/words.txt");

    return Scaffold(
      appBar: AppBar(
        title: Text("Anagram game"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Find as many words as possible "
                "that can be performed by adding one letter"
                "to BADGE ( but that no contain the substring badge "
                "Hit Play to start again"),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: textControl,
                onEditingComplete: (){
                  // String f = String.fromCharCode(97);
                  setState(() {
                    String word = textControl.text;

                    if(anagramDictionary.isGoodWord(word)){
                      wordsTyped.add(Text(word,
                        style: TextStyle(
                          color: Colors.green
                        ),
                      ));
                    }else{
                      wordsTyped.add(Text("X $word",
                        style: TextStyle(
                            color: Colors.red
                        ),
                      ));
                    }


                  });
                  print(anagramDictionary.getAnagramsWithOneMoreLetter("post"));

                  textControl.clear();


                }
              ),
            ),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: wordsTyped,
            )

          ],
        ),
      ),
    );
  }
}
