<?php
    //Connect to database
    require('connectDB.php');
//**********************************************************************************************
    //Get current date and time
    date_default_timezone_set('Asia/Damascus');
    $d = date("Y-m-d");
    $t = date("H:i:sa");

//**********************************************************************************************
    //Set Driver Function
    function SetDriver($Dev,$Driver) {
    	require('connectDB.php');
    $sql="UPDATE Bus SET C_Driver=? WHERE Dev_ID=?";
                        $result = mysqli_stmt_init($conn);
                        if (!mysqli_stmt_prepare($result, $sql)) {
                            echo "SQL_Error_update_driver";
                            exit();
                        }
                        else{
                            mysqli_stmt_bind_param($result, "ii", $Driver,$Dev);
                            mysqli_stmt_execute($result);
                            }
}


if(!empty($_GET['test'])){
    if($_GET['test'] == "test"){
        echo "The Website is online";
        exit();
    }
}

if(!empty($_GET['Dev_ID'])){

    $Bus = $_GET['Dev_ID'];

    $sql = "SELECT * FROM Bus WHERE Dev_ID=?";
    $result = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($result, $sql)) {
        echo "SQL_Error_Select_bus";
        exit();
    }
    else{
        mysqli_stmt_bind_param($result, "s", $Bus);
        mysqli_stmt_execute($result);
        $resultl = mysqli_stmt_get_result($result);
        if ($row = mysqli_fetch_assoc($resultl)){ 
            //*****************************************************
            //An existed card has been detected for Login or Logout

            if (!empty($row['L_No'])){
                $FE = $row['Fitness_Exp'];
                $RPE = $row['R_Perm_Exp'];
                $BVT = $row['VType'];
                $Bus_Lic=$row['L_No'];
            

                if($FE<$d && $RPE<$d)
                {
                	echo "bus_exp";
                	exit();
                }

                
                /////////////////////////////
                if(!empty($_GET['L_No'])){

    			$DL = $_GET['L_No'];

    			$sql = "SELECT * FROM Driver WHERE L_No=?";
    			$result = mysqli_stmt_init($conn);
    			if (!mysqli_stmt_prepare($result, $sql)) {
        			echo "SQL_Error_Select_driver";
        			exit();
    				}
    			else{
        		mysqli_stmt_bind_param($result, "s", $DL);
        		mysqli_stmt_execute($result);
        		$resultl = mysqli_stmt_get_result($result);
        		if ($row = mysqli_fetch_assoc($resultl)){ 
        			if (!empty($row['L_No'])){
                		$DL_Val = $row['L_Val_D'];
                		$VT = $row['V_Type'];
                		if($DL_Val<$d && $VT!=$BVT)
                		{
                			echo "driver_inv";
                			exit();
                		}

////////////////////////////////////////////

                $sql = "SELECT * FROM logs WHERE Driver_ID=? and status<>1";
                $result = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($result, $sql)) {
                    echo "SQL_Error_Select_logs";
                    exit();
                }
                else{
                    mysqli_stmt_bind_param($result, "s", $DL);
                    mysqli_stmt_execute($result);
                    $resultl = mysqli_stmt_get_result($result);
                    //*****************************************************

                    

                    //Login
                    if (!$row = mysqli_fetch_assoc($resultl)){


                    	//Checking if Other Drivers didnot log out from same vehicle
                   		 $sql = "SELECT * FROM logs WHERE Dev_ID=? and status<>1";
                		$result = mysqli_stmt_init($conn);
               			if (!mysqli_stmt_prepare($result, $sql)) {
                    		echo "SQL_Error_Select_logs";
                    		exit();
                		}
                		else{
                   			 mysqli_stmt_bind_param($result, "i", $Bus);
                    		 mysqli_stmt_execute($result);
                    		 $resultl = mysqli_stmt_get_result($result);
                    		 if ($row = mysqli_fetch_assoc($resultl)){
                    		 	//Logging the other Driver out
                    		 $sql="UPDATE logs SET TimeOut=CURTIME(), DateOut=CURDATE(),status=1 WHERE Dev_ID=?";
                        $result = mysqli_stmt_init($conn);
                        if (!mysqli_stmt_prepare($result, $sql)) {
                            echo "SQL_Error_insert_logout1";
                            exit();
                        }
                        else{
                            mysqli_stmt_bind_param($result, "i", $Bus);
                            mysqli_stmt_execute($result);
                            SetDriver($Bus,0);
                            }
                    		 }
                    		 //Login	
                        $sql = "INSERT INTO logs (Dev_ID, V_License, Driver_ID, TimeIn, DateIn) VALUES (? ,?, ?, CURTIME(), CURDATE())";
                        $result = mysqli_stmt_init($conn);
                        if (!mysqli_stmt_prepare($result, $sql)) {
                            echo "SQL_Error_Select_login1";
                            exit();
                        }
                        else{
                            mysqli_stmt_bind_param($result, "ssi", $Bus, $Bus_Lic, $DL);
                            mysqli_stmt_execute($result);
                            SetDriver($Bus,$DL);


                            echo "login";
                            exit();
                        }
                    }
                }
                    //*****************************************************
                    //Logout
                    else {

                    	if (!empty($row['Dev_ID']!=$Bus)){
                    	    $oldDev= $row['Dev_ID'];
                    	    $sql="UPDATE Bus SET C_Driver=0 Where Dev_ID=?";
                        $result = mysqli_stmt_init($conn);
                        if (!mysqli_stmt_prepare($result, $sql)) {
                            echo "SQL_Error_insert_logout1";
                            exit();
                        }
                        else{
                            mysqli_stmt_bind_param($result, "ssds", $oldDev);
                            mysqli_stmt_execute($result);
                    	    
                    	    
                    		 $sql="UPDATE logs SET TimeOut=CURTIME(), DateOut=CURDATE(),status=1 WHERE Driver_ID=?";
                        $result = mysqli_stmt_init($conn);
                        if (!mysqli_stmt_prepare($result, $sql)) {
                            echo "SQL_Error_insert_logout1";
                            exit();
                        }
                        else{
                            mysqli_stmt_bind_param($result, "i", $DL);
                            mysqli_stmt_execute($result);
                            
                            $sql = "INSERT INTO logs (Dev_ID, V_License, Driver_ID, TimeIn, DateIn) VALUES (? ,?, ?, CURTIME(), CURDATE())";
                        $result = mysqli_stmt_init($conn);
                        if (!mysqli_stmt_prepare($result, $sql)) {
                            echo "SQL_Error_Select_login1";
                            exit();
                        }
                        else{
                            mysqli_stmt_bind_param($result, "isi", $Bus, $Bus_Lic, $DL);
                            mysqli_stmt_execute($result);
                            SetDriver($Bus,$DL);

                            echo "login";
                            exit();

                    	}
                    }
                }
                    	}
                else{
                        
                        
                        $sql="UPDATE logs SET TimeOut=CURTIME(), DateOut=CURDATE(), status=1 WHERE Driver_ID=?";
                        $result = mysqli_stmt_init($conn);
                        if (!mysqli_stmt_prepare($result, $sql)) {
                            echo "SQL_Error_insert_logout1";
                            exit();
                        }
                        else{
                            mysqli_stmt_bind_param($result, "i", $DL);
                            mysqli_stmt_execute($result);
                            SetDriver($Bus,0);

                            echo "logout";
                            exit();
                        }
                    }
                }
            }
            //Empty Card
            
        }
            //*****************************************************
            //An available card has been detected
            
            }
            else{
                echo "invalid";
                exit();
                
                } 
        }
    }
    else{
    echo "Empty_Driver_License";
    exit();
    }
    
}
 
}
else{
        echo "invalid";
        exit();
                
}

}
}
//Empty Card ID
else{
    echo "Empty_Card_ID";
    exit();
}
mysqli_stmt_close($result);
mysqli_close($conn);
?>
