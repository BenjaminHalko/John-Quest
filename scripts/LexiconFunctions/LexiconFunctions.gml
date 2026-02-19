global.locale = "";
global.fontRetro = fRetro;
global.fontRPG = fRPG;
global.fontTitleYOffset = 0;

function LexiconLoad() {
    ini_open(SAVEFILE);
    global.locale = ini_read_string("global", "language", "");
    ini_close();
    
    lexicon_index_definitions("locale/definitions.json");
    if (!lexicon_locale_exists(global.locale)) {
        if (STEAM_ENABLED) {
      		var _language = steam_utils_get_steam_ui_language();
      		switch(_language) {
      			default:
      				global.locale = "en-US";
      				break;
      			case "arabic":
      				global.locale = "ar-SA";
      				break;
      			case "bulgarian":
      				global.locale = "bg-BG";
      				break;
                case "tchinese":
      			case "schinese":
      				global.locale = "zh-CN";
      				break;
      			case "czech":
      				global.locale = "cs-CZ";
      				break;
      			case "danish":
      				global.locale = "da-DK";
      				break;
      			case "dutch":
      				global.locale = "nl-NL";
      				break;
      			case "french":
      				global.locale = "fr-FR";
      				break;
      			case "german":
      				global.locale = "de-DE";
      				break;
      			case "greek":
      				global.locale = "el-GR";
      				break;
      			case "hungarian":
      				global.locale = "hu-HU";
      				break;
      			case "indonesian":
      				global.locale = "id-ID";
      				break;
      			case "italian":
      				global.locale = "it-IT";
      				break;
      			case "japanese":
      				global.locale = "ja-JA";
      				break;
      			case "koreana":
      				global.locale = "ko-KR";
      				break;
      			case "norwegian":
      				global.locale = "no-NO";
      				break;
      			case "polish":
      				global.locale = "pl-PL";
      				break;
      			case "portuguese":
      			case "brazilian":
      				global.locale = "pt-BR";
      				break;
      			case "romanian":
      				global.locale = "ro-RO";
      				break;
      			case "russian":
      				global.locale = "ru-RU";
      				break;
      			case "spanish":
                      global.locale = "es-ES";
                      break;
      			case "latam":
      				global.locale = "es-MX";
      				break;
      			case "swedish":
      				global.locale = "sv-SE";
      				break;
      			case "thai":
      				global.locale = "th-TH";
      				break;
      			case "turkish":
      				global.locale = "tr-TR";
      				break;
      			case "ukrainian":
      				global.locale = "uk-UA";
      				break;
      			case "vietnamese":
      				global.locale = "vi-VN";
      				break;
      		}
        }

		if (!lexicon_locale_exists(global.locale)) {
			global.locale = "en-US";
        }
    }
    
    LexiconSetLanguage(global.locale);
}

function LexiconSetLanguage(_locale) {
    var _config = LexiconGetFont(_locale);
    global.fontRetro = _config.fontRetro;
    global.fontRPG = _config.fontRPG;
    global.fontTitleYOffset = _config.fontTitleYOffset;
    
    lexicon_locale_set(_locale);
    
    with(oTitle) {
        loadMenuText();
    }
    
    if (global.locale != _locale) {
        global.locale = _locale;
        ini_open(SAVEFILE);
        ini_write_string("global", "language", global.locale);
        ini_close();
    }
}

function LexiconGetFont(_locale) {
    switch (_locale) {
        default: {
            return {
                fontRetro: fRetro,
                fontRPG: fRPG,
                fontTitleYOffset: 0
            };
        }
        case "zh-CN": {
            return {
                fontRetro: fRetroCN,
                fontRPG: fRetroCN,
                fontTitleYOffset: -5
            }
        }
        case "ja-JP": {
            return {
                fontRetro: fRetroJP,
                fontRPG: fRetroJP,
                fontTitleYOffset: -5
            }
        }
        case "ru-RU": {
            return {
                fontRetro: fRetro,
                fontRPG: fRPGRU,
                fontTitleYOffset: 0
            }
        }
    }
}
