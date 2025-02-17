import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/controllers/blogs_controller.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:t_fit/models/user_model/blog_model.dart';
import 'package:t_fit/utils/fonts.dart';
import '../../cards/blog_card.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/style.dart';
import 'package:intl/intl.dart';
import '../../widgets/time_ago.dart';

class BlogFavoritesScreen extends StatefulWidget {
  static const String ID = "/blog_favorites_screen";
  @override
  _BlogFavoritesScreenState createState() => _BlogFavoritesScreenState();
}

class _BlogFavoritesScreenState extends State<BlogFavoritesScreen> {
  List<BlogModel> blogList = [];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    var formatter = new DateFormat('dd-MM-yyyy h:mma');
    return Scaffold(
        backgroundColor:  theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'Favorites',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('blogs').where('favorites', arrayContains: AuthController.currentUser.uid).snapshots(),
                  builder: (context, snapshot) {
                    blogList.clear();
                    if(snapshot.hasData) {
                      List data = snapshot.data.docs;
                      for(var value in data){
                        DocumentSnapshot blogObject = value;
                        BlogModel object = BlogModel.fromMap(blogObject.data());
                        blogList.add(object);
                      }
                      blogList.sort((a, b) => a.time.toDate().compareTo(b.time.toDate()));
                    }
                    return  blogList == null || blogList.length == 0
                      ? Container(
                          alignment: Alignment.center,
                          height:
                          MediaQuery.of(context).size.height / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.square_list,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                                size: 50,
                              ),
                              SizedBox(height: 6),
                              AutoSizeText(
                                'No Blogs to show',
                                style: TextStyle(
                                    color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                                    fontFamily: FontRefer.OpenSans,
                                    fontSize: 20),
                              )
                            ],
                          ),
                      ) :
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: blogList.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool favorites = blogList[index].favorites.contains(AuthController.currentUser.uid);
                          bool like = false;
                          String likeNo = '';
                          if(blogList[index].likes != null){
                            like = blogList[index].likes.contains(AuthController.currentUser.uid);
                            likeNo = blogList[index].likes.length.toString();
                          }
                          return  Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: BlogCard(
                              name: blogList[index].name,
                              time: TimeAgo.timeAgoSinceDate(
                                  formatter.format(blogList[index].time.toDate()), true),
                              profile: blogList[index].profileImage,
                              post: blogList[index].post,
                              file: blogList[index].file,
                              type: blogList[index].type,
                              id: blogList[index].id,
                              favourite: favorites,
                              like: like,
                              likeNo: likeNo,
                              onLikeTap: (){
                                setState(() {
                                  if(like == false){
                                    like = true;
                                    if(blogList[index].likes == null) blogList[index].likes = [];
                                    blogList[index].likes.add(AuthController.currentUser.uid);
                                    BlogsController.likeBlog(AuthController.currentUser.uid, blogList[index].id);
                                  }else{
                                    like = false;
                                    blogList[index].likes.remove(AuthController.currentUser.uid);
                                    BlogsController.unLikeBlog(AuthController.currentUser.uid, blogList[index].id);
                                  }
                                });
                              },
                              onTap: (){
                                setState(() {
                                  if(favorites == true){
                                    print(favorites);
                                    favorites = false;
                                    BlogsController.removeFavoriteBlog(AuthController.currentUser.uid, blogList[index].id);
                                    Constants.blogList.forEach((element) {
                                      if(element.id == blogList[index].id){
                                        element.favorites.remove(AuthController.currentUser.uid);
                                      }
                                    });
                                    blogList.remove(blogList[index]);
                                    return;
                                  }
                                });
                              },
                            ),
                          );
                      });
                  }
                ),
              ],
            ),
          ),
        ));
  }
}
