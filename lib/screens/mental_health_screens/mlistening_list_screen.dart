// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:t_fit/cards/mind_fullness_card.dart';
// import 'package:t_fit/models/mental_health_model/mental_health_model.dart';
// import 'package:t_fit/screens/mental_health_screens/mindfulness_reading.dart';
// import 'package:t_fit/utils/constants.dart';
// import '../../utils/colors.dart';
// import '../../utils/style.dart';
//
// class ReadingListScreen extends StatefulWidget {
//   static const String ID = "/reading_list_screen";
//   @override
//   _ReadingListScreenState createState() => _ReadingListScreenState();
// }
//
// class _ReadingListScreenState extends State<ReadingListScreen> {
//   List<MentalHealthModel> readingBlogList = [];
//   @override
//   void initState() {
//     Constants.mentalHealthBlogList.forEach((element) {
//       if(element.type == 3) readingBlogList.add(element);
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Scaffold(
//         backgroundColor: theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor,
//         appBar: AppBar(
//           elevation: theme.brightness == Brightness.light ? 3 : 0,
//           iconTheme: IconThemeData(color: theme.brightness == Brightness.light ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
//           systemOverlayStyle: theme.brightness == Brightness.light ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
//           centerTitle: true,
//           title: Text(
//             'Mindfulness Reading',
//             style: StyleRefer.kTextStyle.copyWith(color: theme.brightness == Brightness.light ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
//           ),
//         ),
//         body: SafeArea(
//           child: Container(
//             padding: EdgeInsets.only(top: 30, left: 15, right: 15),
//             child: ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: readingBlogList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     margin: EdgeInsets.only(top: 15),
//                     child: ReadingBlogCard(
//                       title: readingBlogList[index].title,
//                       onTap: (){
//                         Constants.mentalHealthBlog = readingBlogList[index];
//                         Navigator.pushNamed(context, MindFullnessReadingScreen.ID);
//                       },
//                       des: readingBlogList[index].description,
//                     ),
//                   );
//                 }),
//           ),
//         )
//     );
//   }
// }