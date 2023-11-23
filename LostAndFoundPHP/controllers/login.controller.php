<?php
require_once($_SERVER['DOCUMENT_ROOT'] . "/util.php");
require_once($_SERVER['DOCUMENT_ROOT'] . "/debugUtil.php");

if (isset($_SESSION['userID'])) {
    redirect('/',302);
    die();
}

if (strtoupper($_SERVER['REQUEST_METHOD']) === "GET") {
    require 'views/login.html.php';
} else {
    $username = $_POST['username'];
    $password = $_POST['password'];

    if (empty($username) || empty($password)) {
        $error= 'Please Fill All Fields';
        require_once('views/fragments/login_fields.php');
        die();
    }

    $entry = $dao->queryDB('CALL getUserByUsername(?)', [$username])->fetch();


    if (empty($entry)) {
        $error= 'Username not Registered';
        require_once('views/fragments/login_fields.php');
        die();

        //should use verify_password
    } else if (password_verify($password, $entry['userPassword'])) {
        $_SESSION['userID'] = $entry['userID'];
        $_SESSION['username'] = $username;
        $_SESSION['userEmail'] = $entry['userEmail'];
        $_SESSION['userRole'] = $entry['userRole'];
        require_once('views/fragments/login_fields.php');
        hxRedirect('/',302);
        die();
    } else {
        $error= 'Wrong Password';
        require_once('views/fragments/login_fields.php');
        die();
    }
}