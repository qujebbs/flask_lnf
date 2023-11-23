<?php
session_start();
require_once('DAO.php');
require_once("config.php");
require_once("debugUtil.php");
require_once('util.php');

$dbconfig = $config['database'];

try {

    $dao = new DAO($dbconfig, opts: [PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);
} catch (PDOException $e) {
    if ($_SERVER['REQUEST_URI'] != '/504'){
        redirect('/504', 302);
        require 'router.php';
    }
}

require 'router.php';