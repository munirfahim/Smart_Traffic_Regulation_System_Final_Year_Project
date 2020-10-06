<?php

require('connectDB.php');



 if($_SERVER['REQUEST_METHOD']=='POST'){


 $violation_name = $_POST['violation_name'];
 $bus_id = $_POST['bus_id'];
 $driver_id = $_POST['driver_id'];
 $time = $_POST['time'];
 $loc_name = $_POST['loc_name'];
 $loc_accuracy = $_POST['loc_accuracy'];
 $speed = $_POST['speed'];
 $longitude = $_POST['longitude'];
 $latitude = $_POST['latitude'];

 if($violation_name!='Speed_Violation'){
    $confidence = $_POST['confidence'];
 }
 else{
    $confidence = '0';
 } 
    

    
    $imgcode = $_POST['imagecode'];

    $sql = "INSERT INTO violation (violation_name,bus_id,driver_id,
    confidence,violation_time,loc_name,loc_accuracy,speed,longitude,latitude)
    VALUES (? ,?, ?, ?, ?, ?, ?, ?,?,?)";
    $result = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($result, $sql)) {
        echo "SQL_Error_insert_violation";
        exit();
    }
    else{
        mysqli_stmt_bind_param($result, "ssssssssss", $violation_name,$bus_id,$driver_id,
        $confidence,$time,$loc_name,$loc_accuracy,$speed,$longitude,$latitude);
        mysqli_stmt_execute($result);
        $imagename=mysqli_insert_id($conn);
        $path = "violation/$imagename.jpg";
        file_put_contents($path,base64_decode($imgcode));
        echo "1";
    exit();
}

}