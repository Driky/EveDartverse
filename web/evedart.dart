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
    return this.executeRequest(this.url, this.parameters);
  }
}

class RequestManager{
  RequestManager(){
    
  }
  
  executeRequest(String request, Map arguments){
    String requestResult = null;
    String fullRequest = request + '?';
    
    arguments.forEach((arg,value) {
      fullRequest += arg + '=' + value + '&';
    });
    
    fullRequest = Uri.encodeFull(fullRequest);
    
    HttpRequest.getString(fullRequest)
      .then((String result) { 
        requestResult = result; })
          .catchError((e) {
            print(e);
          });
    
    return requestResult;
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
