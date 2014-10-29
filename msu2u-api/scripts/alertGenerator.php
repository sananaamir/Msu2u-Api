<?php

$f = fopen("alerts.txt","w");

//First line of SQL Query
fwrite($f, "INSERT INTO `alerts` (`AlertID`, `CareTeamID`, `Content`, `Timestamp`) VALUES" . chr(13));

//Number of Users
$numCareTeams = 152;
$careTeamID = 1000;

//Have each care team receiving one alert
for($x=0; $x < $numCareTeams; $x++)
{
	//AlertID and CareTeamID
	$alertID = $x;
	fwrite($f, "(" . $alertID . "," . $careTeamID . ",");
	
	//Content
	$content = "Care Team #" . $careTeamID . " has moved into the next phase!";
	fwrite($f, "'" . $content . "',");
	
	//Timestamp
	//Initialize time to June 16, 2014 - 13:51
	$timestamp = 1402926660;
	//Add up to a week to the time
	$timestamp += rand(0, 604800);
	fwrite($f, $timestamp . ")");
	
	$careTeamID++;
	
	//End of line formatting
	if($x == $numCareTeams-1)
		fwrite($f, ";");
	else
		fwrite($f, "," . chr(13));
}

fclose($f);

?>