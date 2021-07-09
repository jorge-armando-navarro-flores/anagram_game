import 'package:flutter/services.dart' show rootBundle;



class AnagramDictionary{
  List<String> wordList = [];
  Set<String> wordSet = {};
  Map lettersToWord = {};
  String data = '';


  String sortLetters(String word){

    List<String> wordCharacters = word.split('');
    wordCharacters.sort();
    return wordCharacters.join();
  }

  getFileData(String path) async {
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

    });

  }

  List<String> getAnagrams(String word){
    String key = sortLetters(word);
    return this.lettersToWord[key];
  }

  bool isGoodWord(String word){
    if(this.wordSet.contains(word) && !word.contains("post")) {
      return true;
    }else{
      return false;
    }
  }

  List<String> getAnagramsWithOneMoreLetter(String word){
    List<String> anagramsWithOneMoreLetter = [];
    List<String> alphabet =["s","o","n","p","t"];
    alphabet.forEach((String char) {
      String key = sortLetters(word + char);
      if (this.lettersToWord.containsKey(key)){
        anagramsWithOneMoreLetter += lettersToWord[key];
      }
    });

    return anagramsWithOneMoreLetter;
  }



}