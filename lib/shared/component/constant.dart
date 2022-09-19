// post
// Update
//  Delete
// Get

// http://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
// base url :  http://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'component.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFInish(context, LoginScreen());
  });
}

// this method used to get all data when data is so big
void printFullText(String text) {
  // ignore: non_constant_identifier_names
  final Pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  // ignore: avoid_print
  Pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = CacheHelper.getData(key: 'token');
