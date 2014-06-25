import 'dart:html';

/// this should actually be gotten from a database where you store your shortened urls ids
num currentId = 150;
String chars = 'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ123456789';
int base = chars.length;
var db = new Map<num, String>();
var myurl = 'http://xaguz.man/';

void main() {
  
  InputElement btn = querySelector("#btnGenerate");
  TextInputElement input = querySelector("#txtInput");
  DivElement result = querySelector("#result");
  
  
  btn.onClick.listen((MouseEvent e){
    var encoded =  encode( currentId );
    db[currentId++] = input.value;    
    result.innerHtml = "$myurl$encoded <br/> Gets you: ${db[ decode( encoded ) ]}";
  });
  
  
}

String encode(num recordId){
  if ( recordId == 0 ) return chars[0];
  
  num number = recordId;
  StringBuffer buffer = new StringBuffer(); 
 
  while ( number > 0){
    buffer.write(chars[number % base]);
    number = number ~/ base;
  }
  
  return buffer.toString().split('').reversed.join('');
}

num decode(String shortUrl){
  num i = 0;
  
  for ( int x = 0; x < shortUrl.length; x++){
    var c = shortUrl[x];
    i = i * base + chars.indexOf(c);
  }
  return i;
}
