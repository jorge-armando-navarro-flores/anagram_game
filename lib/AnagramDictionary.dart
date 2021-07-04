import 'package:english_words/english_words.dart';

class AnagramDictionary{
  Set<String> wordSet = all.toSet();
  Map lettersToWord = {};


  String sortLetters(String word){

    List<String> wordCharacters = word.split('');
    wordCharacters.sort();
    return wordCharacters.join();
  }

  getLettersToWord(){
    wordSet.forEach((String word) {
      String key = sortLetters(word);
      if(!lettersToWord.containsKey(key)){
        lettersToWord[key] = [word];
      }else{
        lettersToWord[key].add(word);
      }

    });
  }

}