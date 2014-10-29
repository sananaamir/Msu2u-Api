<?php
namespace PhalconRest\Controllers;
use \PhalconRest\Exceptions\HTTPException;

/**
 * Base RESTful Controller.
 * Supports queries with the following paramters:
 *   Searching:
 *     q=(searchField1:value1,searchField2:value2)
 *   Partial Responses:
 *     fields=(field1,field2,field3)
 *   Limits:
 *     limit=10
 *   Partials:
 *     offset=20
 *
 */
class RESTController extends \PhalconRest\Controllers\BaseController{

	/**
	 * If query string contains 'q' parameter.
	 * This indicates the request is searching an entity
	 * @var boolean
	 */
	protected $isSearch = false;

	/**
	 * If query contains 'fields' parameter.
	 * This indicates the request wants back only certain fields from a record
	 * @var boolean
	 */
	protected $isPartial = false;

	/**
	 * If query contains 'sort' parameter.
	 * This indicates the request wants to be sorted by specified field(s)
	 * @var boolean
	 */
	protected $isSorted = false;
    
    
	/**
	 * Set when there is a 'limit' query parameter
	 * @var integer
	 */
	protected $limit = null;

	/**
	 * Set when there is an 'offset' query parameter
	 * @var integer
	 */
	protected $offset = null;

    //Added by Terry ////////////////////////////////
    /**
	 * Set when there is an 'sort' query parameter
	 * @var array
	 */
	protected $sortFields = null;
    
    /**
	 * Set when there is an 'order' query parameter
	 * @var enum(asc,desc)
	 */
	protected $order = null;  
    
    //End Added by Terry /////////////////////////////
    
	/**
	 * Array of fields requested to be searched against
	 * @var array
	 */
	protected $searchFields = null;

	/**
	 * Array of fields requested to be returned
	 * @var array
	 */
	protected $partialFields = null;

	/**
	 * Sets which fields may be searched against, and which fields are allowed to be returned in
	 * partial responses.  This will be overridden in child Controllers that support searching
	 * and partial responses.
	 * @var array
	 */
	protected $allowedFields = array(
		'search' => array(),
		'partials' => array()
	);


	/**
	 * Constructor, calls the parse method for the query string by default.
	 * @param boolean $parseQueryString true Can be set to false if a controller needs to be called
	 *        from a different controller, bypassing the $allowedFields parse
	 * @return void
	 */
	public function __construct($parseQueryString = true){
		parent::__construct();
		if ($parseQueryString){
			$this->parseRequest($this->allowedFields);
		}

		return;
	}

	/**
	 * Parses out the search parameters from a request.
	 * Unparsed, they will look like this:
	 *    (name:Benjamin Framklin,location:Philadelphia)
	 * Parsed:
	 *     array('name'=>'Benjamin Franklin', 'location'=>'Philadelphia')
	 * @param  string $unparsed Unparsed search string
	 * @return array            An array of fieldname=>value search parameters
	 */
	protected function parseSearchParameters($unparsed){

		// Strip parens that come with the request string
		$unparsed = trim($unparsed, '()');

		// Now we have an array of "key:value" strings.
		$splitFields = explode(',', $unparsed);
		$mapped = array();

		// Split the strings at their colon, set left to key, and right to value.
		foreach ($splitFields as $field) {
			$splitField = explode(':', $field);
			$mapped[$splitField[0]] = $splitField[1];
		}

		return $mapped;
	}

	/**
	 * Parses out partial fields to return in the response.
	 * Unparsed:
	 *     (id,name,location)
	 * Parsed:
	 *     array('id', 'name', 'location')
	 * @param  string $unparsed Unparsed string of fields to return in partial response
	 * @return array            Array of fields to return in partial response
	 */
	protected function parsePartialFields($unparsed){
		return explode(',', trim($unparsed, '()'));
	}

	/**
	 * Parses out sort fields to return in the response.
	 * Unparsed:
	 *     (state:desc,last_name:asc)
	 * Parsed:
	 *     "state desc,last_name asc"
	 * @param  string - $unparsed Unparsed string of fields to return in a sorted response
	 * @return string - Trimmed up string with colons replaced with spaces.
	 */
	protected function parseSortFields($unparsed){
        
        $order_by = "";
        
		// Strip parens that come with the request string
		$unparsed = trim($unparsed, '()');

		// Now we have an array of "key:value" strings.
		$splitFields = explode(',', $unparsed);

		// Split the strings at their colon, set left to key, and right to value.
		foreach ($splitFields as $field) {
			$splitField = explode(':', $field);

            if(!in_array($splitField[0],$this->allowedFields['search'])){
                throw new HTTPException(
                    "The fields in your sort are not searchable.",
                    401,
                    array(
                        'dev' => 'You requested to sort on fields that are not available to be searched with.',
                        'internalCode' => 'S1001',
                        'more' => '' // Could have link to documentation here.
                ));
            }
            if(!in_array($splitField[1],array('asc','desc'))){
                throw new HTTPException(
                    "There is no order by direction for each field.",
                    401,
                    array(
                        'dev' => 'You requested to sort on fields without providing a direction,or you provided something other than "asc" or "desc".',
                        'internalCode' => 'S1002',
                        'more' => 'sort=(field1:asc,field2:desc)' // Could have link to documentation here.
                ));
            }            
            $order_by .= $splitField[0]." ".$splitField[1].",";
		}
		return trim($order_by, ',');
	}
    
