import 'package:flutter/material.dart';
import 'package:rosse/data/backend.dart';
import 'package:rosse/ui/pages/welcome_page.dart';
import 'package:rosse/utils/get_popup_and_sheets_utils.dart';
import 'package:rosse/utils/get_widget_utils.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:rosse/utils/utils.dart';

class LoginHelper{


  GoogleSignInAccount currentUser;
  BuildContext _context;
  GoogleSignIn _googleSignIn;

  static LoginHelper initObject(BuildContext buildContext){
    LoginHelper loginHelper = LoginHelper();
    loginHelper._context = buildContext;
    loginHelper._googleSignIn = GoogleSignIn();
    return loginHelper;
  }

  initAndSignSilently(Backend backend)async{
    final account = await _googleSignIn.signInSilently();
    if(account==null){

        if(currentUser==null){
          launchPage(_context, WelcomePage());
        }

      return; 
    }else{
      currentUser=account;
      await backend.login(this);

    }
  }

  signOut(){
    if(currentUser!=null){
      _googleSignIn.signOut();
    }
  }

  

  // google sign in 
  Future<Null> handleSignIn(Backend backend,Function(bool) onCanSignInSilentlyChange)async{ 
    try{ 
      currentUser =  await _googleSignIn.signIn();
      onCanSignInSilentlyChange(true);  
      await backend.login(this);
    }catch(error){ 
      print(error);
      showDistivityDialog(_context,actions: [getButton('Try again',onPressed: (){handleSignIn(backend,onCanSignInSilentlyChange);})],
        stateGetter: (ctx,ss){
          return getText('Error occurred. Please try again');
        },
        title: 'Error occurred signing up'); 
    } 
  }

}