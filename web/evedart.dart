import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';

@NgController(
    selector: '[accountmanager]',
    publishAs: 'account')
class AccountManager extends RequestManager {
  String url; 
  Map<String, String> parameters;
  
  AccountManager(){
    this.url = "https://api.eveonline.com/account/APIKeyInfo.xml.aspx";
    this.parameters = new Map<String, String>();
    this.parameters = {'keyID' : 'vide',
                       'vCode' : 'vide'};
  }
  
  getInfo(){
    this.executeRequest(this.url, this.parameters);
    return this.requestResult;
  }
}

class RequestManager{
  
  String requestResult = null;
  RequestManager(){
    
  }
  
  void setResult(String res){
    this.requestResult = res;
  }
  
  void executeRequest(String request, Map arguments){
    String fullRequest = request + '?';
    
    arguments.forEach((arg,value) {
      fullRequest += arg + '=' + value + '&';
    });
    
    fullRequest = "http://www.kiwi-corporation.com/driky/eveDartverse/request.php?url=" + Uri.encodeFull(fullRequest);
    print(fullRequest);
    HttpRequest.getString(fullRequest)
      .then((String result) { 
         this.setResult(result);})
          .catchError((e) {
            print(e);
          });
  }
}

class MyAppModule extends Module {
  MyAppModule() {
    type(AccountManager);
  }
}

main() {
  ngBootstrap(module: new MyAppModule());
}
