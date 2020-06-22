import 'package:flutter/material.dart';
import 'package:rosse/data/iap.dart';
import 'package:rosse/ui/widgets/rosse_scaffold.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../utils/get_widget_utils.dart';

class IAPScreen extends StatefulWidget {

  IAPScreen({Key key,@required this.iapHelper}) : super(key: key);
  final IAPHelper iapHelper;

  @override
  _IAPScreenState createState() => _IAPScreenState();
}

class _IAPScreenState extends State<IAPScreen> {


  YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: 'qh9czFNGDBc',
      flags: YoutubePlayerFlags(
        autoPlay: false,
      )
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){return Future.value(false);},
      child: RosseScaffold(
        'Try dead simple\nbiohacking for free!',
        isTitleCentered: true,
        primaryItems: <Widget>[
          Container(
            width: double.infinity,
            child: Center(
              child: getText('Summared from 1000+ hours \n of documentation.',maxLines: 3,isCentered: true,textType: TextType.textTypeSubtitle),
            ),
          ),
           getPadding(
              getText('Why Rosse?',textType: TextType.textTypeGigant,isCentered: true),
              vertical: 20,
          ),
          Container(
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:Center()
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Center(
              child : Padding(
                padding: const EdgeInsets.all(20),
                child: getText(
                  'You won’t get a more NO BRAINER way of experiencing the benefits of biohacking(less brain fog, better health, more energy and longevity) than Rosse.',
                  maxLines: 10,textType: TextType.textTypeNormal,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: getText(
                  'YOU can use Rosse for ABSOLUTELY FREE for 14 days. In those 14 days you will get the most ACTIONABLE steps to improve on EXACTLY what benefits YOU want to get from biohacking. Also you can cancel ANYTIME and not be charged a dime.',
                  maxLines: 10,textType: TextType.textTypeNormal,
                ),
              )
            ),
          ),
        ], 
        secondaryItems: [
          getButton(
            'Start 14 days FREE trial',
            onPressed: (){
              widget.iapHelper.purchase(context);
            }
          ),
        ],
        secondaryBodyAsFab: true,
      ),
    );
  }
}