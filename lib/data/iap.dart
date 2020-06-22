
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rosse/ui/pages/home_page.dart';
import 'package:rosse/utils/utils.dart';

class IAPHelper{


  Future<void> initPlatformState(String userId,BuildContext context) async {
    await Purchases.setup("VYBaJeHkvzETFNHYCVDQUSvxtxwoiueg", appUserId: userId);

    Purchases.addPurchaserInfoUpdateListener((purchaserInfo){
    });

  }

  purchase(BuildContext buildContext)async{
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        try {
          PurchaserInfo purchaserInfo = await Purchases.purchasePackage(offerings.current.availablePackages[0]);
          var isPro = purchaserInfo.activeSubscriptions.contains('subscription');
          if (isPro) {
            launchPage(buildContext, HomePage());
          }
        } on PlatformException catch (e) {
          var errorCode = PurchasesErrorHelper.getErrorCode(e);
          if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
            //show error	          
          }
        }
      }
    } on PlatformException catch (e) {
      // optional error handling
      print('purchase error $e');
    }
  }

  Future<bool> isSubscriptionActive()async{
    try {
      PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
      if (purchaserInfo.activeSubscriptions.contains('subscription')) {
        return true;
      }
    } on PlatformException catch (e) {
      // Error fetching purchaser info
      print('is subscription active error $e');
    }
    return false;
  }

  
  

}