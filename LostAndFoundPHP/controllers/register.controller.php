<?php
require_once($_SERVER['DOCUMENT_ROOT'] . "/util.php");
require_once($_SERVER['DOCUMENT_ROOT'] . "/debugUtil.php");

if (isset($_SESSION['userID'])) {
    redirect('/',302);
    die();
}


if (strtoupper($_SERVER['REQUEST_METHOD']) === "GET") {
    $stud_id = "";
    $username = "";
    $password_1 = "";
    $password_2 = "";
    require 'views/register.html.php';
} else {
    $studIDNum = $_POST['studID'];
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $passwordConf = $_POST['passwordConf'];
    
    if (empty($username) || empty($password)||empty($passwordConf) || empty($email) || empty($studIDNum)) {
        $error = "Please Fill All Fields";
        require('views/fragments/register_fields.php');
        die();
    }
    $entry = $dao->queryDB('CALL getUserByUsername(?)', [$username])->fetchAll();
    if (!empty($entry)) {
        $error = "Username already taken";
        require('views/fragments/register_fields.php');
        die();
    }
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = "Please Enter A Valid E-mail";
        require('views/fragments/register_fields.php');
        die();
    }
    if (strlen($password) < 8) {
        $error = "Password too short";
        require('views/fragments/register_fields.php');
        die();
    }

    if($password !== $passwordConf){
        $error = "Passwords doesn't match";
        require('views/fragments/register_fields.php');
        die();
    }
    $hash = password_hash($password, PASSWORD_ARGON2ID);
    $dao->queryDB('INSERT INTO tbl_user (col_StudNum,col_username,col_password,col_email) VALUES (?,?,?,?)', [$studIDNum,$username, $hash,$email]);
    $res = $dao->queryDB('SELECT col_userID AS userID FROM tbl_user WHERE col_username = ?',[$username])->fetch();

    if(!empty($res)){
        $_SESSION['userID'] = $res['userID'];
        $_SESSION['username'] = $username;
        $_SESSION['userEmail'] = $email;
        $_SESSION['userRole'] = 'user';
        hxRedirect('/', 303);
        die();
    }
}
