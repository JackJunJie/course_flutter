
import 'package:courseflutter/common/common.dart';
import 'package:courseflutter/mode/setting/widgets/exit_dialog.dart';
import 'package:courseflutter/mode/setting/widgets/update_dialog.dart';
import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:courseflutter/widgets/click_item.dart';
import 'package:flustars/flustars.dart' as flutter_stars;
import 'package:flutter/material.dart';


import '../setting_router.dart';


/// design/8设置/index.html
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    String theme = flutter_stars.SpUtil.getString(Constant.theme);
    String themeMode;
    switch(theme) {
      case 'Dark':
        themeMode = '开启';
        break;
      case 'Light':
        themeMode = '关闭';
        break;
      default:
        themeMode = '跟随系统';
        break;
    }

    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '设置',
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
            title: '清除缓存',
            content: '23.5MB',
            onTap: () {}
          ),
          ClickItem(
            title: '夜间模式',
            content: themeMode,
            onTap: () => NavigatorUtils.push(context, SettingRouter.themePage)
          ),
//          ClickItem(
//            title: '检查更新',
//            onTap: () => _showUpdateDialog()
//          ),
          ClickItem(
            title: '关于我们',
            onTap: () => NavigatorUtils.push(context, SettingRouter.aboutPage)
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return UpdateDialog();
        }
    );
  }
}
