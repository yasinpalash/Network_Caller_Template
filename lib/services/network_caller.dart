
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
class NetworkCaller{
  //get methods

  Future<dynamic> getMethod(String url)async{

    try{
      final http.Response response= await http.get(Uri.parse(url),headers:{
        'Content-type':'application/json'
      } );

      if(response.statusCode==200){
        return jsonDecode(response.body);
      }else if(response.statusCode==401){
        log('Error');
      }
      
    }catch(e){
     log("error: $e");
    }
  }


  Future<dynamic> postMethod(String url ,{Map<String,String>? body}) async {


    
    try{
      final http.Response response=await http.post(Uri.parse(url),headers: {
        'Content-type':'application/json'
        
      },body: jsonEncode(body));
      
      if(response.statusCode==200){
        return jsonDecode(response.body);
      }else if(response.statusCode==401){
        log('Error: UnAuthorize');
      }
    }catch(e){
      log('Error: $e');
    }
  }

}