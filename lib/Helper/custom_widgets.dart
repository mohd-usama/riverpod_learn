// import 'package:another_flushbar/flushbar.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:get/get.dart';
// import 'package:in_app_update/in_app_update.dart';
// import 'package:intl/intl.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import '../Models/dropdownModel.dart';
// import 'app_theme.dart';
//
// class CustomWidgets {
//   int type = 1;
//   static DateTime currentDate = DateTime.now();
//   PackageInfo? packageInfo;
//
//   static Future<String> getVersion() async {
//     return (await PackageInfo.fromPlatform()).version;
//   }
//
//   Future<String> dateNow() async {
//     DateTime now = DateTime.now();
//     return DateFormat('dd-MMM-yyyy').format(now);
//   }
//
//   Future<String> dateNow2(BuildContext context) async {
//     DateTime now = DateTime.now();
//     return DateFormat('yyyy-MM-dd').format(now);
//   }
//
//   Future<String> subtractDate(BuildContext context) async {
//     DateTime now = DateTime(currentDate.year, currentDate.month, currentDate.day - 8);
//     return DateFormat('dd-MMM-yyyy').format(now);
//   }
//
//   Widget verticalDivider = const VerticalDivider(color: Colors.white, thickness: 1);
//
//   Widget verticalDivider2 = const VerticalDivider(color: Colors.grey, thickness: 1);
//
//   Future<String> timeNow(BuildContext context) async {
//     return TimeOfDay.now().format(context);
//   }
//
//   static Future<String> pickDate(BuildContext context, {String? type, String? backDate}) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: backDate == "1" ? DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day) : currentDate,
//       firstDate: DateTime(2000, 7),
//       lastDate: type == "1" ? DateTime(2050) : DateTime.now(),
//     );
//     if (pickedDate != null && pickedDate != currentDate) {
//       return DateFormat('dd-MMM-yyyy').format(pickedDate);
//     }
//     if (type == "1") {
//       return DateFormat('dd-MMM-yyyy').format(DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day));
//     } else {
//       return DateFormat('dd-MMM-yyyy').format(currentDate).toString();
//     }
//   }
//
//   static Future<String> pickDateTwo(BuildContext context, {String? type, String? backDate}) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: backDate == "1" ? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 7) : currentDate,
//       firstDate: DateTime(2000, 7),
//       lastDate: type == "1" ? DateTime(2050) : DateTime.now(),
//     );
//     if (pickedDate != null && pickedDate != currentDate) {
//       return DateFormat('dd-MMM-yyyy').format(pickedDate);
//     }
//     if (type == "1") {
//       return DateFormat('dd-MMM-yyyy').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 7));
//     } else {
//       return DateFormat('dd-MMM-yyyy').format(currentDate).toString();
//     }
//   }
//
//   static getHeight(BuildContext context) {
//     return MediaQuery.of(context).size.height;
//   }
//
//   static getWidth(BuildContext context) {
//     return MediaQuery.of(context).size.width;
//   }
//
//   static modelTypeDropDown2(NewDropDownModel value, List<NewDropDownModel> itemList, void Function(NewDropDownModel?)? onChange) {
//     return Container(
//       height: 48,
//       margin: const EdgeInsets.only(top: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<NewDropDownModel>(
//           value: value,
//           isExpanded: true,
//           icon: const Icon(Icons.keyboard_arrow_down),
//           items: itemList.map((NewDropDownModel? items) {
//             return DropdownMenuItem<NewDropDownModel>(
//               value: items,
//               child: Text(items!.textPart.toString(), overflow: TextOverflow.ellipsis),
//             );
//           }).toList(),
//           onChanged: onChange,
//         ),
//       ),
//     );
//   }
//
//   static Widget autoCompleteFiled(TextEditingController controller, List<String> list,
//       {Widget? label,
//       bool? isValid = false,
//       bool enabled = true,
//       String? hint,
//       Widget? prefixIconWidget,
//       bool fillColorFiled = false,
//       List<TextInputFormatter>? inputFormatters,
//       TextInputType? keyboardType,
//       Function(String v)? onSelectFunction,
//       required void Function(String) suggestionText,
//       FocusNode? focusNode,
//       void Function(String)? onChanged,
//       void Function()? suffixIconOnTap,
//       void Function()? onTap,
//       SuggestionsController<String>? suggestionsController,
//       ScrollController? scrollController,
//       VerticalDirection? direction,
//       Key? key}) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: TypeAheadField<String>(
//         key: key,
//         controller: controller,
//         focusNode: focusNode,
//         scrollController: scrollController,
//         suggestionsController: suggestionsController,
//         direction: direction ?? VerticalDirection.down,
//         builder: (context, textController, focusNode1) {
//           return TextFormField(
//             onTap: onTap,
//             controller: textController,
//             focusNode: focusNode1,
//             inputFormatters: inputFormatters,
//             onChanged: onChanged,
//             enabled: enabled,
//             onFieldSubmitted: onSelectFunction,
//             decoration: InputDecoration(
//               prefixIcon: prefixIconWidget,
//               fillColor: fillColorFiled ? Colors.grey[200] : null,
//               filled: fillColorFiled,
//               contentPadding: const EdgeInsets.only(left: 10, right: 10),
//               label: label,
//               suffix: GestureDetector(onTap: suffixIconOnTap, child: const Icon(Icons.close, size: 20)),
//               labelStyle: const TextStyle(color: Colors.black),
//               hintText: hint,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: AppColor.mainBlue),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: AppColor.mainBlue),
//               ),
//               disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: AppColor.mainBlue),
//               ),
//             ),
//           );
//         },
//         decorationBuilder: (context, child) => Material(
//           elevation: 4,
//           borderRadius: BorderRadius.circular(8),
//           child: child,
//         ),
//         suggestionsCallback: (pattern) {
//           return list.where((String? option) {
//             return option!.toString().toLowerCase().contains(pattern.toLowerCase());
//           }).toList();
//         },
//         itemBuilder: (context, String suggestion) {
//           return ListTile(
//             tileColor: Colors.white10.withOpacity(0.01),
//             title: Text(suggestion),
//           );
//         },
//         onSelected: (String suggestion) {
//           suggestionText(suggestion);
//         },
//       ),
//     );
//   }
//
//   static Decoration containerDeco() {
//     return const BoxDecoration(
//         color: AppColor.mainBlue, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)));
//   }
//
//   static Decoration containerDeco2() {
//     return BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10));
//   }
//
//   static Widget textInputFiled(
//     TextEditingController? controller, {
//     String hintText = "",
//     Widget? suffixIconWidget,
//     Widget? prefixIconWidget,
//     List<TextInputFormatter>? inputFormatters,
//     FocusNode? focusNode,
//     bool? passwordHide,
//     ValueChanged<String>? onFieldSubmitTap,
//     TextInputType? textInputType,
//     int? maxLine,
//     bool? enabledBox,
//     FormFieldValidator<String>? validator,
//     void Function()? onTapFunction,
//     void Function(String)? onChanged,
//     void Function()? onTap,
//     TextAlign? textAlign,
//     TextCapitalization? textCapitalization,
//     Function()? onEditingComplete,
//     Color? fillColors,
//     bool readOnlyFiled = false,
//     bool? fillColorFiled,
//     Widget? label,
//   }) {
//     return Focus(
//       child: Container(
//         margin: const EdgeInsets.only(top: 8),
//         child: TextFormField(
//           controller: controller,
//           focusNode: focusNode,
//           onTap: onTap,
//           enabled: enabledBox,
//           obscureText: passwordHide ?? false,
//           onChanged: onChanged,
//           onFieldSubmitted: onFieldSubmitTap,
//           readOnly: readOnlyFiled,
//           maxLines: (passwordHide ?? false) ? 1 : (maxLine ?? 1),
//           onEditingComplete: onEditingComplete,
//           inputFormatters: inputFormatters,
//           keyboardType: textInputType,
//           textCapitalization: textCapitalization ?? TextCapitalization.none,
//           textAlign: textAlign ?? TextAlign.start,
//           validator: validator,
//           style: const TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.black),
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//             hintText: hintText,
//             hintStyle: const TextStyle(fontSize: 14, fontFamily: 'Montserrat'),
//             // fillColor: fillColors,
//             // filled: fillColorFiled,
//             filled: fillColorFiled ?? !(enabledBox ?? true),
//             fillColor: fillColors ?? ((enabledBox ?? true) ? Colors.transparent : Colors.grey.shade200),
//             label: label,
//             suffixIcon: suffixIconWidget,
//             prefixIcon: prefixIconWidget,
//             enabledBorder:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey)),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: Colors.blue),
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: Colors.grey),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Widget elevatedCustomButton(String? buttonName, void Function()? onTapFunction,
//       {double? heightButton, double? horizontal, bool iconEnable = false, String imagePath = ""}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: horizontal ?? 15),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColor.mainBlue,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         height: heightButton ?? 45,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.transparent,
//               shadowColor: Colors.transparent,
//               disabledBackgroundColor: Colors.white.withOpacity(0.4),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//           onPressed: onTapFunction,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 buttonName!,
//                 style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//               if (iconEnable) Image.asset(imagePath, height: 18),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   static getSnackBarMsg(BuildContext context, String title, String msg) {
//     return Flushbar(
//       padding: const EdgeInsets.all(8),
//       titleColor: Colors.white,
//       flushbarPosition: FlushbarPosition.TOP,
//       flushbarStyle: FlushbarStyle.FLOATING,
//       reverseAnimationCurve: Curves.decelerate,
//       forwardAnimationCurve: Curves.elasticOut,
//       backgroundGradient: const LinearGradient(colors: [AppColor.brightRed, AppColor.lightRed]),
//       isDismissible: false,
//       duration: const Duration(seconds: 2),
//       icon: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Image.asset("assets/icons/cross.png", height: 35, width: 35, color: Colors.white),
//       ),
//       showProgressIndicator: true,
//       progressIndicatorBackgroundColor: Colors.white,
//       titleText: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
//       messageText: Text(msg, style: const TextStyle(fontSize: 15, color: Colors.white)),
//     ).show(context);
//   }
//
//   static Widget stringTypeDropDown(String value, List<String> itemList, void Function(String?)? onChange, {Color? colorDropDown}) {
//     return Container(
//       height: 48,
//       margin: const EdgeInsets.only(top: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: AppColor.extraLightBlue,
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           isExpanded: true,
//           icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
//           items: itemList.map<DropdownMenuItem<String>>((String items) {
//             return DropdownMenuItem<String>(
//               value: items,
//               child: Text(items, style: const TextStyle(color: Colors.black)),
//             );
//           }).toList(),
//           onChanged: onChange,
//         ),
//       ),
//     );
//   }
//
//   static divider({double? verticalPadding, double? horizontalPadding, Color color = Colors.black45}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: verticalPadding ?? 4.0,
//         horizontal: horizontalPadding ?? 0.0,
//       ),
//       child: Divider(thickness: 1, height: 1, color: color),
//     );
//   }
//
//   static Future<void> checkUpdateForAndroid() async {
//     InAppUpdate.checkForUpdate().then(
//       (updateInfo) {
//         if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
//           if (updateInfo.flexibleUpdateAllowed) {
//             InAppUpdate.startFlexibleUpdate().then(
//               (appUpdateResult) {
//                 if (appUpdateResult == AppUpdateResult.success) {
//                   InAppUpdate.completeFlexibleUpdate();
//                 }
//               },
//             );
//           }
//         }
//       },
//     );
//   }
//
//   BoxDecoration decoration = BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(10),
//     boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4)],
//   );
//
//   Widget rowWidget({String title = "", String value = "", isExapnded = false}) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "$title : ",
//           style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
//         ),
//         isExapnded
//             ? Expanded(child: Text(value, style: const TextStyle(fontSize: 14)))
//             : Text(value, style: const TextStyle(fontSize: 13.5)),
//       ],
//     );
//   }
//
//   Widget infoRow(String label, String? value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("$label : ", style: const TextStyle(fontWeight: FontWeight.w500)),
//         const Spacer(),
//         Text(value!, style: const TextStyle(fontWeight: FontWeight.w400)),
//       ],
//     );
//   }
//
//   void checkUpdateForIOS(BuildContext context) async {
//     await AppVersionUpdate.checkForUpdates(appleId: '6503600119').then((result) async {
//       if (context.mounted) {
//         if (result.canUpdate!) {
//           await AppVersionUpdate.showAlertUpdate(
//               appVersionResult: result,
//               context: context,
//               backgroundColor: Colors.grey[200],
//               title: 'New version available',
//               titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24.0),
//               content: 'Would you like to update your application?',
//               contentTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
//               updateButtonText: 'UPDATE',
//               cancelButtonText: 'UPDATE LATER',
//               cancelButtonStyle: ButtonStyle(
//                   backgroundColor: WidgetStateProperty.all(AppColor.brightRed),
//                   textStyle: WidgetStateProperty.all(const TextStyle(color: Colors.white))),
//               updateButtonStyle: ButtonStyle(
//                   backgroundColor: WidgetStateProperty.all(AppColor.brightGreen),
//                   textStyle: WidgetStateProperty.all(const TextStyle(color: Colors.white))));
//         }
//       }
//     });
//   }
//
//   static Future<Position> getLatitudeLongitude() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//
//       if (permission == LocationPermission.denied) {
//         Get.dialog(
//           AlertDialogManager().isErrorAndSuccessAlertDialogMessage(
//             "Permission Required",
//             "Location permission is needed. Please enable it.",
//             onTapFunction: () {
//               Get.back();
//             },
//           ),
//         );
//
//         return Future.error("Location permission denied");
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       Get.dialog(
//         AlertDialogManager().isErrorAndSuccessAlertDialogMessage(
//           "Permission Required",
//           "Location permission is permanently denied.\nPlease allow it from settings.",
//           onTapFunction: () async {
//             Get.back();
//             await Geolocator.openAppSettings();
//           },
//         ),
//       );
//
//       return Future.error("Location permission permanently denied — open settings required");
//     }
//
//     return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   }
//
//   Future<int> getDifference(String time1, String time2, {String timeFormat = ""}) async {
//     if ((time1.contains("PM") || time1.contains("AM")) || time2.contains("PM") || time2.contains("AM")) {
//       var newTime1 = DateFormat('HH:mm').format(DateFormat("h:mm a").parse(time1));
//       var newTime2 = DateFormat('HH:mm').format(DateFormat("h:mm a").parse(time2));
//       DateFormat dateFormat = DateFormat("yyyy-MM-dd");
//       DateTime a = DateTime.parse('${dateFormat.format(DateTime.now())} $newTime1');
//       DateTime b = DateTime.parse('${dateFormat.format(DateTime.now())} $newTime2');
//       return b.difference(a).inMinutes;
//     } else {
//       var format = DateFormat("HH:mm");
//       var one = format.parse(time1);
//       var two = format.parse(time2);
//       return two.difference(one).inMinutes;
//     }
//   }
//
//   String time12to24Format(String time) {
//     var df = DateFormat("h:mm a");
//     var dt = df.parse(time);
//     return DateFormat('HH:mm').format(dt);
//   }
//
//   String time24to12Format(String time) {
//     var temp = int.parse(time.split(':')[0]);
//     String? t;
//     if (temp >= 12 && temp < 24) {
//       t = " PM";
//     } else {
//       t = " AM";
//     }
//     if (temp > 12) {
//       temp = temp - 12;
//       if (temp < 10) {
//         time = time.replaceRange(0, 2, "0$temp");
//         time += t;
//       } else {
//         time = time.replaceRange(0, 2, "$temp");
//         time += t;
//       }
//     } else if (temp == 00) {
//       time = time.replaceRange(0, 2, '12');
//       time += t;
//     } else {
//       time += t;
//     }
//     return time;
//   }
//
//   static getFilePicker(bool multipleFile) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowedExtensions: ['jpg', 'jpeg', 'JPG', 'PNG', 'png', 'JPEG'],
//       allowMultiple: multipleFile,
//       type: FileType.custom,
//       withData: true,
//     );
//     return result;
//   }
//
//   Future<Uint8List> getCompressedBase64(File? photo) async {
//     File file = File(photo!.path);
//     var result = await FlutterImageCompress.compressWithFile(file.absolute.path,
//         minWidth: 640, minHeight: 1136, quality: 50, inSampleSize: 1);
//     return result!;
//   }
//
//   getDeviceID() async {
//     try {
//       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//       String deviceID = "";
//       if (Platform.isIOS) {
//         var iosDeviceInfo = await deviceInfo.iosInfo;
//         deviceID = iosDeviceInfo.identifierForVendor!;
//       } else {
//         var androidDeviceInfo = await deviceInfo.androidInfo;
//         deviceID = androidDeviceInfo.id;
//       }
//       return deviceID;
//     } on Exception {
//       return "";
//     }
//   }
//
//   plus(dynamic controller, BasicDetails data, int index, String outletCode) {
//     int position = controller.addOrderList.indexWhere((e) => e.menuID == controller.getMenuModel.data![index].basicDetails!.menuID);
//     if (position == -1) {
//       controller.addOrderList.add(AddOrderModel(
//         qty: 1,
//         menuPrice: data.netAmount,
//         menuID: data.menuID,
//         outletCode: outletCode,
//       ));
//     } else {
//       if (data.cartCount >= 1) {
//         controller.addOrderList[position].qty = controller.addOrderList[position].qty! + 1;
//         controller.update();
//       } else {
//         controller.addOrderList.removeAt(position);
//         controller.update();
//       }
//     }
//   }
//
//   minus(dynamic controller, BasicDetails data, int index, String outletCode) {
//     int position = controller.addOrderList.indexWhere((e) => e.menuID == controller.getMenuModel.data![index].basicDetails!.menuID);
//     if (position == -1) {
//       controller.addOrderList.add(AddOrderModel(
//         qty: 1,
//         menuPrice: data.netAmount,
//         menuID: data.menuID,
//         outletCode: outletCode,
//       ));
//     } else {
//       if (data.cartCount >= 1) {
//         controller.addOrderList[position].qty = controller.addOrderList[position].qty! - 1;
//         controller.update();
//       } else {
//         controller.addOrderList.removeAt(position);
//         controller.update();
//       }
//     }
//   }
//
//   String generateRandomString(int len) {
//     var r = Random();
//     const chars = 'c0542606-e89b-4a35-9292-8266b0295dd9';
//     return List.generate(len, (index) => chars[r.nextInt(chars.length).abs()]).join();
//   }
//
//   static Future<void> openMap(
//       {bool? mapOpenUsingLatLong, String address = "", double latitude = 0.0, double longitude = 0.0}) async {
//     String googleUrl;
//     if (mapOpenUsingLatLong!) {
//       googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//     } else {
//       googleUrl = 'https://www.google.com/maps/search/?api=1&query=$address';
//     }
//
//     await launchUrl(Uri.parse(googleUrl));
//   }
//
//   Future<void> makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launchUrl(launchUri);
//   }
//
//   static String getFileSizeString({required int bytes, int decimals = 0}) {
//     if (bytes <= 0) return "0 Bytes";
//     const suffixes = ["Bytes", "KB", "MB", "GB", "TB"];
//     var i = (log(bytes) / log(1024)).floor();
//     return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
//   }
//
//   Widget logoutSheet(BuildContext context, void Function()? onTapMethod) => Container(
//         padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Center(
//               child: SizedBox(
//                 width: 55,
//                 child: Divider(color: Colors.grey.shade300, thickness: 5),
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Logout",
//               style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0),
//               child: Divider(thickness: 1, height: 1, color: Colors.grey),
//             ),
//             const Text("Do you want to logout ?", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 45,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: const StadiumBorder()),
//                           onPressed: () {
//                             Get.back();
//                           },
//                           child: const Text(
//                             "Cancel",
//                             style: TextStyle(color: Colors.black, fontSize: 16),
//                           )),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: SizedBox(
//                       height: 45,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: AppColor.mainBlue),
//                           onPressed: onTapMethod,
//                           child: const Text("Logout", style: TextStyle(fontSize: 16, color: Colors.white))),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//
//   static Widget borderElevatedButton({String? title, Color? buttonColor, void Function()? onTapFunction, Widget? icon}) {
//     return SizedBox(
//       height: 38,
//       child: ElevatedButton.icon(
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(6),
//           ),
//           backgroundColor: buttonColor,
//         ),
//         onPressed: onTapFunction,
//         label: Text(
//           title!,
//           style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
//         ),
//         icon: icon!,
//       ),
//     );
//   }
//
//   Future<String> timeNow24WithSeconds() async {
//     final now = DateTime.now();
//     final hours = now.hour.toString().padLeft(2, '0');
//     final minutes = now.minute.toString().padLeft(2, '0');
//     final seconds = now.second.toString().padLeft(2, '0');
//     return "$hours:$minutes:$seconds";
//   }
//
//   static Future<TimeOfDay> timePicker(BuildContext context) async {
//     final TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (timeOfDay != null) {
//       return TimeOfDay(hour: timeOfDay.hour, minute: timeOfDay.minute);
//     } else {
//       return TimeOfDay.now();
//     }
//   }
//
//   static Widget textInputFiled1(TextEditingController? controller,
//       {String hintText = "",
//       String labelTextNew = "",
//       Widget? suffixIconWidget,
//       Widget? prefixIconWidget,
//       List<TextInputFormatter>? inputFormatters,
//       Widget? label,
//       bool readOnlyFiled = false,
//       bool fillColorFiled = false,
//       Color? fillColors,
//       FocusNode? focusNode,
//       bool passwordHide = false,
//       ValueChanged? onFieldSubmitTap,
//       TextInputType? textInputType,
//       int? maxLine,
//       bool? enabledBox,
//       FormFieldValidator<String>? validator,
//       void Function()? onTapFunction,
//       void Function(String)? onChanged,
//       double? topPadding,
//       double? bottomPadding,
//       double? leftPadding,
//       double? rightPadding,
//       TextAlign? textAlign,
//       bool isMandatory = false,
//       TextCapitalization? textCapitalization,
//       Function()? onEditingComplete}) {
//     return Padding(
//       padding: EdgeInsets.only(left: leftPadding ?? 0, right: rightPadding ?? 0, top: topPadding ?? 20, bottom: bottomPadding ?? 0),
//       child: TextFormField(
//         textAlign: textAlign!,
//         onTap: onTapFunction,
//         focusNode: focusNode,
//         controller: controller,
//         enabled: enabledBox,
//         obscureText: passwordHide,
//         onChanged: onChanged,
//         onFieldSubmitted: onFieldSubmitTap,
//         readOnly: readOnlyFiled,
//         maxLines: maxLine,
//         onEditingComplete: onEditingComplete,
//         //textInputAction: TextInputAction.next,
//         inputFormatters: inputFormatters,
//         textCapitalization: textCapitalization ?? TextCapitalization.none,
//         keyboardType: textInputType,
//         validator: validator,
//
//         decoration: InputDecoration(
//           fillColor: fillColors,
//           filled: fillColorFiled,
//           suffixIcon: suffixIconWidget,
//           prefixIcon: prefixIconWidget,
//           prefixIconConstraints: const BoxConstraints(minWidth: 45, minHeight: 25, maxWidth: 45, maxHeight: 25),
//           label: RichText(
//             text: TextSpan(children: [
//               TextSpan(text: labelTextNew, style: const TextStyle(color: Colors.black, fontSize: 15)),
//               if (isMandatory) const TextSpan(text: " *", style: TextStyle(color: AppColor.brightRed, fontSize: 16))
//             ]),
//           ),
//           hintText: hintText,
//           hintStyle: const TextStyle(fontSize: 15),
//           enabledBorder:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey)),
//           focusedBorder:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColor.mainBlue)),
//           disabledBorder:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey)),
//         ),
//       ),
//     );
//   }
//
//   static Widget requiredLabel(String text) {
//     return Text.rich(
//       TextSpan(
//         children: [
//           TextSpan(
//             text: text,
//             style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
//           ),
//           const TextSpan(
//             text: ' *',
//             style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static Future<String> platformType() async {
//     return Platform.operatingSystem;
//   }
//
//   static getCustomCheckBox({bool initialValue = false, Function(bool?)? onChanged, String? label}) {
//     return Theme(
//       data: ThemeData(unselectedWidgetColor: AppColor.mainBlue),
//       child: Row(
//         children: [
//           Checkbox(
//               value: initialValue,
//               checkColor: Colors.white,
//               fillColor: WidgetStateProperty.all(initialValue ? AppColor.brightGreen : Colors.white),
//               hoverColor: AppColor.brightGreen,
//               onChanged: onChanged),
//           Text(
//             label ?? "",
//             style: const TextStyle(color: Colors.black),
//           )
//         ],
//       ),
//     );
//   }
//
//   static Widget modelTypeDropDown(DropdownModel value, List<DropdownModel> itemList, void Function(DropdownModel?)? onChange,
//       {Color? colorDropDown}) {
//     return Container(
//       height: 48,
//       margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: Colors.grey,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<DropdownModel>(
//           value: value,
//           isExpanded: true,
//           icon: const Icon(
//             Icons.keyboard_arrow_down_rounded,
//             color: Colors.black,
//           ),
//           items: itemList.map<DropdownMenuItem<DropdownModel>>((DropdownModel items) {
//             return DropdownMenuItem<DropdownModel>(
//               value: items,
//               child: Text(
//                 items.name!,
//                 style: const TextStyle(color: Colors.black),
//               ),
//             );
//           }).toList(),
//           onChanged: onChange,
//         ),
//       ),
//     );
//   }
//
//   static Widget modelTypeDropDownForDataTable(
//       DropdownModel value, List<DropdownModel> itemList, void Function(DropdownModel?)? onChange,
//       {Color? colorDropDown}) {
//     return Container(
//       margin: const EdgeInsets.only(top: 4, bottom: 4),
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: Colors.grey,
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<DropdownModel>(
//           value: value,
//           isExpanded: true,
//           icon: const Icon(
//             Icons.keyboard_arrow_down_rounded,
//             color: Colors.black,
//           ),
//           items: itemList.map<DropdownMenuItem<DropdownModel>>((DropdownModel items) {
//             return DropdownMenuItem<DropdownModel>(
//               value: items,
//               child: Text(
//                 items.name!,
//                 style: const TextStyle(color: Colors.black),
//               ),
//             );
//           }).toList(),
//           onChanged: onChange,
//         ),
//       ),
//     );
//   }
//
//   static verticalBorder() {
//     return const VerticalDivider(thickness: 1, color: Colors.black, width: 1);
//   }
// }
