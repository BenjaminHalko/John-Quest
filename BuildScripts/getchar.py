import json
import os

localeGroups = {
    "en-US": ["en-US", "pt-BR", "es-MX", "es-ES", "fr-FR"],
    "ru-RU": ["ru-RU"],
}

GROUP1_KEYS = ["menu", "lvl1", "lvl3"]
GROUP2_KEYS = ["lvl2"]
CREDITS_GROUP1_KEYS = ["translations", "title", "thanks1", "thanks2"]


def add_string_to_set(string, charset):
    ignore = ["\n", "\t", "\r"]
    for char in string:
        if char in ignore:
            continue
        charset.add(char)


def traverse_locale(data, charset):
    if isinstance(data, dict):
        for key in data:
            traverse_locale(data[key], charset)
    elif isinstance(data, list):
        for item in data:
            traverse_locale(item, charset)
    else:
        add_string_to_set(data, charset)


def load_locale(locale):
    filepath = os.path.join(
        os.path.dirname(__file__), "..", "datafiles", "locale", f"{locale}.json"
    )
    if not os.path.exists(filepath):
        print(f"{locale}.json not found")
        return None
    with open(filepath, "rb") as f:
        return json.loads(f.read().decode("utf-8"))


def get_charset_split(locale, charset1, charset2):
    data = load_locale(locale)
    if data is None:
        return

    add_string_to_set(data["language"], charset1)
    text = data["text"]

    # Group 1: menu, lvl1
    for key in GROUP1_KEYS:
        if key in text:
            traverse_locale(text[key], charset1)

    # Credits: split between groups
    if "credits" in text:
        for key in text["credits"]:
            if key in CREDITS_GROUP1_KEYS:
                traverse_locale(text["credits"][key], charset1)
            else:
                traverse_locale(text["credits"][key], charset2)

    # Group 2: lvl2
    for key in GROUP2_KEYS:
        if key in text:
            traverse_locale(text[key], charset2)


def save_charset(charset, filename):
    charset = sorted(charset)
    outdir = os.path.join(os.path.dirname(__file__), "charset")
    if not os.path.exists(outdir):
        os.makedirs(outdir)
    chars = "".join(charset)
    if chars:
        with open(os.path.join(outdir, f"charset_{filename}.txt"), "wb") as f:
            f.write(chars.encode("utf-8"))


def get_chars():
    for name, group in localeGroups.items():
        charset1 = set()
        charset2 = set()

        for locale in group:
            get_charset_split(locale, charset1, charset2)

        print(f"Saving {name}")
        save_charset(charset1, f"{name}_1")
        save_charset(charset2, f"{name}_2")


if __name__ == "__main__":
    get_chars()
