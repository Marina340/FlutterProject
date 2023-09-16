<?php
error_reporting(0);
include("connect.php");

$email = $_POST['email'];
$password = $_POST['password'];

$sql1 = "SELECT * FROM `company` WHERE `email` = '$email' AND `password` = '$password'";
$sql = "SELECT * FROM `company`";

$result = $con->query($sql1);

while($row = $result->fetch_assoc()){
    $data[] = $row;
}

echo json_encode($data);

?>