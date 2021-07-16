import 'package:anagram_game/AnagramDictionary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


enum Mode { start, finish }
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
  AnagramDictionary anagramDictionary = AnagramDictionary();
  String pickedWord ='';
  List<Text> wordsTyped = [];
  Mode gameMode = Mode.start;
  IconData playAnswers = CupertinoIcons.question;


  void getDictionary() async{
    await anagramDictionary.getFileData("assets/words.txt");
    anagramDictionary.pickGoodStarterWord();
    setState(() {
      pickedWord = anagramDictionary.pickedWord;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDictionary();

  }



  @override
  Widget build(BuildContext context) {
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
                "to ${pickedWord.toUpperCase()} ( but that no contain the substring $pickedWord "
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
                  print(anagramDictionary.getAnagramsWithOneMoreLetter(pickedWord));

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
        floatingActionButton: FloatingActionButton(
          child: Icon(playAnswers),
          onPressed: (){


            setState(() {
              if(gameMode == Mode.start){
                List<String> anagramsWithOneMoreLetter = anagramDictionary.getAnagramsWithOneMoreLetter(pickedWord);
                anagramsWithOneMoreLetter.forEach((String word) {
                  wordsTyped.add(Text(word));
                });
                playAnswers = CupertinoIcons.play_arrow_solid;
                gameMode = Mode.finish;
              }else if(gameMode == Mode.finish){
                wordsTyped = [];
                anagramDictionary.pickGoodStarterWord();
                pickedWord = anagramDictionary.pickedWord;
                playAnswers = CupertinoIcons.question;
                gameMode = Mode.start;
              }

            });

          },
        ),
    );
  }
}
