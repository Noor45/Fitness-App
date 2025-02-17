import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/fonts.dart';
import '../utils//colors.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:dropdown_below/dropdown_below.dart';

class InputField extends StatefulWidget {
  InputField(
      {this.label,
      this.controller,
      this.onChanged,
      this.validator,
      this.maxLength,
      this.textInputType});
  final TextEditingController controller;
  final TextInputType textInputType;
  final String label;
  final int maxLength;
  final Function onChanged;
  final Function validator;
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  Color focusColor = ColorRefer.kGreyColor;
  final _focusNode = FocusNode();
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus == false) {
        setState(() {
          focusColor = ColorRefer.kGreyColor;
        });
      } else {
        setState(() {
          focusColor = Colors.black;
        });
      }
    });
  }

  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      child: Column(
          children: [
            TextFormField(
              focusNode: _focusNode,
              controller: widget.controller,
              keyboardType: widget.textInputType,
              validator: widget.validator,
              onChanged: widget.onChanged,
              maxLength: widget.maxLength,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: ColorRefer.kDarkColor,
                  fontSize: 9,
                ),
                counterText: '',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorRefer.kDarkColor)
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor)
                ),
                focusColor: Colors.black,
                contentPadding: EdgeInsets.only(left: 0, top: 3),
                  labelText: widget.label,
                  labelStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: FontRefer.OpenSans,
                      color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
              ),
            ),
      ]),
    );
  }
}


class RoundInputField extends StatefulWidget {
  RoundInputField(
      {this.label,
        this.controller,
        this.onChanged,
        this.validator,
        this.textInputType});
  final TextEditingController controller;
  final TextInputType textInputType;
  final String label;
  final Function onChanged;
  final Function validator;
  @override
  _RoundInputFieldState createState() => _RoundInputFieldState();
}

class _RoundInputFieldState extends State<RoundInputField> {
  Color focusColor = ColorRefer.kGreyColor;
  final _focusNode = FocusNode();
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus == false) {
        setState(() {
          focusColor = ColorRefer.kGreyColor;
        });
      } else {
        setState(() {
          focusColor = Colors.black;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        validator: widget.validator,
        onChanged: widget.onChanged,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: widget.label,
          hintStyle: TextStyle(
            color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusColor: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
          contentPadding: EdgeInsets.only(left: 10, top: 3),
        ),
      ),
    );
  }
}


// ignore: must_be_immutable
class PasswordField extends StatefulWidget {
  PasswordField(
      {this.label,
      this.controller,
      this.onChanged,
      this.validator,
      this.obscureText,
      this.textInputType});
  final TextEditingController controller;
  final TextInputType textInputType;
  final String label;
  final Function onChanged;
  final Function validator;
  bool obscureText;
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  Color focusColor = ColorRefer.kGreyColor;
  final _focusNode = FocusNode();
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus == false) {
        setState(() {
          focusColor = ColorRefer.kGreyColor;
        });
      } else {
        setState(() {
          focusColor = Colors.black;
        });
      }
    });
  }

  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _togglePasswordStatus() {
      setState(() {
        widget.obscureText = !widget.obscureText;
      });
    }
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      child: Column(children: [
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: ColorRefer.kDarkColor,
              fontSize: 9,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorRefer.kDarkColor)
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor)
            ),
            focusColor: Colors.black,
            contentPadding: EdgeInsets.only(left: 0, top: 3),
            labelText: widget.label,
            labelStyle: TextStyle(
                fontSize: 15,
                fontFamily: FontRefer.OpenSans,
                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
            suffixIcon: IconButton(
              icon: Icon(
                  widget.obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: _togglePasswordStatus,
              color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
            ),
          ),
        ),
      ]),
    );
  }
}


class InputDataField extends StatefulWidget {
  InputDataField(
      {this.label,
        this.controller,
        this.onChanged,
        this.validator,
        this.msg = '',
        this.showMsg = false,
        this.width,
        this.maxLength,
        this.textInputType});
  final TextEditingController controller;
  final TextInputType textInputType;
  final String label;
  final String msg;
  final bool showMsg;
  final double width;
  final int maxLength;
  final Function onChanged;
  final Function validator;
  @override
  _InputDataFieldState createState() => _InputDataFieldState();
}

