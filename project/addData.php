<?php
error_reporting(0);
include("connect.php");


$companyName = $_POST['companyName'];
$contactPersonName = $_POST['contactPersonName'];
$companyIndustry = $_POST['companyIndustry'];
$contactPersonPhoneNumber = $_POST['contactPersonPhoneNumber'];
$email = $_POST['email'];
$companyAddress = $_POST['companyAddress'];
$companySize = $_POST['companySize'];
$password = $_POST['password'];
$longitude = $_POST['longitude'];
$latitude = $_POST['latitude'];

$sql = "INSERT INTO `company`(`companyName`, `contactPersonName`, `companyIndustry`, `contactPersonPhoneNumber`, `email`, `companyAddress`, `companySize`, `password`, `longitude`, `latitude`) 
                        VALUES ('$companyName','$contactPersonName','$companyIndustry','$contactPersonPhoneNumber','$email','$companyAddress','$companySize','$password', '$longitude','$latitude')";

$result = $con->query($sql);

if ($result) {
    echo json_encode("done");
}

?>