 <?php

    //session_start();
     require('connectDB.php');
    //connection variables

	if(!empty($_GET['Dev_ID'])){

    $Bus=$_GET['Dev_ID'];
    $Driver="0";

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
        echo '<h1 class="price">INVALID DEVICE/Expired Permit Call 999 Immidiately if seen on the road </h1>';
        exit();
	    }
    }
    $Driver=$row['C_Driver'];

}
else
{
    echo "No Device ID";
}
    

    ?>




<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Cheap flats rooms accommodation inside Dhaka">
	 <meta name="keywords" content="Flat, Rent, Dhaka">
  	<meta name="author" content="Sirajum Munir Fahim">
	<title>ToLet - Find Your Home</title>
	<script src="js/jquery-1.10.2.min.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link href = "css/jquery-ui.css" rel = "stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Roboto+Condensed|Rubik" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
	<header>
      <h3 style="color:skyblue" align="center">Smart Traffic Regulation System</h1>
      <h1 style="color:red" align="center">Call 999<br>
      If any discrepency is found</h1>

    </header> 
    <div class="container">
        <div class="row">
    		<div class="col-md-6">





                        <br><br><br />
                        <div style="border:1px solid #ccc; border-radius:5px; padding:16px; margin-bottom:16px; height:700px;">
                        <h3 class="price" align="center"> Vehicle Details </h3>
                        <center><img <?php echo 'src= "image/'.$row['Bus_Image'].'"' ; ?> alt="" class="img-responsive" height="750" width="500"></center>
						<p align="center"><strong><a href="#" style="font-size:30px">License No:<?php echo $row['L_No']; ?></a></strong></p>
                        <p align="center" style="font-size:20px"> Fitness Expiry: <?php echo $row['Fitness_Exp'];?> <br /> Route Permit Expiry:<?php echo $row['R_Perm_Exp']; ?>  <br />  Vehicle Type: <?php echo $row['VType']; ?> <br /> </p>  </div>

				
            </div>
            

            <div class="col-md-6">

            	<br />
                <div class="row filter_data">

                	
                </div>
            </div>
        </div>

    </div>

  




</body>
</html>

<script>

$(document).ready(function(){

    //filter_data();

    function filter_data()
    {
        var Dev_ID= <?php echo $Bus; ?>;
        var Driver= <?php echo $Driver; ?>;
        $.ajax({
            url:"fetch_data.php",
            method:"POST",
            data:{Dev_ID:Dev_ID, Driver:Driver},
            success:function(data){
                $('.filter_data').html(data);
                console.log("success");
            }
        });
        
    }

setInterval(filter_data,5000);
});



</script>