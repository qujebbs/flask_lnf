<?php
require_once($_SERVER['DOCUMENT_ROOT'] . "/util.php");
require_once($_SERVER['DOCUMENT_ROOT'] . "/debugUtil.php");
session_destroy();
session_unset();
redirect('/',302);
die();
