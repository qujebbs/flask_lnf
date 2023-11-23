<?php

if (!isset($_SESSION['userID'])) {
    redirect('/', 302);
    die();
}

if (strtoupper($_SERVER['REQUEST_METHOD']) !== 'POST') {
    redirect('/', 302);
    die();
}


if ($_POST['postTitle'] === '') {
    $error = 'Please enter a title';
    require_once('views/fragments/upload_fields.php');
    die();
}
$postTitle = $_POST['postTitle'];
if (strlen($postTitle) > 50) {
    $error = 'Title is too long, please keep it under 50';
    require_once('views/fragments/upload_fields.php');
    die();
}
$postDesc = $_POST['postDesc'] ?? null;

//verifiying file uploads
//chack to see if there was a file uploaded. issset or empty doesnt work because index 0 is always set to empty string
if (isset($_FILES['postFiles']['name'][0])) {
    $fileCount = count($_FILES['postFiles']['name']);
    if ($fileCount > 5) {
        redirect('/', 302);
        die();
    }
    $filesUp = $_FILES['postFiles'];
    $imgMimes = ['image/bmp', 'image/jpeg', 'image/x-png', 'image/png', 'image/gif'];
    $imgExt = ['jpeg', 'jpg', 'png', 'bmp'];

    for ($i = 0; $i < $fileCount; $i++) {
        //if this is not set, it means that the server didn't accept it (maybe because its too big)
        if ($filesUp['tmp_name'][$i] === '') {
            $error = 'Image Files might be too big';
            require_once('views/fragments/upload_fields.php');
            die();
        }

        if ($filesUp['error'][$i] !== UPLOAD_ERR_OK) {
            $error = 'Error uploading file';
            require_once('views/fragments/upload_fields.php');
            die();
        }
        if (!is_uploaded_file($filesUp['tmp_name'][$i])) {
            $error = 'Error while processing files';
            require_once('views/fragments/upload_fields.php');
            die();
        }

        $ext = pathinfo($filesUp['name'][$i], PATHINFO_EXTENSION);

        if (!in_array($ext, $imgExt)) {
            $error = 'Unsupported file extension';
            require_once('views/fragments/upload_fields.php');
            die();
        }

        if (!in_array(mime_content_type($filesUp['tmp_name'][$i]), $imgMimes)) {
            $error = 'Unsupported file type';
            require_once('views/fragments/upload_fields.php');
            die();
        }
    }
}
$postID = $dao->queryDB('CALL createpost(?,?,?,?,?)', [$postTitle, $postDesc, 1, $_SESSION['userID'], $_SESSION['userRole']])->fetch();


//saving files
if (isset($_FILES['postFiles']['name'][0])) {
    $fileCount = count($_FILES['postFiles']['name']);
    $fileUpDir = 'postPic';
    $filesUp = $_FILES['postFiles'];

    for ($i = 0; $i < $fileCount; $i++) {
        //if this is not set, it means that the server didn't accept it (maybe because its too big)
        $ext = pathinfo($filesUp['name'][$i], PATHINFO_EXTENSION);
        $newName = uniqid($postID['postID'] . '-' . $i . '-') . '.' . $ext;
        $newPath = join(DIRECTORY_SEPARATOR, [$fileUpDir, $newName]);
        move_uploaded_file($filesUp['tmp_name'][$i], $newPath);
        $dao->queryDB('Call insertpic(?,?,?)', [$postID['postID'], $newPath, $_SESSION['userRole']]);
    }
}
hxRedirect('/', 302)
    ?>