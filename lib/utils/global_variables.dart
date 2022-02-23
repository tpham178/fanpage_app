import 'package:fanpage_flutter/screens/add_post_screen.dart';
import 'package:fanpage_flutter/screens/feed_screen.dart';
import 'package:fanpage_flutter/screens/profile_screen.dart';
import 'package:fanpage_flutter/screens/search-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> homeSreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('Hello3'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