	/**
	 * Main method for parsing a query string.
	 * Finds search paramters, partial response fields, limits, and offsets.
	 * Sets Controller fields for these variables.
	 *
	 * @param  array $allowedFields Allowed fields array for search and partials
	 * @return boolean              Always true if no exception is thrown
	 */
	protected function parseRequest($allowedFields){
		$request = $this->di->get('request');
		$searchParams = $request->get('q', null, null);
		$fields = $request->get('fields', null, null);
        $sortFields = $request->get('sort', null, null);

		// Set limits and offset, elsewise allow them to have defaults set in the Controller
		$this->limit = ($request->get('limit', null, null)) ?: $this->limit;
		$this->offset = ($request->get('offset', null, null)) ?: $this->offset;

		// If there's a 'q' parameter, parse the fields, then determine that all the fields in the search
		// are allowed to be searched from $allowedFields['search']
		if($searchParams){
			$this->isSearch = true;
			$this->searchFields = $this->parseSearchParameters($searchParams);

			// This handly snippet determines if searchFields is a strict subset of allowedFields['search']
			if(array_diff(array_keys($this->searchFields), $this->allowedFields['search'])){
				throw new HTTPException(
					"The fields you specified cannot be searched.",
					401,
					array(
						'dev' => 'You requested to search fields that are not available to be searched.',
						'internalCode' => 'S1000',
						'more' => '' // Could have link to documentation here.
				));
			}
		}

		// If there's a 'fields' parameter, this is a partial request.  Ensures all the requested fields
		// are allowed in partial responses.
		if($fields){
			$this->isPartial = true;
			$this->partialFields = $this->parsePartialFields($fields);

			// Determines if fields is a strict subset of allowed fields
			if(array_diff($this->partialFields, $this->allowedFields['partials'])){
				throw new HTTPException(
					"The fields you asked for cannot be returned.",
					401,
					array(
						'dev' => 'You requested to return fields that are not available to be returned in partial responses.',
						'internalCode' => 'P1000',
						'more' => '' // Could have link to documentation here.
				));
			}
		}
        
        //Added by Terry
        //If there's a 'sort' parameter, this 'get' request wants to be ordered by 1 or more columns
        if($sortFields){
            $this->isSorted = true;
            $this->sortFields = $this->parseSortFields($sortFields);

        }

		return true;
	}

	/**
	 * Provides a base CORS policy for routes like '/users' that represent a Resource's base url
	 * Origin is allowed from all urls.  Setting it here using the Origin header from the request
	 * allows multiple Origins to be served.  It is done this way instead of with a wildcard '*'
	 * because wildcard requests are not supported when a request needs credentials.
	 *
	 * @return true
	 */
	public function optionsBase(){
		$response = $this->di->get('response');
		$response->setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, HEAD');
        	$response->setHeader('Access-Control-Allow-Origin', '*');
		$response->setHeader('Access-Control-Allow-Credentials', 'true');
		$response->setHeader('Access-Control-Allow-Headers', "origin, x-requested-with, content-type");
		$response->setHeader('Access-Control-Max-Age', '86400');
		return true;
	}

	/**
	 * Provides a CORS policy for routes like '/users/123' that represent a specific resource
	 *
	 * @return true
	 */
	public function optionsOne(){
		$response = $this->di->get('response');
		$response->setHeader('Access-Control-Allow-Methods', 'GET, PUT, PATCH, DELETE, OPTIONS, HEAD');
        	$response->setHeader('Access-Control-Allow-Origin', $this->di->get('request')->header('Origin'));
		$response->setHeader('Access-Control-Allow-Credentials', 'true');
		$response->setHeader('Access-Control-Allow-Headers', "origin, x-requested-with, content-type");
		$response->setHeader('Access-Control-Max-Age', '86400');
		return true;
	}

	/**
	 * Should be called by methods in the controllers that need to output results to the HTTP Response.
	 * Ensures that arrays conform to the patterns required by the Response objects.
	 *
	 * @param  array $recordsArray Array of records to format as return output
	 * @return array               Output array.  If there are records (even 1), every record will be an array ex: array(array('id'=>1),array('id'=>2))
	 */
    /*
	protected function respond($recordsArray){

		if(!is_array($recordsArray)){
			// This is bad.  Throw a 500.  Responses should always be arrays.
			throw new HTTPException(
				"An error occured while retrieving records.",
				500,
				array(
					'dev' => 'The records returned were malformed.',
					'internalCode' => 'RESP1000',
					'more' => ''
				)
			);
		}

		// No records returned, so return an empty array
		if(count($recordsArray) < 1){
			return array();
		}

		return array($recordsArray);

	}*/
    
    public function respond($results){
        if($this->isPartial){
            $newResults = array();
            $remove = array_diff(array_keys($results[0]), $this->partialFields);
            foreach($results as $record){
                $newResults[] = $this->array_remove_keys($record, $remove);
            }
            $results = $newResults;
        }
        if($this->offset){
            $results = array_slice($results, $this->offset);
        }
        if($this->limit){
            $results = array_slice($results, 0, $this->limit);
        }
        return $results;
    }
    
    private function array_remove_keys($array, $keys = array()) {

	    // If array is empty or not an array at all, don't bother
	    // doing anything else.
	    if(empty($array) || (! is_array($array))) {
	        return $array;
	    }

	    // At this point if $keys is not an array, we can't do anything with it.
	    if(! is_array($keys)) {
	        return $array;
	    }

	    // array_diff_key() expected an associative array.
	    $assocKeys = array();
	    foreach($keys as $key) {
	        $assocKeys[$key] = true;
	    }

	    return array_diff_key($array, $assocKeys);
	}


}
