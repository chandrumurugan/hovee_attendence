import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/modals/loginModal.dart';
import 'package:hovee_attendence/modals/login_data_model.dart';
import 'package:hovee_attendence/modals/otpModal.dart';
import 'package:hovee_attendence/modals/regiasterModal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/loginSignup/otp_screen.dart';
import 'package:logger/logger.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthControllers extends GetxController
    with GetSingleTickerProviderStateMixin {
  final box = GetStorage();

  late TabController tabController;
  var currentTabIndex = 0.obs;
  //login
  final logInController = TextEditingController();
//signup
  final phController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  final pincodeController = TextEditingController();
  final otpController = TextEditingController();
  final focusNode = FocusNode();
  final idProofController = TextEditingController();

  var selectedIDProof = ''.obs;
  var acceptedTerms = false.obs;
  var isTickedWhatsApp = false.obs;

  // var isLoading = false.obs;
  RxBool isLoading = false.obs;

  var loginResponse = LoginModal().obs;
  var registerResponse = RegisterModal().obs;
  var otpResponse = OtpModal().obs;
  RxBool isOtpResent = false.obs;

  var _start = 30.obs; // Reactive variable to hold the timer value
  var _isTimerRunning =
      true.obs; // Reactive variable to track if the timer is running
  Timer? _timer;

  int get timerValue => _start.value; // Getter for timer value
  bool get isTimerRunning => _isTimerRunning.value; // Getter for timer state

  RxBool isChecked = false.obs;
  final SplashController splashController = Get.put(SplashController(
    parentId: '',
    phoneNumber: '',
  ));

  LoginData? loginData;

  final ParentController parentController = Get.put(ParentController());

   List<Map<String, String>> country_codes = [
  {
    "name": "Afghanistan",
    "code": "AF",
    "dial_code": "+93",
  },
  {
    "name": "Åland",
    "code": "AX",
    "dial_code": "+358",
  },
  {
    "name": "Albania",
    "code": "AL",
    "dial_code": "+355",
  },
  {
    "name": "Algeria",
    "code": "DZ",
    "dial_code": "+213",
  },
  {
    "name": "American Samoa",
    "code": "AS",
    "dial_code": "+1684",
  },
  {
    "name": "Andorra",
    "code": "AD",
    "dial_code": "+376",
  },
  {
    "name": "Angola",
    "code": "AO",
    "dial_code": "+244",
  },
  {
    "name": "Anguilla",
    "code": "AI",
    "dial_code": "+1264",
  },
  {
    "name": "Antarctica",
    "code": "AQ",
    "dial_code": "+672",
  },
  {
    "name": "Antigua and Barbuda",
    "code": "AG",
    "dial_code": "+1268",
  },
  {
    "name": "Argentina",
    "code": "AR",
    "dial_code": "+54",
  },
  {
    "name": "Armenia",
    "code": "AM",
    "dial_code": "+374",
  },
  {
    "name": "Aruba",
    "code": "AW",
    "dial_code": "+297",
  },
  {
    "name": "Australia",
    "code": "AU",
    "dial_code": "+61",
  },
  {
    "name": "Austria",
    "code": "AT",
    "dial_code": "+43",
  },
  {
    "name": "Azerbaijan",
    "code": "AZ",
    "dial_code": "+994",
  },
  {
    "name": "Bahamas",
    "code": "BS",
    "dial_code": "+1242",
  },
  {
    "name": "Bahrain",
    "code": "BH",
    "dial_code": "+973",
  },
  {
    "name": "Bangladesh",
    "code": "BD",
    "dial_code": "+880",
  },
  {
    "name": "Barbados",
    "code": "BB",
    "dial_code": "+1246",
  },
  {
    "name": "Belarus",
    "code": "BY",
    "dial_code": "+375",
  },
  {
    "name": "Belgium",
    "code": "BE",
    "dial_code": "+32",
  },
  {
    "name": "Belize",
    "code": "BZ",
    "dial_code": "+501",
  },
  {
    "name": "Benin",
    "code": "BJ",
    "dial_code": "+229",
  },
  {
    "name": "Bermuda",
    "code": "BM",
    "dial_code": "+1441",
  },
  {
    "name": "Bhutan",
    "code": "BT",
    "dial_code": "+975",
  },
  {
    "name": "Bolivia",
    "code": "BO",
    "dial_code": "+591",
  },
  {
    "name": "Bosnia and Herzegovina",
    "code": "BA",
    "dial_code": "+387",
  },
  {
    "name": "Botswana",
    "code": "BW",
    "dial_code": "+267",
  },
  {
    "name": "Bouvet Island",
    "code": "BV",
    "dial_code": "+47",
  },
  {
    "name": "Brazil",
    "code": "BR",
    "dial_code": "+55",
  },
  {
    "name": "British Indian Ocean Territory",
    "code": "IO",
    "dial_code": "+246",
  },
  {
    "name": "Brunei Darussalam",
    "code": "BN",
    "dial_code": "+673",
  },
  {
    "name": "Bulgaria",
    "code": "BG",
    "dial_code": "+359",
  },
  {
    "name": "Burkina Faso",
    "code": "BF",
    "dial_code": "+226",
  },
  {
    "name": "Burundi",
    "code": "BI",
    "dial_code": "+257",
  },
  {
    "name": "Cambodia",
    "code": "KH",
    "dial_code": "+855",
  },
  {
    "name": "Cameroon",
    "code": "CM",
    "dial_code": "+237",
  },
  {
    "name": "Canada",
    "code": "CA",
    "dial_code": "+1",
  },
  {
    "name": "Cape Verde",
    "code": "CV",
    "dial_code": "+238",
  },
  {
    "name": "Cayman Islands",
    "code": "KY",
    "dial_code": "+1345",
  },
  {
    "name": "Central African Republic",
    "code": "CF",
    "dial_code": "+236",
  },
  {
    "name": "Chad",
    "code": "TD",
    "dial_code": "+235",
  },
  {
    "name": "Chile",
    "code": "CL",
    "dial_code": "+56",
  },
  {
    "name": "China",
    "code": "CN",
    "dial_code": "+86",
  },
  {
    "name": "Christmas Island",
    "code": "CX",
    "dial_code": "+61",
  },
  {
    "name": "Cocos (Keeling) Islands",
    "code": "CC",
    "dial_code": "+61",
  },
  {
    "name": "Colombia",
    "code": "CO",
    "dial_code": "+57",
  },
  {
    "name": "Comoros",
    "code": "KM",
    "dial_code": "+269",
  },
  {
    "name": "Congo",
    "code": "CG",
    "dial_code": "+242",
  },
  {
    "name": "Congo, Democratic Republic",
    "code": "CD",
    "dial_code": "+243",
  },
  {
    "name": "Cook Islands",
    "code": "CK",
    "dial_code": "+682",
  },
  {
    "name": "Costa Rica",
    "code": "CR",
    "dial_code": "+506",
  },
  {
    "name": "Côte d'Ivoire",
    "code": "CI",
    "dial_code": "+225",
  },
  {
    "name": "Croatia",
    "code": "HR",
    "dial_code": "+385",
  },
  {
    "name": "Cuba",
    "code": "CU",
    "dial_code": "+53",
  },
  {
    "name": "Cyprus",
    "code": "CY",
    "dial_code": "+357",
  },
  {
    "name": "Czech Republic",
    "code": "CZ",
    "dial_code": "+420",
  },
  {
    "name": "Denmark",
    "code": "DK",
    "dial_code": "+45",
  },
  {
    "name": "Djibouti",
    "code": "DJ",
    "dial_code": "+253",
  },
  {
    "name": "Dominica",
    "code": "DM",
    "dial_code": "+1767",
  },
  {
    "name": "Dominican Republic",
    "code": "DO",
    "dial_code": "+1",
  },
  {
    "name": "Ecuador",
    "code": "EC",
    "dial_code": "+593",
  },
  {
    "name": "Egypt",
    "code": "EG",
    "dial_code": "+20",
  },
  {
    "name": "El Salvador",
    "code": "SV",
    "dial_code": "+503",
  },
  {
    "name": "Equatorial Guinea",
    "code": "GQ",
    "dial_code": "+240",
  },
  {
    "name": "Eritrea",
    "code": "ER",
    "dial_code": "+291",
  },
  {
    "name": "Estonia",
    "code": "EE",
    "dial_code": "+372",
  },
  {
    "name": "Ethiopia",
    "code": "ET",
    "dial_code": "+251",
  },
  {
    "name": "Falkland Islands",
    "code": "FK",
    "dial_code": "+500",
  },
  {
    "name": "Faroe Islands",
    "code": "FO",
    "dial_code": "+298",
  },
  {
    "name": "Fiji",
    "code": "FJ",
    "dial_code": "+679",
  },
  {
    "name": "Finland",
    "code": "FI",
    "dial_code": "+358",
  },
  {
    "name": "France",
    "code": "FR",
    "dial_code": "+33",
  },
  {
    "name": "French Guiana",
    "code": "GF",
    "dial_code": "+594",
  },
  {
    "name": "French Polynesia",
    "code": "PF",
    "dial_code": "+689",
  },
  {
    "name": "French Southern Territories",
    "code": "TF",
    "dial_code": "+262",
  },
  {
    "name": "Gabon",
    "code": "GA",
    "dial_code": "+241",
  },
  {
    "name": "Gambia",
    "code": "GM",
    "dial_code": "+220",
  },
  {
    "name": "Georgia",
    "code": "GE",
    "dial_code": "+995",
  },
  {
    "name": "Germany",
    "code": "DE",
    "dial_code": "+49",
  },
  {
    "name": "Ghana",
    "code": "GH",
    "dial_code": "+233",
  },
  {
    "name": "Gibraltar",
    "code": "GI",
    "dial_code": "+350",
  },
  {
    "name": "Greece",
    "code": "GR",
    "dial_code": "+30",
  },
  {
    "name": "Greenland",
    "code": "GL",
    "dial_code": "+299",
  },
  {
    "name": "Grenada",
    "code": "GD",
    "dial_code": "+1473",
  },
  {
    "name": "Guadeloupe",
    "code": "GP",
    "dial_code": "+590",
  },
  {
    "name": "Guam",
    "code": "GU",
    "dial_code": "+1671",
  },
  {
    "name": "Guatemala",
    "code": "GT",
    "dial_code": "+502",
  },
  {
    "name": "Guernsey",
    "code": "GG",
    "dial_code": "+44",
  },
  {
    "name": "Guinea",
    "code": "GN",
    "dial_code": "+224",
  },
  {
    "name": "Guinea-Bissau",
    "code": "GW",
    "dial_code": "+245",
  },
  {
    "name": "Guyana",
    "code": "GY",
    "dial_code": "+592",
  },
  {
    "name": "Haiti",
    "code": "HT",
    "dial_code": "+509",
  },
  {
    "name": "Honduras",
    "code": "HN",
    "dial_code": "+504",
  },
  {
    "name": "Hong Kong",
    "code": "HK",
    "dial_code": "+852",
  },
  {
    "name": "Hungary",
    "code": "HU",
    "dial_code": "+36",
  },
  {
    "name": "Iceland",
    "code": "IS",
    "dial_code": "+354",
  },
  {
    "name": "India",
    "code": "IN",
    "dial_code": "+91",
  },
  {
    "name": "Indonesia",
    "code": "ID",
    "dial_code": "+62",
  },
  {
    "name": "Iran",
    "code": "IR",
    "dial_code": "+98",
  },
  {
    "name": "Iraq",
    "code": "IQ",
    "dial_code": "+964",
  },
  {
    "name": "Ireland",
    "code": "IE",
    "dial_code": "+353",
  },
  {
    "name": "Isle of Man",
    "code": "IM",
    "dial_code": "+44",
  },
  {
    "name": "Israel",
    "code": "IL",
    "dial_code": "+972",
  },
  {
    "name": "Italy",
    "code": "IT",
    "dial_code": "+39",
  },
  {
    "name": "Jamaica",
    "code": "JM",
    "dial_code": "+1876",
  },
  {
    "name": "Japan",
    "code": "JP",
    "dial_code": "+81",
  },
  {
    "name": "Jersey",
    "code": "JE",
    "dial_code": "+44",
  },
  {
    "name": "Jordan",
    "code": "JO",
    "dial_code": "+962",
  },
  {
    "name": "Kazakhstan",
    "code": "KZ",
    "dial_code": "+7",
  },
  {
    "name": "Kenya",
    "code": "KE",
    "dial_code": "+254",
  },
  {
    "name": "Kiribati",
    "code": "KI",
    "dial_code": "+686",
  },
  {
    "name": "North Korea",
    "code": "KP",
    "dial_code": "+850",
  },
  {
    "name": "South Korea",
    "code": "KR",
    "dial_code": "+82",
  },
  {
    "name": "Kuwait",
    "code": "KW",
    "dial_code": "+965",
  },
  {
    "name": "Kyrgyzstan",
    "code": "KG",
    "dial_code": "+996",
  },
  {
    "name": "Laos",
    "code": "LA",
    "dial_code": "+856",
  },
  {
    "name": "Latvia",
    "code": "LV",
    "dial_code": "+371",
  },
  {
    "name": "Lebanon",
    "code": "LB",
    "dial_code": "+961",
  },
  {
    "name": "Lesotho",
    "code": "LS",
    "dial_code": "+266",
  },
  {
    "name": "Liberia",
    "code": "LR",
    "dial_code": "+231",
  },
  {
    "name": "Libya",
    "code": "LY",
    "dial_code": "+218",
  },
  {
    "name": "Liechtenstein",
    "code": "LI",
    "dial_code": "+423",
  },
  {
    "name": "Lithuania",
    "code": "LT",
    "dial_code": "+370",
  },
  {
    "name": "Luxembourg",
    "code": "LU",
    "dial_code": "+352",
  },
  {
    "name": "Macao",
    "code": "MO",
    "dial_code": "+853",
  },
  {
    "name": "North Macedonia",
    "code": "MK",
    "dial_code": "+389",
  },
  {
    "name": "Madagascar",
    "code": "MG",
    "dial_code": "+261",
  },
  {
    "name": "Malawi",
    "code": "MW",
    "dial_code": "+265",
  },
  {
    "name": "Malaysia",
    "code": "MY",
    "dial_code": "+60",
  },
  {
    "name": "Maldives",
    "code": "MV",
    "dial_code": "+960",
  },
  {
    "name": "Mali",
    "code": "ML",
    "dial_code": "+223",
  },
  {
    "name": "Malta",
    "code": "MT",
    "dial_code": "+356",
  },
  {
    "name": "Marshall Islands",
    "code": "MH",
    "dial_code": "+692",
  },
  {
    "name": "Martinique",
    "code": "MQ",
    "dial_code": "+596",
  },
  {
    "name": "Mauritania",
    "code": "MR",
    "dial_code": "+222",
  },
  {
    "name": "Mauritius",
    "code": "MU",
    "dial_code": "+230",
  },
  {
    "name": "Mayotte",
    "code": "YT",
    "dial_code": "+262",
  },
  {
    "name": "Mexico",
    "code": "MX",
    "dial_code": "+52",
  },
  {
    "name": "Micronesia",
    "code": "FM",
    "dial_code": "+691",
  },
  {
    "name": "Moldova",
    "code": "MD",
    "dial_code": "+373",
  },
  {
    "name": "Monaco",
    "code": "MC",
    "dial_code": "+377",
  },
  {
    "name": "Mongolia",
    "code": "MN",
    "dial_code": "+976",
  },
  {
    "name": "Montenegro",
    "code": "ME",
    "dial_code": "+382",
  },
  {
    "name": "Montserrat",
    "code": "MS",
    "dial_code": "+1664",
  },
  {
    "name": "Morocco",
    "code": "MA",
    "dial_code": "+212",
  },
  {
    "name": "Mozambique",
    "code": "MZ",
    "dial_code": "+258",
  },
  {
    "name": "Myanmar",
    "code": "MM",
    "dial_code": "+95",
  },
  {
    "name": "Namibia",
    "code": "NA",
    "dial_code": "+264",
  },
  {
    "name": "Nauru",
    "code": "NR",
    "dial_code": "+674",
  },
  {
    "name": "Nepal",
    "code": "NP",
    "dial_code": "+977",
  },
  {
    "name": "Netherlands",
    "code": "NL",
    "dial_code": "+31",
  },
  {
    "name": "New Caledonia",
    "code": "NC",
    "dial_code": "+687",
  },
  {
    "name": "New Zealand",
    "code": "NZ",
    "dial_code": "+64",
  },
  {
    "name": "Nicaragua",
    "code": "NI",
    "dial_code": "+505",
  },
  {
    "name": "Niger",
    "code": "NE",
    "dial_code": "+227",
  },
  {
    "name": "Nigeria",
    "code": "NG",
    "dial_code": "+234",
  },
  {
    "name": "Niue",
    "code": "NU",
    "dial_code": "+683",
  },
  {
    "name": "Norfolk Island",
    "code": "NF",
    "dial_code": "+672",
  },
  {
    "name": "Northern Mariana Islands",
    "code": "MP",
    "dial_code": "+1670",
  },
  {
    "name": "Norway",
    "code": "NO",
    "dial_code": "+47",
  },
  {
    "name": "Oman",
    "code": "OM",
    "dial_code": "+968",
  },
  {
    "name": "Pakistan",
    "code": "PK",
    "dial_code": "+92",
  },
  {
    "name": "Palau",
    "code": "PW",
    "dial_code": "+680",
  },
  {
    "name": "Palestinian Territory, Occupied",
    "code": "PS",
    "dial_code": "+970",
  },
  {
    "name": "Panama",
    "code": "PA",
    "dial_code": "+507",
  },
  {
    "name": "Papua New Guinea",
    "code": "PG",
    "dial_code": "+675",
  },
  {
    "name": "Paraguay",
    "code": "PY",
    "dial_code": "+595",
  },
  {
    "name": "Peru",
    "code": "PE",
    "dial_code": "+51",
  },
  {
    "name": "Philippines",
    "code": "PH",
    "dial_code": "+63",
  },
  {
    "name": "Pitcairn",
    "code": "PN",
    "dial_code": "+64",
  },
  {
    "name": "Poland",
    "code": "PL",
    "dial_code": "+48",
  },
  {
    "name": "Portugal",
    "code": "PT",
    "dial_code": "+351",
  },
  {
    "name": "Puerto Rico",
    "code": "PR",
    "dial_code": "+1939",
  },
  {
    "name": "Qatar",
    "code": "QA",
    "dial_code": "+974",
  },
  {
    "name": "Reunion",
    "code": "RE",
    "dial_code": "+262",
  },
  {
    "name": "Romania",
    "code": "RO",
    "dial_code": "+40",
  },
  {
    "name": "Russia",
    "code": "RU",
    "dial_code": "+7",
  },
  {
    "name": "Rwanda",
    "code": "RW",
    "dial_code": "+250",
  },
  {
    "name": "Saint Barthelemy",
    "code": "BL",
    "dial_code": "+590",
  },
  {
    "name": "Saint Helena, Ascension and Tristan Da Cunha",
    "code": "SH",
    "dial_code": "+290",
  },
  {
    "name": "Saint Kitts and Nevis",
    "code": "KN",
    "dial_code": "+1869",
  },
  {
    "name": "Saint Lucia",
    "code": "LC",
    "dial_code": "+1758",
  },
  {
    "name": "Saint Martin",
    "code": "MF",
    "dial_code": "+590",
  },
  {
    "name": "Saint Pierre and Miquelon",
    "code": "PM",
    "dial_code": "+508",
  },
  {
    "name": "Saint Vincent and the Grenadines",
    "code": "VC",
    "dial_code": "+1784",
  },
  {
    "name": "Samoa",
    "code": "WS",
    "dial_code": "+685",
  },
  {
    "name": "San Marino",
    "code": "SM",
    "dial_code": "+378",
  },
  {
    "name": "Sao Tome and Principe",
    "code": "ST",
    "dial_code": "+239",
  },
  {
    "name": "Saudi Arabia",
    "code": "SA",
    "dial_code": "+966",
  },
  {
    "name": "Senegal",
    "code": "SN",
    "dial_code": "+221",
  },
  {
    "name": "Serbia",
    "code": "RS",
    "dial_code": "+381",
  },
  {
    "name": "Seychelles",
    "code": "SC",
    "dial_code": "+248",
  },
  {
    "name": "Sierra Leone",
    "code": "SL",
    "dial_code": "+232",
  },
  {
    "name": "Singapore",
    "code": "SG",
    "dial_code": "+65",
  },
  {
    "name": "Sint Maarten",
    "code": "SX",
    "dial_code": "+1721",
  },
  {
    "name": "Slovakia",
    "code": "SK",
    "dial_code": "+421",
  },
  {
    "name": "Slovenia",
    "code": "SI",
    "dial_code": "+386",
  },
  {
    "name": "Solomon Islands",
    "code": "SB",
    "dial_code": "+677",
  },
  {
    "name": "Somalia",
    "code": "SO",
    "dial_code": "+252",
  },
  {
    "name": "South Africa",
    "code": "ZA",
    "dial_code": "+27",
  },
  {
    "name": "South Sudan",
    "code": "SS",
    "dial_code": "+211",
  },
  {
    "name": "Spain",
    "code": "ES",
    "dial_code": "+34",
  },
  {
    "name": "Sri Lanka",
    "code": "LK",
    "dial_code": "+94",
  },
  {
    "name": "Sudan",
    "code": "SD",
    "dial_code": "+249",
  },
  {
    "name": "Suriname",
    "code": "SR",
    "dial_code": "+597",
  },
  {
    "name": "Svalbard and Jan Mayen",
    "code": "SJ",
    "dial_code": "+47",
  },
  {
    "name": "Swaziland",
    "code": "SZ",
    "dial_code": "+268",
  },
  {
    "name": "Sweden",
    "code": "SE",
    "dial_code": "+46",
  },
  {
    "name": "Switzerland",
    "code": "CH",
    "dial_code": "+41",
  },
  {
    "name": "Syria",
    "code": "SY",
    "dial_code": "+963",
  },
  {
    "name": "Taiwan",
    "code": "TW",
    "dial_code": "+886",
  },
  {
    "name": "Tajikistan",
    "code": "TJ",
    "dial_code": "+992",
  },
  {
    "name": "Tanzania",
    "code": "TZ",
    "dial_code": "+255",
  },
  {
    "name": "Thailand",
    "code": "TH",
    "dial_code": "+66",
  },
  {
    "name": "Timor-Leste",
    "code": "TL",
    "dial_code": "+670",
  },
  {
    "name": "Togo",
    "code": "TG",
    "dial_code": "+228",
  },
  {
    "name": "Tokelau",
    "code": "TK",
    "dial_code": "+690",
  },
  {
    "name": "Tonga",
    "code": "TO",
    "dial_code": "+676",
  },
  {
    "name": "Trinidad and Tobago",
    "code": "TT",
    "dial_code": "+1868",
  },
  {
    "name": "Tunisia",
    "code": "TN",
    "dial_code": "+216",
  },
  {
    "name": "Turkey",
    "code": "TR",
    "dial_code": "+90",
  },
  {
    "name": "Turkmenistan",
    "code": "TM",
    "dial_code": "+993",
  },
  {
    "name": "Tuvalu",
    "code": "TV",
    "dial_code": "+688",
  },
  {
    "name": "Uganda",
    "code": "UG",
    "dial_code": "+256",
  },
  {
    "name": "Ukraine",
    "code": "UA",
    "dial_code": "+380",
  },
  {
    "name": "United Arab Emirates",
    "code": "AE",
    "dial_code": "+971",
  },
  {
    "name": "United Kingdom",
    "code": "GB",
    "dial_code": "+44",
  },
  {
    "name": "United States",
    "code": "US",
    "dial_code": "+1",
  },
  {
    "name": "Uruguay",
    "code": "UY",
    "dial_code": "+598",
  },
  {
    "name": "Uzbekistan",
    "code": "UZ",
    "dial_code": "+998",
  },
  {
    "name": "Vanuatu",
    "code": "VU",
    "dial_code": "+678",
  },
  {
    "name": "Vatican City",
    "code": "VA",
    "dial_code": "+379",
  },
  {
    "name": "Venezuela",
    "code": "VE",
    "dial_code": "+58",
  },
  {
    "name": "Vietnam",
    "code": "VN",
    "dial_code": "+84",
  },
  {
    "name": "Wallis and Futuna",
    "code": "WF",
    "dial_code": "+681",
  },
  {
    "name": "Western Sahara",
    "code": "EH",
    "dial_code": "+212",
  },
  {
    "name": "Yemen",
    "code": "YE",
    "dial_code": "+967",
  },
  {
    "name": "Zambia",
    "code": "ZM",
    "dial_code": "+260",
  },
  {
    "name": "Zimbabwe",
    "code": "ZW",
    "dial_code": "+263",
  }
];


  bool validateFields(BuildContext context) {
    if (firstNameController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Please enter the first name.');
      return false;
    }
    if (lastNameController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the last name.',
      );
      return false;
    }
    if (emailController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the email.',
      );
      return false;
    }
    // Email format validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Invalid email format',
      );
      return false;
    }

    if (dobController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please select the DOB.',
      );
      return false;
    }

    if (phController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the phone number.',
      );
      return false;
    }
    // Phone number format validation (10 digits)
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phController.text)) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the valid phone number',
      );
      return false;
    }

    if (pincodeController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the pincode.',
      );
      return false;
    }

    // if (pincodeController.text.length <10) {
    //    SnackBarUtils.showSuccessSnackBar(context,'Invalid pincode.',);
    //   return false;
    // }

    if (!acceptedTerms.value) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please accept the checkbox to proceed',
      );
      return false;
    }

    if (selectedIDProof.value.isEmpty && idProofController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please select the Id proof',
      );
      return false;
    }

    // Add more validation as needed
    return true;
  }

  bool validateLogin(BuildContext context) {
    String input = logInController.text.trim();

    if (input.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the phone number / \n email ID',
      );
      return false;
    }

    // Check if the input is a phone number (10 digits)
    if (RegExp(r'^[0-9]+$').hasMatch(input)) {
      if (input.length != 10) {
        SnackBarUtils.showErrorSnackBar(
          context,
          'Invalid Phone number',
        );
        return false;
      }
      return true; // It's a valid phone number
    }

    // Check if the input is a valid email format
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input)) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Invalid email address.',
      );
      return false;
    }

    // If the input is a valid email
    return true;
  }

  bool validateOtp(BuildContext context) {
    if (otpController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the OTP',
      );
      return false;
    }
    return true;
  }

  void logIn(String identifiers, BuildContext context) async {
    if (validateLogin(context)) {
      isLoading.value = true;
      try {
        var response = await WebService.login(identifiers, context);
        if (response != null) {
          loginResponse.value = response;
          isLoading.value = false;
          logInController.clear();
          isChecked.value = false;
          Get.to(() => OtpScreen());
        } else {
          Logger().e('Failed to load AppConfig');
          isLoading.value = false;
        }
      } catch (e) {
        Logger().e(e);
      }
    }
  }

  void signIn(BuildContext context) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var response = await WebService.Register(
            context: context,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            dob: dobController.text,
            phNo: phController.text,
            pincode: pincodeController.text,
            idProof: selectedIDProof.value);

        if (response != null) {
          registerResponse.value = response;
          phController.clear();
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          dobController.clear();
          pincodeController.clear();
          otpController.clear();
          idProofController.clear();
          acceptedTerms.value = false;
          selectedIDProof.value = '';

          isLoading.value = false;
          Get.to(() => OtpScreen());
        } else {
          Logger().e('Failed to load AppConfig');
          isLoading.value = false;
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<OtpModal?> otp(BuildContext context) async {
    if (validateOtp(context)) {
      isLoading.value = true;
      try {
        // Logger().i("moving to otp ===>$");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var response = await WebService.otp(
            otpController.text,
            currentTabIndex.value == 0 || isOtpResent.value
                ? loginResponse.value.accountVerificationToken!
                : registerResponse.value.data!.accountVerificationToken!,
            context);
        if (response != null) {
          Logger().i(response.data);
          otpResponse.value = response;
          Logger().i('AGSD€SDHDFJFGSJ ${response.token!}');
          // prefs.setString("key", value)
          if (response.data!.roles!.roleName == 'Parent') {
            prefs.setString('PrentToken', response.token!);
          } 
          else {
            // prefs.setString('PrentToken', "");
            //    prefs.setString('Token', "");
               prefs.setString('Token', response.token!);
          }
            //  prefs.setString('Token', response.token!);
          // else{
       
          // }
          prefs.setString('Rolename', response.data!.roles!.roleName ?? '');
          var validateTokendata = response.data!;
          //if(response.parentData=='true'){
          // parentController.fetchHomeDashboardTuteeList();
          if (response.data!.roles!.roleName == 'Parent') {
            parentController.getUserTokenList(response.data!.sId!);
          } else {}
          // }

          LoginData loginData = LoginData(
            firstName: validateTokendata!.firstName,
            lastName: validateTokendata.lastName,
            wowId: validateTokendata.wowId,
          );
          prefs.setString('userData', jsonEncode(loginData.toJson()));
          getUserData();

          // box.write('Token', response.token);
          //  box.write('Rolename', response.data!.roles!.roleName);
          // var validateTokendata = response.data!;
          //  box.write('ValidateTokenData', validateTokendata);
          isLoading.value = false;
          return response;
        } else {
          isLoading.value = false;
          return null;
        }

        //     Get.snackbar(
        // '', response.message!);
      } catch (e) {
        print(e);
        return null;
      }
    }
    return null;
  }

  // Function to start the timer
  void startTimer() {
    _start.value = 30; // Reset the timer value
    _isTimerRunning.value = true;
    const oneSec = Duration(seconds: 1);
    _timer?.cancel(); // Cancel any previous timer if running
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start.value == 0) {
        _isTimerRunning.value = false;
        timer.cancel();
      } else {
        _start.value--;
      }
    });
  }

  // Function to resend OTP
  Future<void> resendOtp(BuildContext context) async {
    // Add your resend OTP logic here
    // After successful resend, restart the timer

    try {
      var response = await WebService.resendOtp(
        context: context,
        accountToken: currentTabIndex.value == 0
            ? loginResponse.value.accountVerificationToken!
            : registerResponse.value.data!.accountVerificationToken!,
      );
      if (response != null) {
        isOtpResent(true);
        loginResponse.value = response;
        isLoading.value = false;
        startTimer();
        // Get.to(() => OtpScreen());
      } else {
        Logger().e('Failed to load AppConfig');
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel timer when controller is closed
    logInController.dispose();
    phController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    pincodeController.dispose();
    otpController.dispose();
    focusNode.dispose();
    idProofController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getForLaterUse();
    getUserData();
  }

  Future<void> saveForLaterUse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isChecked.value) {
      await prefs.setString('rememberUserNo', logInController.text);
    }
  }

  Future<void> removeLaterUse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('rememberUserNo', "");
  }

  Future<void> getForLaterUse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logInController.text = prefs.getString('rememberUserNo') ?? '';
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // To retrieve the data later:
    String? jsonString = await prefs.getString('userData');
    if (jsonString != null) {
      try {
        loginData = LoginData.fromJson(jsonDecode(jsonString));
        print("Hello ${loginData!.firstName}, ${loginData!.lastName}");
      } catch (e) {
        print("Error decoding JSON: $e");
      }
    }
  }

  Future<UserDataq> getStoredUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstName = prefs.getString('firstName') ?? '';
    String lastName = prefs.getString('lastName') ?? '';
    String wowId = prefs.getString('wowId') ?? '';
    String RoleType = prefs.getString('RoleType') ?? '';
    return UserDataq(
      firstName: firstName,
      lastName: lastName,
      wowId: wowId,
      roleType: RoleType,
    );
  }
}

class UserDataq {
  final String firstName;
  final String lastName;
  final String wowId;
  final String roleType;

  UserDataq({
    required this.firstName,
    required this.lastName,
    required this.wowId,
    required this.roleType,
  });

  // Factory method to create a UserData object from a map
  factory UserDataq.fromMap(Map<String, dynamic> map) {
    return UserDataq(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      wowId: map['wowId'] ?? '',
      roleType: map['RoleType'] ?? '',
    );
  }
}
