<?php
namespace PhalconRest\Models;
use \PhalconRest\Exceptions\HTTPException;

class Users extends \Phalcon\Mvc\Model{

    //Table Fields
    public $ID;
    public $Name;
    public $Email;

    /**
     * These set the values for soft deletion in the database (using a deleted
     * flag instead of removing the entry)
     */

    const DELETED = 1;
    const NOT_DELETED = 0;

    /**
     * Returns the name of the table to use in the database
     * @return string
     * CareTeams now maps to the "care_teams" table
     */

    public function getSource(){
        return "users";
    }
    

}
