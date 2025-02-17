import 'package:flutter/material.dart';
import 'package:t_fit/widgets/round_button.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';


class ChatTab extends StatefulWidget {
  ChatTab({this.name, this.image, this.onTap, this.status, this.job});
  final Function onTap;
  final String name;
  final String job;
  final String image;
  final int status;
  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: ColorRefer.kDarkColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: widget.image == null ?
              Image.asset('assets/images/user.png', width: 35, height: 35, fit: BoxFit.fill) :
              FadeInImage.assetNetwork(placeholder: 'assets/images/user.png', image: widget.image, width: 35, height: 35, fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(5),
            ),
            SizedBox(width: 14),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.job == 'admin' ? 'Support Team' : widget.job.capitalize(),
                        style: TextStyle(
                          fontSize: 15,
                          color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                          fontFamily: FontRefer.OpenSans,
                        ),
                      ),
                      Icon(Icons.circle, color: widget.status == 0 ? Colors.orange : Colors.green, size: 12,)
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                      widget.job == 'admin' ? 'T-Fit' : widget.name.capitalize(),
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                        fontFamily: FontRefer.OpenSans,
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectChatTab extends StatefulWidget {
  SelectChatTab({this.name, this.image, this.onTap, this.status, this.job});
  final Function onTap;
  final String name;
  final String job;
  final String image;
  final int status;
  @override
  _SelectChatTabState createState() => _SelectChatTabState();
}

class _SelectChatTabState extends State<SelectChatTab> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(bottom: BorderSide(color: ColorRefer.kDarkColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: widget.image == null ?
            Image.asset('assets/images/user.png', width: 35, height: 35, fit: BoxFit.fill) :
            FadeInImage.assetNetwork(placeholder: 'assets/images/user.png', image: widget.image, width: 35, height: 35, fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(5),
          ),
          SizedBox(width: 14),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.job == 'admin' ? 'Support Team' : widget.job.capitalize(),
                      style: TextStyle(
                        fontSize: 15,
                        color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                        fontFamily: FontRefer.OpenSans,
                      ),
                    ),
                    SubmitButton(
                      colour: ColorRefer.kRedColor,
                      width: 80,
                      height: 30,
                      title: 'Select',
                      buttonRadius: 15,
                      onPressed: widget.onTap,
                    )
                  ],
                ),
                Text(
                    widget.job == 'admin' ? 'T-Fit' : widget.name.capitalize(),
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                      fontFamily: FontRefer.OpenSans,
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  function() async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
      return ;
    }
    );
  }
}
