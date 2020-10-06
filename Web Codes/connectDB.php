<?php
/* Database connection settings */
	$servername = "localhost";
    $username = "bcgyuaxe_stms";		//put your phpmyadmin username.(default is "root") 
    $password = "Fahim1996";			//if your phpmyadmin has a password put it here.(default is "root") 
    /*
    $username = "bcgyuaxe_test";		//put your phpmyadmin username.(default is "root")
    $password = "4daeu4Dsj";			//if your phpmyadmin has a password put it here.(default is "root")
    */
    $dbname = "bcgyuaxe_stms"; 
    
    
   /* $servername = "remotemysql.com";
    $username = "UtHKnOh84N";		//put your phpmyadmin username.(default is "root")
    $password = "ZcPCXVQm03";			//if your phpmyadmin has a password put it here.(default is "root")
    $dbname = "UtHKnOh84N";
    */
	$conn = new mysqli($servername, $username, $password, $dbname);
	global $conn;
	if ($conn->connect_error) {
        die("Database Connection failed: " . $conn->connect_error);
    }
?>