import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../FirebaseCloud/CloudHelper.dart';
import '../Model/noteModel.dart';
import '../Utils/AppUtils.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create Note"),
        backgroundColor: const Color(0xff0CC0DF),
        actions: [ IconButton(
          icon: const Icon(
            Icons.done,
            color: CupertinoColors.white,
            size: 30,
          ),
          onPressed: () {
            var note = Note(
                title: AppUtil.titleController.text,
                description: AppUtil.descController.text);
            print(AppUtil.titleController.text);
            CloudHelper.instance.insertData(note);
            AppUtil.titleController.clear();
            AppUtil.descController.clear();
            Navigator.of(context).pop();
          },
        ),],
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
            padding: const EdgeInsets.all(8.0),
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
      backgroundColor: CupertinoColors.white,
    );
  }
}
