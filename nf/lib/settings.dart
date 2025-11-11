import 'dart:ui';

class Settings {
  static Color HomeBackgroundColor = Color.fromARGB(255, 1, 22, 30);
  static Color appBarBackgoundColor = Color.fromARGB(255, 18, 69, 89);
  static Color bottonBarBackgroundColor = Color.fromARGB(255, 89, 131, 146);
  static Color containerColor = Color.fromARGB(150, 89, 131, 146);

  static Color TextColor = Color.fromARGB(255, 174, 195, 176);

  static Color selectedColor = Color.fromARGB(255, 239, 246, 224);
  static Color unselectedColor = Color.fromARGB(255, 174, 195, 176);

  static String serverIP = '192.168.0.168';
  static int serverPort = 5002;
  static String route = 'nf';

  static String getUrl() {
    return "http://${serverIP}:${serverPort}/${route}";
  }

  static String getUrlInvoice() {
    return "http://${serverIP}:${serverPort}/info?command=General";
  }

  static String getUrlTax() {
    return "http://${serverIP}:${serverPort}/info?command=Tax";
  }

  static String getUrlNf(String number) {
    return "http://${serverIP}:${serverPort}/info?command=NF&id=$number";
  }

  static String getUrlSuppliers() {
    return "http://${serverIP}:${serverPort}/info?command=Suppliers";
  }
}
