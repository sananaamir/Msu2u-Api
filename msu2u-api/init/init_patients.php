<?php


require_once '../includes/PHP-MySQLi-Database-Class/MysqliDb.php';
require_once '../includes/hashing/PasswordHash.php';

class InitPatientTable{
    var $DbConn;
    var $users;

    /**
     * Create the patient table in the api database
     *
     * @param int $drop_table
     */
    function __construct(){
        $DbData  = json_decode(file_get_contents('../config/db.json'));
        $this->DbConn = new Mysqlidb($DbData->host, $DbData->username, $DbData->password, $DbData->databaseName);
    }


    /**
     * Create the patient table in the api database
     *
     * @param int $drop_table
     */
    function CreatePatientTable($drop_table=false){
        $sql = '
            CREATE TABLE IF NOT EXISTS `patient` (
              `patient_id` int(8) NOT NULL,
              `title` varchar(12) NOT NULL,
              `fname` varchar(32) NOT NULL,
              `middle` varchar(32) NULL,
              `lname` varchar(32) NOT NULL,
              `dob` int(14) NOT NULL,
              `street_address` varchar(32) NOT NULL,
              `city` varchar(32) NOT NULL,
              `state` varchar(16) NOT NULL,
              `zip` int(16) NOT NULL,
              `email` varchar(128) NOT NULL,
              `username` varchar(64)  NOT NULL,
              `sex` varchar(8) NOT NULL,
              `race` varchar(112) NOT NULL,
              `bmi` float(5,2) NOT NULL,
              `height` int(4) NOT NULL,
              `weight` int(4) NOT NULL,
              `salt` varchar(32) NOT NULL,
              `iterations` int(8) NOT NULL,
              `algorithm` varchar(16) NOT NULL,
              `hash` TEXT CHARACTER SET ascii NOT NULL,
              `registered` varchar(14) NULL,
              `phone` varchar(16) NOT NULL,
              `cell` varchar(16)  NULL,
              `ssn` varchar(12) NOT NULL,
              `picture_path` varchar(128) NULL,
              `picture_url` varchar(128) NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=latin1;';


        if($drop_table){
            $this->DbConn->rawQuery("drop table patient");
        }

        $this->DbConn->rawQuery($sql);

        $tables = $this->DbConn->rawQuery('show tables');

        if(in_array('patient',$tables[0])){
            return true;
        }

        return false;
    }

    /**
     * Get users from http://api.randomuser.me/
     *
     * @param int $num_users - total users
     * @param int $chunk     - get in chunks of ... (max 20)
     */
    function GetPatientData($num_users=40,$chunks=20){

        //initialize array
        $this->Users = array();

        //Loop necessary number of times to get enough random users for system
        //Api limits to 20 persons at a time
        for($Gotten=0;$Gotten<$num_users;$Gotten+=$chunks){
            $temp = json_decode(file_get_contents('http://api.randomuser.me/?results='.$chunks));

            //Person info is in an array pointed to by "results"
            //so I reach into the object, and create an array of
            //ONLY persons, nothing extra.
            foreach($temp->results as $user){
                $this->Users[] = $user->user;
            }
        }
    }


    //Load patients from api to patients table
    function LoadPatientTable($truncate_table=false){

        $MyHash = new PasswordHash();

        //Truncate table if needed (empty table, without dropping it.)
        if($truncate_table){
            $trunc = $this->DbConn->rawQuery('truncate patient');
        }

        $uid = 1;
        foreach($this->Users as $user){
            $picture_name = strrchr ($user->picture , '/');
            exec("wget {$user->picture} -O /var/www/media/images{$picture_name}");

            list($algorithm, $iterations, $salt,$hash) = explode(":",$MyHash->create_hash($user->password));

            $data = Array(
              'patient_id' => $uid,
              'title' => ucfirst(strtolower($user->name->title)),
              'fname' => ucfirst(strtolower($user->name->first)),
              'middle' => chr(rand(65,87)).".",
              'lname' => ucfirst(strtolower($user->name->last)),
              'dob' => $user->dob,
              'street_address' => ucwords(strtolower($user->location->street)),
              'city' => ucwords(strtolower($user->location->city)),
              'state' => strtoupper($user->location->state),
              'zip' => $user->location->zip,
              'email' => strtolower($user->email),
              'username' => $user->username,
              'sex' => $user->gender,
              'race' => $this->RandomRace(),
              'bmi' => rand(10,30),
              'height' => rand(48,78),
              'weight' => rand(100,300),
              'salt' => $salt,
              'iterations' => $iterations,
              'algorithm' => $algorithm,
              'hash' => $hash,
              'registered' => $user->registered,
              'phone' => $user->phone,
              'cell' => $user->cell,
              'ssn' => $user->SSN,
              'picture_path' => '/var/www/media/images'.$picture_name,
              'picture_url' => 'http://msu2u.net/media/images'.$picture_name
            );

            $id = $this->DbConn->insert('patient', $data);
            if($id)
                echo 'user was created. Id='.$id;
            $uid++;
        }

    }

    private function RandomRace(){
        $data=Array(
            'Native Hawaiian or Pacific Islander'=>20,
            'American Indian or Alaska Native'=>90,
            'Asian'=>480,
            'Black or African American'=>1260,
            'Hispanic or Latino'=>1640,
            'White'=>6510
        );
        $rand = mt_rand(0,6510);
        foreach($data as $key => $val)
            if($rand <= $val){
                return $key;
            }
    }

}

//only run this code if this file is called directly
if (!debug_backtrace()) {
    $LoadUp = new InitPatientTable();
    echo "Connected...\n";
    if($LoadUp->CreatePatientTable(true))
        echo "Table patient created....\n";
    else{
        echo "Table patient not created!! .... Exiting... \n";
        exit;
    }
    echo "Getting patient data .... \n";
    $LoadUp->GetPatientData(40);
    echo "Done! ... \n";
    echo "Loading patient table....\n";
    $LoadUp->LoadPatientTable(true);
    echo "Done! ... \n";
}
