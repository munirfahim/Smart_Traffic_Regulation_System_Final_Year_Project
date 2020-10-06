<TABLE  id="table">
  <TR>
    <TH>Violation Name</TH>
    <TH>Bus ID</TH>
    <TH>Driver ID</TH>
    <TH>Confidence</TH>
    <TH>Violation Time</TH>
    <TH>Location</TH>
    <TH>Location Accuracy</TH>
    <TH>Speed</TH>
    <TH>Longitute</TH>
    <TH>Latitude</TH>
    <TH>Detected Image</TH>
  </TR>
<?php 
//Connect to database
require('connectDB.php');


$sql ="SELECT * FROM violation where violation_name<>'Speed_Violation' ORDER BY id DESC";
$result=mysqli_query($conn,$sql);
if (mysqli_num_rows($result) > 0)
{
  while ($row = mysqli_fetch_assoc($result))
    {
?>
   <TR>
      <TD><?php echo $row['violation_name']?></TD>
      <TD><?php echo $row['bus_id']?></TD>
      <TD><?php echo $row['driver_id']?></TD>
      <TD><?php echo $row['confidence']?></TD>
      <TD><?php echo $row['violation_time']?></TD>
      <TD><?php echo $row['loc_name']?></TD>
      <TD><?php echo $row['loc_accuracy']?></TD>
      <TD><?php echo $row['speed']?></TD>
      <TD><?php echo $row['longitude']?></TD>
      <TD><?php echo $row['latitude']?></TD>
      <TD><a href="violation/<?php echo $row['id']?>.jpg" target="_blank" title="Click">value</a> </TD>
      
   </TR>
<?php   
    }
}
?>
</TABLE>