import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../FirebaseCloud/CloudHelper.dart';
import '../Model/noteModel.dart';
import '../Utils/AppUtils.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    int i = ModalRoute.of(context)!.settings.arguments as int;
    WidgetsBinding.instance.addPostFrameCallback((_){
      AppUtil.titleController.text = AppUtil.noteList[i]['title'];
      AppUtil.descController.text = AppUtil.noteList[i]['description'];
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff0CC0DF),
        actions: [IconButton(
          icon: const Icon(
            Icons.done,
            color: CupertinoColors.white,
            size: 30,
          ), onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, 'HomePage', (route) => false);
          Note note = Note(title: AppUtil.titleController.text, description: AppUtil.descController.text);
          CloudHelper.instance.updateData(index: i, noteData: note);
          AppUtil.titleController.clear();
          AppUtil.descController.clear();
        },),],
        title: Text("Edit Note",style: GoogleFonts.acme(
          fontSize:20,
          fontWeight: FontWeight.w700,
        ),),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: AppUtil.titleController,
              style: GoogleFonts.alice(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0CC0DF), width: 1.5),
                ),
                hintText: "Title",
                hintStyle: GoogleFonts.acme(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: AppUtil.descController,
              style: GoogleFonts.acme(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              maxLines: 20,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0CC0DF), width: 2),
                ),
                fillColor: Colors.black12,
                filled: true,
                contentPadding: const EdgeInsets.all(20),
                hintText: "Description",
                hintStyle: GoogleFonts.acme(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: CupertinoColors.black)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}