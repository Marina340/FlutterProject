<?php

$host = "localhost";
$user = "root";
$pass = "";
$dbname = "flutter";

$con = new mysqli($host, $user, $pass, $dbname);

if ($con->connect_error) {
    die("Connection failed: " . $con->connect_error);
}
    // echo "Connected to the database";
?>