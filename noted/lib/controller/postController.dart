import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:noted/model/neo4j/createRelationship.dart';
import 'package:noted/view/post/postNotes.dart';
import 'package:noted/view/post/postArticles.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:noted/model/neo4j/createNode.dart';

class PostController extends ControllerMVC {
  factory PostController() => _this ??= PostController._();
  PostController._();
  static PostController? _this;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late String fileName = '';
  List<Map<String, dynamic>> pdfData = [];

  void navigate(int index, BuildContext context) async {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PostNotes()),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PostArticles(),
        ),
      );
    }
  }

  Future<String> uploadPDF(String fileName, File file) async {
    final reference =
        FirebaseStorage.instance.ref().child("pdfs/$fileName.pdf");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() => {});
    final downloadLink = await reference.getDownloadURL();
    return downloadLink;
  }

  Future<FilePickerResult?> pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    return pickedFile;
  }

  Future<void> notesUpload(
      FilePickerResult pickedFile, String? selectedModuleCode, String email) async {
    String fileName = pickedFile.files[0].name;
    File file = File(pickedFile.files[0].path!);

    final downloadLink = await uploadPDF(fileName, file);

    await _firebaseFirestore.collection("pdfs").add({
      "name": fileName,
      "url": downloadLink,
    });
    await createNotesNode(fileName, downloadLink);
    connectCourseToNotes(selectedModuleCode!, downloadLink);
    connectNotesToAuthor(downloadLink, email);

    print("PDF Uploaded Successfully!");
  }

  void articleUpload(
      FilePickerResult pickedFile, String title, String summary) async {
    String fileName = pickedFile.files[0].name;
    File file = File(pickedFile.files[0].path!);

    final downloadLink = await uploadPDF(fileName, file);

    await _firebaseFirestore.collection("pdfs").add({
      "name": fileName,
      "url": downloadLink,
    });
    createArticleNode(title, summary, downloadLink);

    print("PDF Uploaded Successfully!");
  }
}
