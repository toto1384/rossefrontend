import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rosse/icon_pack_icons.dart';
import 'package:rosse/objects/action.dart';
import 'package:rosse/utils/date_utils.dart';
import 'package:rosse/utils/get_popup_and_sheets_utils.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';
import 'package:rosse/utils/utils.dart';
import 'package:rosse/utils/values_utils.dart';
import 'package:soundpool/soundpool.dart';

import '../../main.dart';

class RosseActionWidget extends StatefulWidget {
  final int index ;
  final RosseAction action;
  final Function(RosseAction) onActionUpdated;
  final Soundpool soundpool;
  final List<Interest> interests;
  final Function(int,bool) onAnimationCompleted;
  final Function onActionHided;

  RosseActionWidget({Key key,this.index,@required this.onActionHided,@required this.action,@required this.onActionUpdated,this.soundpool,@required this.interests,this.onAnimationCompleted}) : super(key: key);

  @override
  _RosseActionWidgetState createState() => _RosseActionWidgetState();
}

class _RosseActionWidgetState extends State<RosseActionWidget> {
  @override
  Widget build(BuildContext context) {
    bool showMore = widget.action.tldr==''?true:false;
    return getPadding(
          Card(
            color: MyColors.color_primary_lighter,
            shape: getShape(),
            child: Container(
              height: 60,
              child: Stack(
                children:<Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topRight: Radius.circular(15)),
                      child: SvgPicture.asset((widget.index??0).isOdd?AssetsPath.actionStain1:AssetsPath.actionStain2,height: 60,)
                    ),
                  ),
                  Center(
                    child: ListTile(
                      leading: Visibility(
                        visible: widget.soundpool!=null,
                        child: getFlareCheckbox(widget.action.checked,
                          onTap: (){
                            //
                            DateTime dateTime ;
                            setState(() {

                              if(widget.action.checked!=true){
                                playTick(widget.soundpool);
                                dateTime=DateTime.now();
                              }

                            });
                            RosseAction newAction = widget.action;
                            newAction.checked=!newAction.checked;
                            newAction.lastChecked=getStringFromDate(dateTime);

                            widget.onActionUpdated(newAction);

                          },
                          onCallbackCompleted: (val){
                            if(widget.onAnimationCompleted!=null){
                              widget.onAnimationCompleted(widget.index,val);
                            }
                          }
                        ),
                      ),
                      title: getText(widget.action.name,color: MyColors.color_black,maxLines: 3),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          getText('${widget.action.getImprovement(interests: widget.interests).toStringAsFixed(1)}%',color: MyColors.color_black, textType: TextType.textTypeSubNormal),
                          getPadding(getIcon(widget.action.getIcon(),color: MyColors.color_black,size: 12),),
                        ],
                      ),
                      onTap: (){
                        if(widget.soundpool!=null)showDistivityModalBottomSheet(context, (ctx,ss){
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)
                                    ),
                                    child: SvgPicture.asset(widget.action.getTypeIllustration(),height: getIllustrationHeight(context),)
                                  ),
                                  Positioned(
                                    child: getIcon(widget.action.getIcon(),color: Colors.white),
                                    bottom: 10,
                                    left: 10,
                                  )
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: getPadding(getText(widget.action.name,textType: TextType.textTypeSubtitle,maxLines: 5,isCentered: true),vertical: 12),
                                ),
                              ),
                              getPadding(Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        getPadding(getColorPrimaryContainer(getText('${widget.action.getImprovement(interests: widget.interests).toStringAsFixed(1)}% increase',textType: TextType.textTypeSubNormal,color: Colors.white),),),
                                        getPadding(getColorPrimaryContainer(getText(widget.action.getTypeText(),textType: TextType.textTypeSubNormal,color: Colors.white),),),
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton(
                                    child: getIcon(IconPack.dots_vertical),
                                    itemBuilder: (ctx){
                                      return <PopupMenuEntry>[
                                        PopupMenuItem(
                                          value: 0,
                                          child: ListTile(
                                            leading: getIcon(IconPack.close),
                                            title: getText(MyApp.isEnglish?'This doesn\'t work for me':'Nu functioneaza pentru mine'),
                                          ),
                                        ),
                                      ];
                                    },
                                    onSelected: (v){
                                      switch(v){
                                        case 0 : 
                                          showDistivityDialog(
                                            context, 
                                            actions: [
                                              getButton(MyApp.isEnglish?'Try it for a few more days': 'Incearca inca cateva zile', onPressed: ()=>Navigator.pop(context),variant: 2),
                                              getButton(MyApp.isEnglish?'Hide it':'Ascunde', onPressed: (){
                                                Navigator.pop(context);
                                                widget.onActionHided();
                                              }),
                                            ], 
                                            title: MyApp.isEnglish?'Hide action':'Ascunde actiunea',
                                            stateGetter: (ctx,ss){
                                              return getText('Usually the benefits from doing a '
                                                  'habit come after you\'ve done it for some time. This can mean '
                                                  'even a month for some habits. \n\nAlso please make sure that'
                                                  ' you\'ve done this action correctly and with our guidance '
                                                  'from the \'How to do it\' section. \n\nYou can always'
                                                  ' unhide this action from the settings. ');
                                            }
                                          );
                                          break;
                                      }
                                    },
                                  ),
                                ],
                              )),
                              getPadding(Divider()),
                              Visibility(
                                visible: widget.action.tldr!='',
                                child: getPadding(getRichText(['T.L.D.R: ',widget.action.tldr], [TextType.textTypeSubtitle,TextType.textTypeNormal]),
                                  horizontal: 12
                                ),
                              ),

                              Visibility(
                                visible: widget.action.why!=''&&showMore,
                                child: getPadding(getRichText([MyApp.isEnglish?'Why? ': 'De ce? ',widget.action.why], [TextType.textTypeSubtitle,TextType.textTypeNormal],),horizontal: 12),
                              ),

                              Visibility(
                                visible: widget.action.howToDoIt!=''&&showMore,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 25,right: 12,left: 12,top: 8),
                                  child: getRichText([MyApp.isEnglish?'How to do it? ':'Cum se face? ',widget.action.howToDoIt], [TextType.textTypeSubtitle,TextType.textTypeNormal],),
                                ),
                              ),

                              Visibility(
                                visible: widget.action.tldr!='',
                                child: getPadding(getButton(
                                  showMore?MyApp.isEnglish?'Show less':'Arata mai putin':MyApp.isEnglish?'Show more':'Arata mai mult',
                                  variant: 2, 
                                  onPressed: (){
                                    ss(() {
                                      showMore=!showMore;
                                    });
                                  }
                                )),
                              ),
                            ],
                          );
                        },hideHandler: true);
                      },
                ),
                  ),
                ]
              ),
            ),
          ),
        horizontal: 5,vertical: 5);
  }

  getIllustrationHeight(BuildContext context) {
    return MediaQuery.of(context).size.width/16*9;
  }
}