class _InputDataFieldState extends State<InputDataField> {
  Color focusColor = ColorRefer.kGreyColor;
  final _focusNode = FocusNode();
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus == false) {
        setState(() {
          focusColor = ColorRefer.kGreyColor;
        });
      } else {
        setState(() {
          focusColor = Colors.black;
        });
      }
    });
  }

  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: widget.width,
            padding: EdgeInsets.only(left: 15, right: 20),
            decoration: BoxDecoration(
              color:  theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: TextFormField(
              focusNode: _focusNode,
              controller: widget.controller,
              keyboardType: widget.textInputType,
              validator: widget.validator,
              onChanged: widget.onChanged,
              onEditingComplete: _focusNode.unfocus,
              maxLength: widget.maxLength,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              style: TextStyle(color: theme.lightTheme == true ? Colors.black54 : Colors.white),
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  hintText: widget.label,
                  counterText: '',
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontFamily: FontRefer.OpenSans,
                      color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
                focusedBorder: InputBorder.none,
                focusColor: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                contentPadding: EdgeInsets.only(left: 10, top: 3),
              ),
            ),
          ),
          Visibility(
            visible: widget.showMsg,
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: AutoSizeText(
                widget.msg,
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                    fontFamily: FontRefer.OpenSans),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectBox extends StatefulWidget {
  SelectBox({this.label, this.selectionList, this.onChanged, this.value});
  final String label;
  final List<String> selectionList;
  final Function onChanged;
  final String value;
  @override
  _SelectBoxState createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  Color focusColor = ColorRefer.kGreyColor;
  final _focusNode = FocusNode();
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus == false) {
        setState(() {
          focusColor = ColorRefer.kGreyColor;
        });
      } else {
        setState(() {
          focusColor = ColorRefer.kDarkColor;
        });
      }
    });
  }

  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 8),
          child: DropdownButton<String>(
            isExpanded: true,
            dropdownColor: theme.lightTheme == true ? Colors.white : Color(0xff28282B),
            value: widget.value,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            icon: Icon(
              Icons.expand_more_outlined,
              color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
            ),
            style: TextStyle(
                color: ColorRefer.kDarkColor, fontFamily: FontRefer.OpenSans),
            hint: Text(
              widget.label,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: FontRefer.OpenSans,
                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white),
            ),
            underline: Container(
              height: 2,
              color: Colors.black12,
            ),
            items: widget.selectionList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white)),
              );
            }).toList(),
          ),
        ),
        Divider(
          color: Colors.white,
          height: 3,
        ),
      ],
    );
  }
}

class SelectData extends StatefulWidget {
  SelectData({this.selectionList, this.onChanged, this.value, this.width});

  final List<String> selectionList;
  final Function onChanged;
  final String value;
  final double width;
  @override
  _SelectDataState createState() => _SelectDataState();
}

class _SelectDataState extends State<SelectData> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      width: widget.width,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: DropdownBelow(
        itemWidth: widget.width,
        itemTextstyle: TextStyle(
            color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white, fontFamily: FontRefer.OpenSans),
        boxTextstyle: TextStyle(
            color: Colors.white, fontFamily: FontRefer.OpenSans),
        boxWidth: widget.width,
        boxHeight: 47,
        dropdownColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBoxColor,
        isDense: true,
        icon: Icon(
          Icons.expand_more_outlined,
          color: theme.lightTheme == true ? Colors.black54 : Colors.white,
        ),
        hint: Text(
          widget.value,
          style: TextStyle(
            fontSize: 14,
            fontFamily: FontRefer.OpenSans,
            color: theme.lightTheme == true ? Colors.black54 : Colors.white),
        ),
        value: widget.value,
        items: widget.selectionList
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: theme.lightTheme == true ? Colors.black54 : Colors.white)),
            );
          }).toList(),
        onChanged: widget.onChanged,
      ),
    );
  }

}


class SelectOption extends StatefulWidget {
  SelectOption({this.selectionList, this.onChanged, this.value, this.hint, this.width, this.get, Key key}) : super(key: key);
  final List<String> selectionList;
  final Function onChanged;
  final String value;
  final String get;
  final String hint;
  final double width;
  @override
  _SelectOptionState createState() => _SelectOptionState();
}

class _SelectOptionState extends State<SelectOption> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      width: widget.width,
      child: DropdownBelow(
        key: widget.key,
        itemWidth: 90,
        itemTextstyle: TextStyle(
            fontFamily: FontRefer.OpenSans, fontSize: 11),
        boxTextstyle: TextStyle(
            fontSize: 11, fontFamily: FontRefer.OpenSans),
        boxWidth: widget.width,
        boxHeight: 15,
        dropdownColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBoxColor,
        isDense: true,
        icon: Icon(
          Icons.arrow_drop_down,
          color: theme.lightTheme == true  ? Color(0xffadadad) : Colors.white,
        ),
        hint: Text(
          '${widget.get}  ${widget.value}',
          style: TextStyle(
            fontSize: 11,
            color: theme.lightTheme == true  ? Color(0xffadadad) : Colors.white,
            fontFamily: FontRefer.OpenSans,),
        ),
        value: '${widget.value}',
        items: widget.selectionList
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text('${widget.get}  $value', style: TextStyle(color: theme.lightTheme == true  ? Color(0xffadadad) : Colors.white,),),
          );
        }).toList(),
        onChanged: widget.onChanged,
      ),
    );
  }

}