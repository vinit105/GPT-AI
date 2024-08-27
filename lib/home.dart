import 'package:flutter/material.dart';
import 'package:gpt_ai/network_model/network_request.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _query = TextEditingController();
  String _answer ='';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GPT'),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        backgroundColor: Colors.grey.shade700,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(8.0),
                children: [
                  Text(_answer,),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8.0,0.0,10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey,
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _query,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,

                          ),
                          decoration: InputDecoration(
                            hintText: 'Ask Anything',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w300
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                loading?const CircularProgressIndicator():
                IconButton(onPressed: () {
                  _sendRequest();
                  
                }, icon: const Icon(Icons.send_rounded,color: Colors.white,size: 40,),)
              ],
            )
          ],
        ),
    );
  }


  _sendRequest()  async{
    setState(() {
      loading = true;
    });

    final result = await ApiClient.postRequest(message: _query.text);
    setState(() {
      loading = false;
    });
    if(result != null){
      setState(() {
      _answer = result;
      _query.clear();

      });
    }
  }


}
