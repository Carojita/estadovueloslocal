<?php
$servername = "localhost";
$username = "api_user";
$password = "--4p1-Us3r++";
$dbname = "estadovuelos";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>