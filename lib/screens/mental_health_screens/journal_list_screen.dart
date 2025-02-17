import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:t_fit/screens/mental_health_screens/write_journal_screen.dart';
import 'package:t_fit/utils/colors.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/fonts.dart';
import 'package:t_fit/utils/style.dart';
import 'package:t_fit/widgets/time_ago.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class JournalScreen extends StatefulWidget {
  static const String ID = "/journal_list_screen";
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<String> listOfJournal = [];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('dd-MM-yyyy h:mma');
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        centerTitle: true,
        title: Text(
          'Journal Lists',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Constants.journalList == null || Constants.journalList.length == 0
                    ? Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 1.8,
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
                            'No Journal to show',
                            style: TextStyle(
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                                fontFamily: FontRefer.OpenSans,
                                fontSize: 20),
                          )
                        ],
                      ),
                ) : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: Constants.journalList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return JournalCard(
                          detail: Constants.journalList[index].text,
                          type: Constants.journalList[index].title,
                          date:TimeAgo.timeAgoSinceDate(formatter.format(Constants.journalList[index].createdAt.toDate()), true),
                          onEditClick: (){
                            Navigator.pushNamed(context, WriteDiaryScreen.ID, arguments: [true, Constants.journalList[index]]);
                          },
                        );
                      }
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class JournalCard extends StatefulWidget {
  JournalCard({this.onEditClick, this.date, this.detail, this.type});
  final Function onEditClick;
  final String detail;
  final String type;
  final String date;

  @override
  _JournalCardState createState() => _JournalCardState();
}

class _JournalCardState extends State<JournalCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return InkWell(
      onTap: widget.onEditClick,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: theme.lightTheme == true ?  ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: ListTile(
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.type,
                style: TextStyle(
                    color: theme.lightTheme == true ? Colors.black54 : ColorRefer.kGreyColor,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontRefer.OpenSans,
                    height: 1.5),
              ),
              Text(
                widget.date,
                style: TextStyle(
                  color: ColorRefer.kTextColor, fontSize: 10.0, fontFamily:  FontRefer.OpenSans,),
              ),
            ],
          ),
          subtitle: Padding(
            padding:  EdgeInsets.only(top: 10),
            child: Text(
              widget.detail.substring(0, 30) + '...' ?? "",
              style: TextStyle(
                color: theme.lightTheme == true ? Colors.black54: Colors.white,
                fontSize: 11.0,
                fontFamily:  FontRefer.OpenSans,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
    );
  }
}
