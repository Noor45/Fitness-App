import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../controllers/auth_controller.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import '../widgets/input_field.dart';
import '../widgets/round_button.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String ID = "forget_password_screen";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  bool _isLoading = false;

  Future<void> _sendPasswordResetEmail() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    await AuthController().sendPasswordResetEmail(context, _email.toString().trim());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: Theme(
        data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorRefer.kRedColor)),
        child: CircularProgressIndicator(),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          title: Text('Reset Password'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              AutoSizeText(
                'Enter your email below, We will send you password reset email.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: FontRefer.OpenSans,
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: InputField(
                  textInputType: TextInputType.emailAddress,
                  label: 'Email',
                  validator: kEmailValidator,
                  onChanged: (value) => _email = value,
                ),
              ),
              SizedBox(height: 30),
              RoundedButton(
                title: 'Send email',
                buttonRadius: 5,
                colour: ColorRefer.kRedColor,
                height: 40,
                onPressed: () => _sendPasswordResetEmail(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
