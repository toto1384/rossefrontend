import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rosse/icon_pack_icons.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';
import 'package:rosse/utils/values_utils.dart';

class RosseScaffold extends StatefulWidget {
  

  final List<Widget> primaryItems;
  final List<Widget> secondaryItems;
  final String title;
  final bool isTitleCentered;
  final bool secondaryBodyAlwaysRed;
  final bool secondaryBodyAsFab;
  final Function() onMorePressed;
  final bool backEnabled;


  RosseScaffold(this.title,{Key key,this.secondaryBodyAsFab,@required this.primaryItems,@required this.secondaryItems, this.isTitleCentered, this.secondaryBodyAlwaysRed,this.onMorePressed,this.backEnabled}) : super(key: key);

  @override
  _RosseScaffoldState createState() => _RosseScaffoldState();
}

class _RosseScaffoldState extends State<RosseScaffold> {

  

  @override
  Widget build(BuildContext context) {

    return getDeviceWidget(webDesktop: getBigScreen(), webTablet: getBigScreen(), webPhone: getSmallScreen(), mobile: getSmallScreen());
  }

  getBigScreen(){
    return Stack(
      children: <Widget>[
        Expanded(
          child: Container(color: MyColors.color_secondary,)
        ),
        Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset(AssetsPath.backgroundStain),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Card(
                shape: getShape(webCardShape: true),
                color: getOverFlowColor(),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: widget.isTitleCentered??false?MainAxisAlignment.center:MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 75,left: 15,bottom: 15),
                          child: getText(widget.title,textType: TextType.textTypeTitle),
                        ),
                      ],
                    ),
                  ]+ widget.primaryItems,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.secondaryItems,
              ),
            )
          ],
        ),
      ],
    );
  }

  getSmallScreen(){
    List<Widget> smallScreenItems = ((widget.secondaryBodyAlwaysRed??false)||(widget.secondaryBodyAsFab??false))?widget.primaryItems:widget.primaryItems+widget.secondaryItems;

    return Scaffold(
      backgroundColor: MyColors.color_secondary,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.secondaryBodyAsFab??false?Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.secondaryItems,
      ):null,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: Visibility(
                visible: widget.backEnabled??false,
                child: IconButton(
                  icon: getIcon(IconPack.carret_backward,color: Colors.white),
                  onPressed: ()=>Navigator.pop(context),
                ),
              ),
              actions: <Widget>[
                Visibility(
                  visible: widget.onMorePressed!=null&&(!(widget.secondaryBodyAlwaysRed??false)),
                  child: IconButton(
                    icon: getIcon(IconPack.dots_vertical,color: Colors.white),
                    onPressed: widget.onMorePressed,
                  ),
                ),
              ],
              expandedHeight: widget.secondaryBodyAlwaysRed??false?350:100,
              floating: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: widget.isTitleCentered??false,
                  title: widget.secondaryBodyAlwaysRed??false?Text(''):getText(widget.title,textType: TextType.textTypeSubtitle,color: Colors.white,maxLines: 3,isCentered: true),
                  background: Stack(
                    children: <Widget>[
                      Container(
                        color: MyColors.color_secondary,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(AssetsPath.backgroundStain,width: 350,height: widget.secondaryBodyAlwaysRed??false?350:100,),
                        ),
                      ),
                      widget.secondaryBodyAlwaysRed??false?Center(child: Row(mainAxisSize: MainAxisSize.min,children: widget.secondaryItems,),):Container()
                    ],
                  )
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(color: getBackgroundColor(),borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
          child: ListView(
            children: <Widget>[
                widget.secondaryBodyAlwaysRed??false?Row(
                  crossAxisAlignment: widget.isTitleCentered??false?CrossAxisAlignment.center:CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                          visible: widget.backEnabled??false,
                          child: IconButton(
                            icon: getIcon(IconPack.carret_backward),
                            onPressed: ()=>Navigator.pop(context),
                          ),
                        ),
                        getPadding(getText(widget.title,textType: TextType.textTypeTitle),horizontal: 10),
                      ],
                    ),
                    Visibility(
                      visible: widget.onMorePressed!=null,
                      child: IconButton(
                        icon: getIcon(IconPack.dots_vertical),
                        onPressed: widget.onMorePressed,
                      ),
                    ),
                  ],
                ):Container(),
              ]+smallScreenItems,
          ),
        ),
      ),
    );
  }

}