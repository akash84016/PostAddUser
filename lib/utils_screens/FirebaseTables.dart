import 'package:firebase_database/firebase_database.dart';

DatabaseReference database = FirebaseDatabase.instance.reference().child("PostApp");

DatabaseReference categoryListRef = database.child("CategoryList");
DatabaseReference categoryRef = categoryListRef.child("Category");
DatabaseReference subCategoryRef = categoryListRef.child("SubCategory");
DatabaseReference registersRef = database.child("Registers");
DatabaseReference userRef = registersRef.child("Users");
DatabaseReference postsRef = database.child("Posts");
DatabaseReference postsViewsRef = database.child("PostsViews");
