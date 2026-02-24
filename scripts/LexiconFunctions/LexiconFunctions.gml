global.locale = "";
global.fontRetro = fRetro;
global.fontRPG = fRPG;
global.fontRetroYOffset = 0;
global.fontRetroSpacing = 0;
global.fontRPGSpacing = 0;

function LexiconLoad() {
    global.locale = Load("global", "language", "");
    
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
                    global.locale = "zh-TW";
      				break;
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
    global.fontRetroYOffset = _config.fontRetroYOffset;
    global.fontRetroSpacing = _config.fontRetroSpacing;
    global.fontRPGSpacing = _config.fontRPGSpacing;
    
    lexicon_locale_set(_locale);
    
    with(oTitle) {
        loadMenuText();
    }
    
    if (global.locale != _locale) {
        global.locale = _locale;
        Save("global", "language", global.locale);
    }
}

function LexiconGetFont(_locale) {
    switch (_locale) {
        default: {
            return {
                fontRetro: fRetro,
                fontRPG: fRPG,
                fontRetroYOffset: 0,
                fontRetroSpacing: 9,
                fontRPGSpacing: 10
            };
        }
        case "zh-TW":
        case "zh-CN": {
            return {
                fontRetro: fRetroCN,
                fontRPG: fRetroCN,
                fontRetroYOffset: -5,
                fontRetroSpacing: 12,
                fontRPGSpacing: 12
            }
        }
        case "ja-JP": {
            return {
                fontRetro: fRetroJP,
                fontRPG: fRetroJP,
                fontRetroYOffset: -5,
                fontRetroSpacing: 12,
                fontRPGSpacing: 12
            }
        }
        case "ru-RU": {
            return {
                fontRetro: fRetro,
                fontRPG: fRPGRU,
                fontRetroYOffset: 0,
                fontRetroSpacing: 9,
                fontRPGSpacing: 10
            }
        }
    }
}
