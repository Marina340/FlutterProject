<?php
error_reporting(0);
include("connect.php");
$email = $_POST['email'];
$password = $_POST['password'];
$img=$_FILES['img']['name'];
$upload="img/".$img;
$tem_name=$_FILES['img']['tmp_name'];
move_uploaded_file($tem_name,$upload);
$sql = "UPDATE `company` SET`img` = '$img' WHERE `email` = '$email' AND `password` = '$password'";

$result = $con->query($sql);

if ($result) {
    echo json_encode("done");
}

?>