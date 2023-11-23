<?php
if (!isset($_SESSION['userID'])) {
    hxRedirect('/', 302);
    die();
}

if (strtoupper($_SERVER['REQUEST_METHOD']) !== 'POST') {
    hxRedirect('/', 302);
    die();
}
if ($_SESSION['userRole'] !== 'admin') {
    hxRedirect('/', 302);
    die();
}

if (!isset($_POST['id'])||!isset($_POST['from'])) {
    hxRedirect('/', 302);
    die();
}

if($_POST['from'] === 'found'&&!isset($_POST['claimant'])){
    hxRedirect('/', 302);
    die();
}

if($_POST['from']==='found'){
    $dao->queryDB('CALL make_Claimed(?,?)', [$_POST['id'],$_POST['claimant']]);
}else if($_POST['from']==='claimed'){
    $dao->queryDB('CALL make_Unclaimed(?)', [$_POST['id']]);
}
hxRedirect('/', 200);
