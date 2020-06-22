
import 'package:intl/intl.dart';

DateFormat _getDateFormat(){
  
  return DateFormat('HH:mm:ss : dd-MM-yy');
}

DateTime getDateFromString(String string){
  if(string==null||string.trim()==''){
    return null;
  }

  return _getDateFormat().parse(string);
}

getStringFromDate(DateTime dateTime){
  if(dateTime==null){
    return '';
  }else{
    return _getDateFormat().format(dateTime);
  }
  
}


//For this project 