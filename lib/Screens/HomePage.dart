import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../FirebaseCloud/CloudHelper.dart';
import '../Utils/AppUtils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0CC0DF),
        title: const Text(
          "Notes",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Notes').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error : ${snapshot.hasError}");
              return const Text("Something  Wrong!");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator( color:Color(0xff0CC0DF) ,),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    AppUtil.noteList = snapshot.data!.docs;
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xff0CC0DF), width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, 'EditPage',
                            arguments: index);
                      },
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      tileColor: Colors.black12,
                      title: Text(
                        "${AppUtil.noteList[index]['title']}",
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            color: const Color(0xff0CC0DF),
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${AppUtil.noteList[index]['description']}",
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        splashRadius: 25,
                        icon: const Icon(
                          Icons.delete,
                          color:  Color(0xff0CC0DF),
                        ),
                        onPressed: () {
                          CloudHelper.instance.deleteData(index: index);
                        },
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            AppUtil.titleController.clear();
            AppUtil.descController.clear();
          });
          Navigator.of(context).pushNamed('Note');
        },
        backgroundColor: const Color(0xff0CC0DF),
        child: const Icon(Icons.note_alt_outlined),
      ),
    );
  }
}
