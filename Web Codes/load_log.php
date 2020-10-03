<TABLE  id="table">
  <TR>
    <TH>Device ID</TH>
    <TH>Vehicle License</TH>
    <TH>Driver License</TH>
    <TH>Date In</TH>
    <TH>Time In</TH>
    <TH>Date Out</TH>
    <TH>Time Out</TH>
    <TH>Status</TH>
  </TR>
<?php 
//Connect to database
require('connectDB.php');

$sql ="SELECT * FROM logs ORDER BY id DESC";
$result=mysqli_query($conn,$sql);
if (mysqli_num_rows($result) > 0)
{
  while ($row = mysqli_fetch_assoc($result))
    {
?>
   <TR>
      <TD><?php echo $row['Dev_ID']?></TD>
      <TD><?php echo $row['V_License']?></TD>
      <TD><?php echo $row['Driver_ID']?></TD>
      <TD><?php echo $row['DateIn']?></TD>
      <TD><?php echo $row['TimeIn']?></TD>
      <TD><?php echo $row['DateOut']?></TD>
      <TD><?php echo $row['TimeOut']?></TD>

      <TD><?php echo $row['status']?></TD>
   </TR>
<?php   
    }
}
?>
</TABLE>