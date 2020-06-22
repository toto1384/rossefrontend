import 'package:flutter/material.dart';
import 'package:rosse/data/data.dart';
import 'package:rosse/icon_pack_icons.dart';
import 'package:rosse/main.dart';
import 'package:rosse/objects/action.dart';
import 'package:rosse/ui/pages/home_page.dart';
import 'package:rosse/ui/widgets/rosse_scaffold.dart';
import 'package:rosse/utils/get_popup_and_sheets_utils.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/utils.dart';

class HidedActionsPage extends StatefulWidget {
  final Data data;
  HidedActionsPage({Key key,@required this.data}) : super(key: key);

  @override
  _HidedActionsPageState createState() => _HidedActionsPageState();
}

class _HidedActionsPageState extends State<HidedActionsPage> {

  List<RosseAction> hidedActions;

  init(){
    if(hidedActions==null){
      hidedActions = List();
      List<int> hidedIds = widget.data.getHidedActions();

      List<RosseAction> allActions = getHardCodedActions(widget.data);

      allActions.forEach((item){
        if(hidedIds.contains(item.id)){
          hidedActions.add(item);
        }
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    init();
    return RosseScaffold(
      MyApp.isEnglish?'Manage hided \n actions':"Administreaza actiunile ascunse",
      primaryItems: hidedActions.length==0?[getGenericEmptyView(MediaQuery.of(context).size.width)]:List<Widget>.generate(hidedActions.length, (ind){
        return ListTile(
          leading: getIcon(hidedActions[ind].getIcon()),
          title: getText(hidedActions[ind].name),
          trailing: getButton(
            MyApp.isEnglish?'Remove':"Sterge",
            onPressed: ()async{
              await widget.data.removeHidedAction(hidedActions.removeAt(ind).id);
              HomePageState.actions=null;
              setState(() {});
            },
            variant: 2
          ),
        );
      }), 
      secondaryItems: [

      ],
      backEnabled: true,
      isTitleCentered: true,
      onMorePressed: (){
        showDistivityModalBottomSheet(context, (ctx,ss){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: getIcon(IconPack.close),
                  title: getText(MyApp.isEnglish?'Remove all actions from the hided list':
                    "Sterge toate actiunile din lista de actiuni ascunse"),
                  onTap: ()async{
                    for(int i = 0 ; i< hidedActions.length ; i++){
                      widget.data.removeHidedAction(hidedActions[i].id);
                    }
                    hidedActions=[];
                    HomePageState.actions=null;
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
      },
    );
  }
}