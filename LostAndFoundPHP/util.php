<?php

function redirect($url, $status = 0) {
    header("Location: ". $url, true, $status);
}
function hxRedirect($url, $status = 0) {
    header("HX-Redirect: ". $url, true, $status);
}

function sanitizeData($data){
    return htmlspecialchars($data);
}

function urlis($ulr){
    return parse_url($_SERVER['REQUEST_URI'])['path'] === $ulr;
}

function isadmin(){
    return $_SESSION['userRole'] ==='admin';
}
function osPathToURLPath($path){
    return str_replace(DIRECTORY_SEPARATOR,'/', $path);
}