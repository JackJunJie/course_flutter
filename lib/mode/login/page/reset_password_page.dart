
import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/res/styles.dart';
import 'package:courseflutter/util/toast.dart';
import 'package:courseflutter/util/utils.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:courseflutter/widgets/my_button.dart';
import 'package:courseflutter/widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';


///忘记密码
class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  //定义一个controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _isClick = false;
  
  @override
  void initState() {
    super.initState();
    //监听输入改变  
    _nameController.addListener(_verify);
    _vCodeController.addListener(_verify);
    _passwordController.addListener(_verify);
  }

  void _verify() {
    String name = _nameController.text;
    String vCode = _vCodeController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }
  
  void _reset() {
    Toast.show('确认......');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: '忘记密码',
        ),
        body: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
          child: _buildBody(),
        ) : SingleChildScrollView(
          child: _buildBody(),
        )
    );
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Gaps.vGap16,
          MyTextField(
            focusNode: _nodeText1,
            config: Utils.getKeyboardActionsConfig(context, [_nodeText1, _nodeText2, _nodeText3]),
            controller: _nameController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: '请输入手机号',
          ),
          Gaps.vGap8,
          MyTextField(
            focusNode: _nodeText2,
            controller: _vCodeController,
            keyboardType: TextInputType.number,
            getVCode: () {
              return Future.value(true);
            },
            maxLength: 6,
            hintText: '请输入验证码',
          ),
          Gaps.vGap8,
          MyTextField(
            focusNode: _nodeText3,
            isInputPwd: true,
            controller: _passwordController,
            maxLength: 16,
            keyboardType: TextInputType.visiblePassword,
            hintText: '请输入密码',
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            onPressed: _isClick ? _reset : null,
            text: '确认',
          )
        ],
      ),
    );
  }
}
