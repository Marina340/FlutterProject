<?php
include("connect.php");

$email = $_POST['email'];
$password = $_POST['password'];

$sql = "SELECT * FROM `company` WHERE `email` = '$email' AND `password` = '$password'";

$result = $con->query($sql);

while($row = $result->fetch_assoc()){
    $data[] = $row;
}

echo json_encode($data)

?>