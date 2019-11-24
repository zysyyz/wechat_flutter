import 'package:dim_example/config/contacts.dart';
import 'package:dim_example/im/message_handle.dart';
import 'package:dim_example/tools/wechat_flutter.dart';
import 'package:dim_example/ui/item/chat_voice.dart';
import 'package:flutter/material.dart';

class ChatDetailsRow extends StatefulWidget {
  final GestureTapCallback voiceOnTap;
  final bool isVoice;
  final LayoutWidgetBuilder edit;
  final Widget more;
  final String id;
  final int type;

  ChatDetailsRow({
    this.voiceOnTap,
    this.isVoice,
    this.edit,
    this.more,
    this.id,
    this.type,
  });

  ChatDetailsRowState createState() => ChatDetailsRowState();
}

class ChatDetailsRowState extends State<ChatDetailsRow> {
  String path;

  @override
  void initState() {
    super.initState();

    Notice.addListener(WeChatActions.voiceImg(), (v) {
      if (!v) return;
      if (!strNoEmpty(path)) return;
      sendSoundMessages(
        widget.id,
        path,
        2,
        widget.type,
        (value) => debugPrint('语音发送成功:$path'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
        height: 50.0,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Color(AppColors.ChatBoxBg),
          border: Border(
            top: BorderSide(color: lineColor, width: Constants.DividerWidth),
            bottom: BorderSide(color: lineColor, width: Constants.DividerWidth),
          ),
        ),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new InkWell(
              child: new Image.asset('assets/images/chat/ic_voice.webp',
                  width: 25, color: mainTextColor),
              onTap: () {
                if (widget.voiceOnTap != null) {
                  widget.voiceOnTap();
                }
              },
            ),
            new Expanded(
              child: new Container(
                margin: const EdgeInsets.only(
                    top: 7.0, bottom: 7.0, left: 8.0, right: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: widget.isVoice
                    ? new ChatVoice(
                        voiceFile: (path) {
                          setState(() => this.path = path);
                        },
                      )
                    : new LayoutBuilder(builder: widget.edit),
              ),
            ),
            new InkWell(
              child: new Image.asset('assets/images/chat/ic_Emotion.webp',
                  width: 30, fit: BoxFit.cover),
              onTap: () {},
            ),
            widget.more,
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
