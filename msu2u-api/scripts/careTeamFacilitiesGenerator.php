<?php

$f = fopen("careTeamFacilities.txt","w");

$numCareTeams = 1151;

$numUsersInFacility = 0;
$currentFacility = 100;

$visitedFacilities = array();

//First line of SQL Query
fwrite($f, "INSERT INTO `careTeamFacilities` (`PrimaryID`, `CareTeamID`, `FacilityID`) VALUES" . chr(13));

//PrimaryID
$primaryID = 1;

for($x=1000; $x<=$numCareTeams; $x++)
{
	//Generate the number of facilities for each care team to be between 1 and 5
	$numFacilities = rand(1,5);
	
	for($i=0; $i<$numFacilities; $i++)
	{
		fwrite($f, "(" . $primaryID . "," . $x . ",");
		
		//Increment the primaryID
		$primaryID++;
		
		//Find a valid random facility
		$randomFacility = rand(100,131);
		while(array_search($randomFacility, $visitedFacilities))
		{
			$randomFacility = rand(100,131);
		}
		//Mark the facility as visited
		$visitedFacilities[$i] = $randomFacility;
		
		fwrite($f, $randomFacility . ")");
		if($x == $numCareTeams && $i == ($numFacilities-1))
			fwrite($f, ";");
		else
			fwrite($f, "," . chr(13));
	}

	//Reset the visited facilities
	foreach($visitedFacilities as &$value)
	{
		$value = -1;
	}
	unset($value);
	
}

fclose($f);

?>