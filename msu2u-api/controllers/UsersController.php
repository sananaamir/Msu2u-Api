<?php
namespace PhalconRest\Controllers;
use \PhalconRest\Exceptions\HTTPException,
    PhalconRest\Models\Users as Users



class UsersController extends RESTController{

    /**
     * Sets which fields may be searched against, and which fields are allowed to be returned in
     * partial responses.
     * @var array
     */

    protected $allowedFields = array(
        'search' => array('ID', 'Name', 'Email'),
        'partials' => array('ID', 'Name', 'Email')
    );

    
    public function get(){
        if($this->isSearch){
            $results = $this->search();
        } else if ($this->isSorted) {
			$result = Users::query()
				->order($this->sortFields)
				->execute();
			$results = $result->toArray();
		} else {
            $result = Users::find();
			$results = $result->toArray();
			
        }

        return $this->respond($results);
    }

        public function getOne($id){
        $result = Users::find("ID='{$id}'");
        return $result->toArray();
    }
	
    	
	
    public function post(){
        
        $user = new Users(); //create new instance of Users model (aka a new record) - 
    
        $userForm = $this->di->get('requestBody');  //call requestBody in index to grab json 
                                                //requestBody returns contents 
        //$user->UserID= $userForm->UserID;
        $user->Name= $userForm->Name;
        $user->Email= $userForm->Email;

        $user->save();
        
        if ($user->save() == true) {
            echo "Successfully added a user";
        } else {
            echo "Sorry, the following problems were generated: ";
            
        }
        
    }

    public function delete($id){
        return array('Delete / stub');
    }


    public function put($id){
        //$user set to the existing record in Users table where UserID= id in url 
        $user = Users::find("ID='{$id}'")[0];
        
        $userEdit = $this->di->get('requestBody');  //call requestBody in index to grab json object from front end
                                                //requestBody returns contents to $userEdit
      
        //for each edited field(key), change it in user record.
        foreach($userEdit as $key => $value)
        {
            $changedKey = $key;
            $user->$changedKey= $userEdit->$changedKey;
        }
        
        
        $user->update();
        
        if ($user->update() == true) {
            echo "Successfully edited a user";
        } else {
            echo "Sorry, the following problems were generated: ";
            
        }
        
    }

    public function patch($id){
        return array('Patch / stub');
    }

    public function search(){
        $records = Users::find();
        $records = $records->toArray();
        $results = array();
        foreach($records as $record){
            $match = true;
            foreach ($this->searchFields as $field => $value) {
                if(!(strpos(strtolower($record[$field]), strtolower($value)) !== FALSE)){
                    $match = false;
                }
            }
            if($match){
                $results[] = $record;
            }
        }

        return $results;
    }


}
