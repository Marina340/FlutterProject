<?php
include("connect.php");

$email = $_POST['email'];
$password = $_POST['password'];
$field = $_POST['field'];
$value = $_POST['value'];

if (empty($value)) {
    echo json_encode("null");

} else {

    $sql = "UPDATE `company` SET `$field` = '$value' WHERE `email` = '$email' AND `password` = '$password'";

    $result = $con->query($sql);


    if ($result) {
        echo json_encode("done");
    }
}

?>