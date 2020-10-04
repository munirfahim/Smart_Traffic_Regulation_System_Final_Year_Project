<?php

//session_start();
require('connectDB.php');
//connection variables
function encodeJson($responseData) {
    $jsonResponse = json_encode($responseData);
    return $jsonResponse;		
}


if(!empty($_GET['Route'])){

$Route = $_GET['Route'];
$sql = "SELECT * FROM route WHERE Route_Name=?";
$result = mysqli_stmt_init($conn);
if (!mysqli_stmt_prepare($result, $sql)) {
    echo "SQL_Error_Select_route";
    exit();
}
else{
    mysqli_stmt_bind_param($result, "s", $Route);
    mysqli_stmt_execute($result);
    $resultl = mysqli_stmt_get_result($result);
    if ($row = mysqli_fetch_assoc($resultl)){}
    else{
    echo 'Route Not valid';
    exit();
    }

    
}
$response=encodeJson($row);
echo $response;
}
else
{
echo "No Route Given";
}




?>