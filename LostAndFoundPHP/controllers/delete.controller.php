<?php
if (!isset($_SESSION['userID'])) {
    hxRedirect('/', 302);
    die();
}

if (strtoupper($_SERVER['REQUEST_METHOD']) !== 'POST') {
    hxRedirect('/', 302);
    die();
}
if (!isset($_POST['type'])||!isset($_POST['id'])) {
    hxRedirect('/', 302);
    die();
}
if($_POST['type'] === 'lost'){
    $res = $dao->queryDB("SELECT col_userID FROM tbl_lostpost WHERE col_postID=?",[$_POST['id']])->fetch();
    if($_SESSION['userRole'] !=='admin'||(!$res && $res['col_userID'] !== $_SESSION['userID'])){
        hxRedirect('/', 302);
        die();
    }
    //delelte lost post
    $dao->queryDB('CALL deletePost(?,?)',[$_POST['id'],1]);
    echo 'lost post deleted';

}else if($_POST['type'] === 'found'){
    if ($_SESSION['userRole'] !== 'admin') {
        hxRedirect('/', 302);
        die();
    }
    //dlete lost found post
    $dao->queryDB('CALL deletePost(?,?)',[$_POST['id'],2]);
}else if($_POST['type'] === 'claimed'){
    if ($_SESSION['userRole'] !== 'admin') {
        hxRedirect('/', 302);
        die();
    }
    //dlete lost found post
    $dao->queryDB('CALL deletePost(?,?)',[$_POST['id'],2]);
}
hxRedirect('/', 200);
