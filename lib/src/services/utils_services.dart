import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsServices {

  // R$ valor
  priceToCurrency(double price){
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_br');

    return numberFormat.format(price);
  }

  // Data Formatada
  String formatDateTime(DateTime dateTime){
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

}