import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';


class AnagramDictionary{
  List<String> wordList = [];
  Set<String> wordSet = {};
  Map lettersToWord = {};
  Map sizeToWords ={};
  String data = '';
  String pickedWord = "";
  int defaultWordLength = 4;


  String sortLetters(String word){

    List<String> wordCharacters = word.split('');
    wordCharacters.sort();
    return wordCharacters.join();
  }

  Future<void> getFileData(String path) async {
    this.data = await rootBundle.loadString(path);
    this.wordList = this.data.split('\n');
    this.wordSet =  this.wordList.toSet();
    wordSet.forEach((String word) {
      String key = sortLetters(word);
      if(!this.lettersToWord.containsKey(key)){
        this.lettersToWord[key] = [word];
      }else{
        this.lettersToWord[key].add(word);
      }

      int wordSize = word.length;
      if(!this.sizeToWords.containsKey(wordSize)){
        this.sizeToWords[wordSize] = [word];
      }else{
        this.sizeToWords[wordSize].add(word);
      }

    });




  }

  List<String> getAnagrams(String word){
    String key = sortLetters(word);
    return this.lettersToWord[key];
  }

  bool isGoodWord(String word){
    if(this.wordSet.contains(word) && !word.contains(pickedWord) && word.length > defaultWordLength) {
      return true;
    }else{
      return false;
    }
  }

  List<String> getAnagramsWithOneMoreLetter(String word){
    List<String> anagramsWithOneMoreLetter = [];
    List<String> alphabet =["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
    alphabet.forEach((String char) {
      String key = sortLetters(word + char);
      if (this.lettersToWord.containsKey(key)){
        anagramsWithOneMoreLetter += lettersToWord[key];
      }
    });

    return anagramsWithOneMoreLetter;
  }

  pickGoodStarterWord(){
    List<String> words = sizeToWords[defaultWordLength];
    String word = '';
    word = words[Random().nextInt(words.length)];
    // while(word.length < 3 || word.length > 7){
    //   word = wordList[Random().nextInt(wordList.length)];
    // }
    this.pickedWord = word;
  }



}