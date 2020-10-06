<?php

    session_start();
    $_SESSION['message'] = '';
    $_SESSION['loginmsg']= '';
    //include('database_connection.php');
    //connection variables
    
    require('connectDB.php');

    if(!empty($_POST['login'])){


    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $username = $_POST['username'];
        $password = $_POST['password'];

            $sql="select * from Admin where (username='$username' AND password='$password');";
                $res=mysqli_query($conn,$sql);
                if (mysqli_num_rows($res) > 0) {
                // output data of each row
                $_SESSION['loginmsg'] ="Login Successful";
                $_SESSION['username'] = $username;
                

                header("location: Log.php");

                }
        
                else{
                    $_SESSION['loginmsg'] = 'Invalid Username or Password!';
                }
                $conn->close();
                }
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
	<title>STRS-DashBoard: Bus</title>
	<script src="js/jquery-1.10.2.min.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link href = "css/jquery-ui.css" rel = "stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Roboto+Condensed|Rubik" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
    <link href="//db.onlinewebfonts.com/c/a4e256ed67403c6ad5d43937ed48a77b?family=Core+Sans+N+W01+35+Light" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="css/form.css" type="text/css">
    
</head>
<body>
	<header>
      <h1 style="color:skyblue" align="center">Smart Traffic Regulation System</h1>
      

    </header> 
    <div class="container">
        <div class="row">
 		<br><br><br><br>
 		<h1 align="center">Login To Your Account</h1>
      <form class="form" action="login.php" method="post" enctype="multipart/form-data" autocomplete="off">
      <div class="alert alert-error"><?= $_SESSION['loginmsg'] ?></div>
      <input type="text" placeholder="User Name" name="username" required />
      <br>
      <input type="password" placeholder="Password" name="password" autocomplete="new-password" required />
      <br><br><br>
      <input type="submit" value="Login" name="login" class="btn btn-block btn-primary" />
      </form> 
		
        </div>

    </div>

  




</body>
</html>
