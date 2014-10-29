<?php
// This is an Immeidately Invoked Function in php.  The return value of the
// anonymous function will be returned to any file that "includes" it.
// e.g. $collection = include('example.php');
return call_user_func(function(){

    $userCollection = new \Phalcon\Mvc\Micro\Collection();

    $userCollection
        // VERSION NUMBER SHOULD BE FIRST URL PARAMETER, ALWAYS
        ->setPrefix('/v1/users')
        // Must be a string in order to support lazy loading
        ->setHandler('\PhalconRest\Controllers\UsersController')
        ->setLazy(true);

    // Set Access-Control-Allow headers.
    //$userCollection->options('/', 'optionsBase');
    $userCollection->options('/{id}', 'optionsOne');

    // First parameter is the route, which with the collection prefix here would be GET /user/
    // Second parameter is the function name of the Controller.
    $userCollection->get('/', 'get');
    // This is exactly the same execution as GET, but the Response has no body.
    $userCollection->head('/', 'get');

    // $id will be passed as a parameter to the Controller's specified function
    $userCollection->get('/{id:[0-9]+}', 'getOne');
    $userCollection->head('/{id:[0-9]+}', 'getOne');
    $userCollection->post('/', 'post');
    $userCollection->delete('/{id:[0-9]+}', 'delete');
    $userCollection->put('/{id:[0-9]+}', 'put');
    $userCollection->patch('/{id:[0-9]+}', 'patch');
	

    return $userCollection;
});
