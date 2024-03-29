 <?php

    session_start();
    //include('database_connection.php');
    //connection variables
    
    if(!isset($_SESSION['username'])) {
                    header("location: index.php");
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
	<title>Bus Stop Violations- Smart Traffic Regulation System</title>
	<script src="js/jquery-1.10.2.min.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link href = "css/jquery-ui.css" rel = "stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Roboto+Condensed|Rubik" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">

    <style>

.export {margin: 0px 0px 10px 20px; background-color:#900C3F ;font-family:cursive;border-radius: 7px;width: 145px;height: 28px;color: #FFC300; border-color: #581845;font-size:17px}
.export:hover {cursor: pointer;background-color:#C70039}
#table {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

#table td, #table th {
    border: 1px solid #ddd;
    padding: 8px;
     opacity: 1.6;
}
</style>
</head>
<body>
	<header>
       <div class="container">
         <div id="branding">
          <h1><span class="highlight">Smart Traffic Monitoring System</span></h1>
         </div>
        <nav>
          <ul>
            <li><a href="Log.php">Driver Log</a></li>
            <li class="current">
            	<a href="Bus_Stop_Violation.php">Bus Stop Violation</a></li>
                <li><a href="Speed.php">Speed Violation</a></li>
                <li><a href="Logout.php">Logout</a></li>
          </ul>
         </nav>
       </div>
    </header> 

    <div class="container">
        <div class="row">
          <div id="Log"></div>







          </div>

    </div>

  




</body>
</html>

<script>
  $(document).ready(function(){
    setInterval(function(){
      $.ajax({
        url: "load_bus_stop_violation.php"
        }).done(function(data) {
        $('#Log').html(data);
      });
    },3000);
  });
</script>