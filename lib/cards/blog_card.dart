import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_fit/cards/audio_player_card.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/widgets/file_video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';
import 'blog_pdf.dart';

class BlogCard extends StatefulWidget {
  BlogCard(
      {this.file = '',
      this.name,
      this.time,
      this.post,
      this.type,
      this.id,
      this.like,
      this.likeNo,
      this.onTap,
      this.onLikeTap,
      this.favourite,
      this.profile});
  final String name;
  final String profile;
  final String time;
  final String post;
  final String file;
  final String id;
  final String likeNo;
  final bool like;
  final int type;
  final bool favourite;
  final Function onTap;
  final Function onLikeTap;
  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 8,
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 8),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          child: widget.profile == null || widget.profile == '' ? Image.asset('assets/images/user.png', width: 35, height: 35, fit: BoxFit.fill) :
                          FadeInImage.assetNetwork(placeholder: 'assets/images/user.png', image: widget.profile, width: 35, height: 35, fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            widget.name,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: ColorRefer.kDarkColor,
                                  fontFamily: FontRefer.OpenSans,
                              )
                            ),
                            Text(
                                widget.time,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorRefer.kDarkColor,
                                  fontFamily: FontRefer.OpenSans,
                                )),
                          ],
                        )
                      ],
                    ),
                    InkWell(
                      onTap: widget.onTap,
                      child: Container(
                        child: widget.favourite == true ? Icon(
                          CupertinoIcons.bookmark_fill,
                          color: ColorRefer.kRedColor,
                          size: 20,
                        ) : Icon(
                          CupertinoIcons.bookmark,
                          color: ColorRefer.kLightGreyColor,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: widget.post.isEmpty ? false : true,
                child: Html(
                  data: widget.post,
                  style: {
                    "p": Style(
                      width: MediaQuery.of(context).size.width, fontSize: FontSize.medium,
                      color: Colors.black, margin: EdgeInsets.fromLTRB(5, 0, 5, 0) , padding: EdgeInsets.all(0)
                    ),
                    "div": Style(
                        width: MediaQuery.of(context).size.width, fontSize: FontSize.medium,
                        color: Colors.black, margin: EdgeInsets.fromLTRB(5, 0, 5, 0), padding: EdgeInsets.all(0)
                    ),
                  },
                  onLinkTap: (url, context, map, element) async{
                    assert(url != null);
                    if (!await launch(url)) throw 'Could not launch $url';
                  },
                ),
              ),
              Visibility(
                visible: widget.type == 1 ? true : false,
                child: Container(
                    padding: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 12),
                    child: InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              insetPadding: EdgeInsets.only(top: 30, left: 0, right: 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight:  Radius.circular(10))
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText('Preview', style: TextStyle(fontSize: 15, color: Colors.black),),
                                          InkWell(
                                            onTap: (){
                                              Navigator.pop(context);
                                            },
                                            child: Icon(Icons.close, color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight:  Radius.circular(10))
                                      ),
                                      padding: EdgeInsets.only(bottom: 30),
                                      child: FadeInImage.assetNetwork(
                                          height: MediaQuery.of(context).size.width,
                                          placeholder: 'assets/images/placeholder.jpg',
                                          image: widget.file == null ? '' : widget.file, fit: BoxFit.cover),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.jpg',
                        image: widget.file == null ? '' : widget.file,
                        width: MediaQuery.of(context).size.width,
                      ),
                    )),
              ),
              Visibility(
                visible: widget.type == 2 ? true : false,
                child: Container(
                  padding: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
                  child: FileVideoPlayer(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2,
                    loaderPadding: EdgeInsets.all(120),
                    buttonPadding: EdgeInsets.only(
                      top: 80,
                      left: MediaQuery.of(context).size.width / 2.7,
                    ),
                    file: widget.file,
                    messageId: widget.id,
                  ),
                ),
              ),
              Visibility(
                visible: widget.type == 3 ? true : false,
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: AudioPlayerCard(
                    file: widget.file,
                    id: widget.id,
                  ),
                ),
              ),
              Visibility(
                visible: widget.type == 4 ? true : false,
                child: InkWell(
                  onTap: (){
                    Constants.pdfPath = widget.file;
                    Constants.pdfID = widget.id;
                    Navigator.pushNamed(context, PDFCard.ID);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xffD5D7DA),
                      ),
                      margin: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.filePdf, color: Colors.red, size: 40,),
                          SizedBox(width: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 12),
                            child: Text('PDF File', style: TextStyle(fontSize: 16, color: ColorRefer.kDarkColor, fontFamily: FontRefer.OpenSans),
                            ),
                          )
                        ],
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only( left: 14, right: 14),
                child: Divider(color: ColorRefer.kLightGreyColor),
              ),

              Container(
                padding: EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: widget.onLikeTap,
                      child: Container(
                          child: widget.like == false ? Icon(CupertinoIcons.heart, size: 25, color: ColorRefer.kLightGreyColor) :
                          Icon(CupertinoIcons.heart_fill, size: 25, color: Colors.red),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(widget.likeNo == '0' ? '' : widget.likeNo, style: TextStyle(color:ColorRefer.kLightGreyColor))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LiveStreamCard extends StatefulWidget {
  LiveStreamCard({this.name, this.image});
  final String image;
  final String name;
  @override
  _LiveStreamCardState createState() => _LiveStreamCardState();
}

class _LiveStreamCardState extends State<LiveStreamCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height/3.8,
      width: width/2.5,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: AssetImage(widget.image),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 30),
          Center(
            child: SvgPicture.asset('assets/icons/play_video.svg'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.name,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontFamily: FontRefer.OpenSans,
                  )),
              Center(
                child: SvgPicture.asset(
                  'assets/icons/live_stream.svg',
                  height: 15,
                  width: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
