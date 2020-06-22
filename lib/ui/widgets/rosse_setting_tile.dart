import 'package:flutter/material.dart';
import 'package:rosse/data/data.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';

class RosseSettingTile extends StatefulWidget {

  final ReturnChecked checked;
  final String text;
  final AsyncSnapshot<Data> snapshot;
  final Function(Data,bool) onChange;
  final String info;

  RosseSettingTile({Key key,@required this.checked, @required this.onChange, @required this.snapshot,@required this.text,this.info}) : super(key: key);

  @override
  _RosseSettingTileState createState() => _RosseSettingTileState();
}

class _RosseSettingTileState extends State<RosseSettingTile> {

  bool checked ;

  

  @override
  Widget build(BuildContext context) {

    if(checked==null&&widget.snapshot.hasData){
      checked= widget.checked(widget.snapshot.data);
    }

    return widget.snapshot.hasData?
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getSwitchable(
          text: widget.text, 
          checked: checked, 
          onCheckedChanged: (val){
            setState(() {
              checked=val;
              widget.onChange(widget.snapshot.data,val);
            });
          }, 
          isCheckboxOrSwitch: false
        ),
        Visibility(
          visible: widget.info!=null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: getInfoIcon(widget.info),
          ),
        ),
      ],
    )
    :Center(child: CircularProgressIndicator(),);
  }
}