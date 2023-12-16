
import 'package:intl/intl.dart' as intl;

class BeautyNumber{
  static String price(int price, {bool justNumber = false, bool roundNumber = true}) {

    var prefix = '';
    if(price < 0){
      var sss = price.toString();
      prefix = '-';
      sss = sss.substring(1, sss.length);
      price = int.parse(sss);
    }

    if(roundNumber){
      price = roundInt(price);
    }

    var formatter = intl.NumberFormat('###,###,000');
    var priceString = formatter.format(price);
    //priceString = priceString.replaceAll(',', '.');
    if (priceString == '000') {
      priceString = '0';
    }



    if(justNumber){
      return prefix + priceString;
    }
    return  priceString + prefix + ' تومان';
  }

  static phone(String phone) {
    if (phone.startsWith('98')) {
      phone = phone.replaceFirst('98', '0');
    }
    phone = phone.substring(0, 4) +
        ' ' +
        phone.substring(4, 7) +
        ' ' +
        phone.substring(7, 11);
    return phone;
  }

  static roundInt(int number){


    if(number < 1000){
      return 0;
    }

    var priceString = number.toString();
    if(priceString.length >= 3){

      int length = priceString.length;
      var last3 = priceString[length-3];
      last3 += priceString[length-2];
      last3 += priceString[length-1];

      priceString = priceString.substring(0, length-3);

      int last3Int = int.parse(last3);

      if(last3Int < 500){

        priceString = priceString + '000';
      }
      else if(last3Int > 500){
        priceString = (int.parse(priceString)+ 1).toString() + '000';
      }
      else if(last3Int == 500){
        priceString = priceString + '500';
      }
      number = int.parse(priceString);
      return number;
    }

    return 0;
  }
}