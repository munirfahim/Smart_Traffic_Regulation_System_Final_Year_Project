<?php

//session_start();
require('connectDB.php');
//connection variables
function encodeJson($responseData) {
    $jsonResponse = json_encode($responseData);
    return $jsonResponse;		
}


if(!empty($_GET['Dev_ID'])){

$Bus=$_GET['Dev_ID'];

$sql = "SELECT * FROM Bus WHERE Dev_ID=? and Fitness_Exp >=CURDATE() and R_Perm_Exp >=CURDATE()";
$result = mysqli_stmt_init($conn);
if (!mysqli_stmt_prepare($result, $sql)) {
    echo "SQL_Error_Select_bus";
    exit();
}
else{
    mysqli_stmt_bind_param($result, "s", $Bus);
    mysqli_stmt_execute($result);
    $resultl = mysqli_stmt_get_result($result);
    if ($row = mysqli_fetch_assoc($resultl)){}
    else{
    echo 'Device Not valid';
    exit();
    }

    
}
$response=encodeJson($row);
echo $response;
}
else
{
echo "No Device ID";
}




?>