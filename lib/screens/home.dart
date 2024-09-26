import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/screens/add_task.dart';
import 'package:to_do_app/screens/description.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool? ischecked = false;
  

  getRandomColor(){
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }


  String uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }
  

  

  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 20, 27),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded),
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
            
          },)
        ],
        backgroundColor: Color(0xFFf72585),
        title: Text('Task Manager'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        //color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .doc(uid)
              .collection('mytasks')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var time = (docs[index]['timestamp'] as Timestamp)
                  .toDate();
                  
                
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Description(title: docs[index]['title'],
                      description: docs[index]['description'],),));
                      
                    },
                    
                    child: Card(
                      
                      color: getRandomColor(),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 100,
                        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                
                                  
                                  Container(
                                      margin: EdgeInsets.only(top: 10, left: 20),
                                      child: Text(
                                        docs[index]['title'],
                                        style: GoogleFonts.roboto(fontSize: 18,color: Colors.black),
                                      )),
                                  SizedBox(height: 5,),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      DateFormat.yMd().add_jm().format(time),style: TextStyle(color: Colors.black),),)
                                ]),
                            
                            Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                onPressed: () async {
                                  final result = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),),
                                        backgroundColor: Colors.grey.shade900 ,
                                        icon: Icon(Icons.info,color: Colors.grey,),
                                        title: Text('Are you sure you want to delete ?',
                                        style: TextStyle(color: Colors.white),),
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:Colors.green 
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context,true);
                                            
                                          }, 
                                          child: SizedBox(
                                            width: 60,
                                            child: const Text('Yes',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.white),),
                                          ),),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:Color(0xFFf72585)
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context,false);
                                            
                                          }, 
                                          child: SizedBox(
                                            width: 60,
                                            child: const Text('No',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.white),),
                                          ),)
                                        ]),
                  
                                      );
                                      
                                      
                                    },
                                    );
                  
                                    if(result!=null && result){
                                      await FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc(uid)
                                      .collection('mytasks')
                                      .doc(docs[index]['time'])
                                      .delete();
                  
                                    }
                                  
                                  
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTask(),
              ));
        },
        backgroundColor: Color(0xFFf72585),
      ),
    );
  }
}
