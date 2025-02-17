import 'dart:io';
import '../utils/constants.dart';
import '../models/user_model/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class BlogsController{
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /***********************************************
            FUNCTION TO GET BLOGS
   ******************************************////

  static Future<void> getBlogs() async {
    try {
      QuerySnapshot snapShot = await _firestore.collection('blogs').get();
      snapShot.docs.forEach((element) {
        BlogModel blogData = BlogModel.fromMap(element.data());

        Constants.blogList.add(blogData);
      });
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /***********************************************
        FUNCTION TO GET FAVORITE BLOGS
   ******************************************////

  static Future<void> addFavoriteBlog(String userId, String id) async {
    try {
      await _firestore.collection('blogs').doc(id).update({
        'favorites': FieldValue.arrayUnion([userId])
      });
    } on FirebaseException catch (e) {
      print("User update Error: $e");
    }
  }

  /**************************************************
        FUNCTION TO REMOVE USER FAVORITE BLOG
   *********************************************////

  static Future<void> removeFavoriteBlog(String userId, String id) async {
    try {
      await _firestore.collection('blogs').doc(id).update({
        'favorites': FieldValue.arrayRemove([userId])
      });
    } on FirebaseException catch (e) {
      print("User update Error: $e");
    }
  }

  /**************************************************
              FUNCTION TO LIKE BLOG
   *********************************************////

  static Future<void> likeBlog(String userId, String id) async {
    try {
      await _firestore.collection('blogs').doc(id).update({
        'likes': FieldValue.arrayUnion([userId])
      });
    } on FirebaseException catch (e) {
      print("User update Error: $e");
    }
  }

  /**************************************************
              FUNCTION TO UNLIKE BLOG
   *********************************************////

  static Future<void> unLikeBlog(String userId, String id) async {
    try {
      await _firestore.collection('blogs').doc(id).update({
        'likes': FieldValue.arrayRemove([userId])
      });
    } on FirebaseException catch (e) {
      print("User update Error: $e");
    }
  }


}