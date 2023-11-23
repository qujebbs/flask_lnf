<?php

if (strtoupper($_SERVER['REQUEST_METHOD']) === "GET") {
    if (!isset($_SESSION['userID'])) {
        require_once('views/landing.html.php');
        die();
    }

    if (isset($_GET['type'])) {
        $type = $_GET['type'];
        $postList;
        $tblToGet;
        if ($type == 'lost') {
            $tblToGet = 1;
            if (isset($_GET['q'])) {
                $postList = $dao->queryDB('CALL getPostByItemName(?,1)', [$_GET['q']])->fetchAll();
            } else {
                $postList = $dao->queryDB('CALL getPost(1)')->fetchAll();
            }
        } else if ($type == 'found') {
            $tblToGet = 2;
            if (isset($_GET['q'])) {
                $postList = $dao->queryDB('CALL getPostByItemName(?,2)', [$_GET['q']])->fetchAll();
            } else {
                $postList = $dao->queryDB('CALL getPost(2)')->fetchAll();
            }
        } else if ($type == 'claimed') {
            $tblToGet = 2;
            if (isset($_GET['q'])) {
                $postList = $dao->queryDB('CALL getPostByItemName(?,3)', [$_GET['q']])->fetchAll();
            } else {
                $postList = $dao->queryDB('CALL getPost(3)')->fetchAll();
            }
        }
        foreach ($postList as $index => $rows) {
            $picUri = $dao->queryDB('CALL getpic(?,?)', [$rows['postID'], $tblToGet])->fetchAll();

            $picList = array();
            foreach ($picUri as $pic) {
                array_push($picList, osPathToURLPath($pic['picURI']));
            }
            $postList[$index]['postPic'] = $picList;
        }
        if (isset($_SERVER['HTTP_HX_REQUEST'])){
            require('views/fragments/feedCard.php');
            require('views/fragments/searchbar.php');
            die();
        }
        
    }


    require('views/home.html.php');
}
