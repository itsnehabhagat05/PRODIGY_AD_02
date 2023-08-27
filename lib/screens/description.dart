import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  final String title;
  final String description;


  const Description({
    Key? key,
    required this.title,required this.description,
  }) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 2, 20, 27),
      

      appBar: AppBar(
        backgroundColor: Color(0xFFf72585),

        title:Text('Description'),
      ),
      body: ListView(
        
        children: [
          Card(
          margin: EdgeInsets.only(top: 20,left: 20,right: 20),
          color: Colors.grey.shade900,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
          child: Container(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [    
              Center(
                child: Container(
                  
                  margin: EdgeInsets.all(10),
                  child: Text(
                    title,
                    style:GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                    ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  description,
                  style:GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20,
                    ),
                  ),
              ),
              
              
            ],
          ),
          ),
            
        ),]
      ),
      );
  }
}
