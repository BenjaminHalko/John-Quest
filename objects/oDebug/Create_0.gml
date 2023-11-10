/// @desc 

totalDeathCounter = 0;
deathCounter = 0;

time = 0;
totalTime = 0;

debugLog = "";

currentCheckpoint = 0;

toTime = function(_num) {
	return string(floor(_num div 60))+":"+string_replace(string_format(_num % 60,2,2)," ","0");
}


saveData = function(_skipped=false) {
	totalDeathCounter += deathCounter;
	totalTime += time;
	
	debugLog += $"Checkpoint: {currentCheckpoint}; Time: {toTime(time)}; Deaths: {deathCounter}; Total Time: {toTime(totalTime)}; Total Deaths: {totalDeathCounter}; Skipped: {_skipped}\n";
	
	deathCounter = 0;
	time = 0;
}

debugTimer = 0;