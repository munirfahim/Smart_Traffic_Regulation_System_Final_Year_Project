<?php
/* Database connection settings */
	$servername = "localhost";
    $username = "id12991193_fahim";		//put your phpmyadmin username.(default is "root")
    $password = "fahim";			//if your phpmyadmin has a password put it here.(default is "root")
    $dbname = "id12991193_nodemculog";
    
	$conn = new mysqli($servername, $username, $password, $dbname);
	global $conn;
	if ($conn->connect_error) {
        die("Database Connection failed: " . $conn->connect_error);
    }
?>