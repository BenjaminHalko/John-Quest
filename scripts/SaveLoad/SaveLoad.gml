#macro SAVEFILE "save.ini"
function Save(_section, _key, _value) {
	ini_open(SAVEFILE);
	ini_write_real(_section, _key, _value);
	ini_close();
}

function Load(_section, _key, _default) {
	ini_open(SAVEFILE);
	var _value = ini_read_real(_section, _key, _default);
	ini_close();
	return _value;
}