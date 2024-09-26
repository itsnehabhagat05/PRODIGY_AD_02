import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  addtasktofirebase() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  if (user != null) {
    String uid = user.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
          'title': titleController.text,
          'description': descriptionController.text,
          'time': time.toString(),
          'timestamp': time,
        });
    Fluttertoast.showToast(msg: 'Data Added');
  } else {
    // Handle the case when there is no authenticated user
    // You can show an error message or take other appropriate action
    print('No authenticated user');
  }
}
  




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 2, 20, 27),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color(0xFFf72585),
        title: Text('New Task',style: GoogleFonts.roboto(),),
      ),
      body: Container(
        
        
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(child:
              ListView(children: [
                TextField(
                  controller: titleController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tittle',
                    hintStyle: TextStyle(color: Colors.grey,
                    fontSize: 30), 
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  maxLines: 130,
                  controller: descriptionController,
                  style: TextStyle(
                    color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something here',
                    hintStyle: TextStyle(color: Colors.grey), 
                  ),
                ),
              
                
              ],)),
            
            // Container(
            //   child:TextField(
            //     decoration: InputDecoration(
            //       label: Text('Enter Tittle'),
            //       border: OutlineInputBorder()
            //     ),
            //   ) ,
            // )
            ElevatedButton(
            style: ButtonStyle(backgroundColor:
              MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return Color.fromARGB(255, 234, 95, 157);
                  return Color.fromARGB(255, 234, 95, 157);
                },
              ),
            ),
            child: Text('Add Task',style: GoogleFonts.roboto(fontSize: 18),),

            onPressed: () {
              addtasktofirebase();
              
            },
          ),
                    
              

          ],
          

          
        ),

      ),
      



    );
  }
}