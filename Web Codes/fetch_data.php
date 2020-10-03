<?php

    //session_start();
     require('connectDB.php');
     $output='';
     if(isset($_POST["Dev_ID"])){
     	$sql = "SELECT * FROM Bus WHERE Dev_ID=?";
	$result = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($result, $sql)) {
        echo "SQL_Error_Select_driver";
        exit();
    }
    else{
        mysqli_stmt_bind_param($result, "s", $_POST["Dev_ID"]);
        mysqli_stmt_execute($result);
        $resultl = mysqli_stmt_get_result($result);
        if ($row = mysqli_fetch_assoc($resultl)){
        	if($row['C_Driver']==0){
        		$output.= '<br><br>
						<h3 class="price" align="center">LOGGED-OUT, Please Scan Driving License to Login</h3>';
        	}
        	
        	else{//Loading New Driver Data
        		$Driver=$row['C_Driver'];

        		$sql = "SELECT * FROM Driver WHERE L_No=?";
				$result = mysqli_stmt_init($conn);
    			if (!mysqli_stmt_prepare($result, $sql)) {
        		echo "SQL_Error_Select_driver";
        		exit();
    			}
    			else{
        			mysqli_stmt_bind_param($result, "s", $Driver);
        			mysqli_stmt_execute($result);
        			$resultl = mysqli_stmt_get_result($result);
        			if ($row = mysqli_fetch_assoc($resultl)){
        				$output.= '<br><br>
						<div style="border:1px solid #ccc; border-radius:5px; padding:16px; margin-bottom:16px; height:700px;">
					<h3 class="price" align="center"> Driver Details (LOGGED-IN)</h3>
					<center><img src="image/'. $row['Image'] .'" alt="" class="img-responsive" height="300" width="210"></center>
					<p align="center"><strong><a href="#" style="font-size:30px">'. $row['Name'] .'</a></strong></p>
					<h4 style="text-align:center;" class="text-danger" >'. $row['BloodGroup'] .'</h4>
					<p align="center" style="font-size:20px">License No : '. $row['L_No'].' <br />License Issue Date : '. $row['L_Issue_D'].' <br />Issuing Authority : '. $row['Issuing_Auth'].'<br /> License Validity : '. $row['L_Val_D'] .' <br />Father Name : '. $row['F_Name'].' <br />
					Address : '. $row['Address'] .'<br /> 
					Vehicle Type : '. $row['V_Type'] .' <br /> </p> 
					<h3 class="price" align="center"> Scan Your Card Again to Log Out</h3></div>';

        			}

        			}
        }
	    

     	}
     }
     	echo $output;
     }

     ?>