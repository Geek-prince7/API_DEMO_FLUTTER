import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String responseString='';
  var mappedresp;  
  Future callApi() async{
    http.Response resp;
    resp= await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if(resp.statusCode == 200){
      setState(() {
        responseString=resp.body.toString();
        // print(responseString);
        mappedresp=json.decode(resp.body);
        mappedresp=mappedresp['data'];
        
      });
      
    }
  }
  @override
  void initState() {
    callApi();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:ListView.builder(itemBuilder: (context, index) {
        return Padding(padding:EdgeInsets.all(10.0) ,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              child:Image.network(mappedresp[index]['avatar'].toString())
            ),
            Text(mappedresp[index]['first_name'].toString()+' '+mappedresp[index]['last_name'].toString()),
          ],
          
        )
        );
        
        
      },itemCount: mappedresp==null?0:mappedresp.length,)
      
    
    );
  }
}
