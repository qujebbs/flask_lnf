<?php
session_start();

// initializing variables
$stud_id = "";
$username = "";
$password_1 = "";
$password_2 = "";
$errors = array();

// connect to the database
$db = mysqli_connect('localhost', 'root', '', 'lnfdb');

// REGISTER USER
if (isset($_POST['reg_user']))
{
    // receive all input values from the form
    $stud_id = mysqli_real_escape_string($db, $_POST['stud_id']);
    // remove SUM from student ID to save as int
    $stud_id_num = substr($stud_id, 8);
    $stud_id_year = substr($stud_id, 3, 4);
    $parsedstud_id_year = (int)$stud_id_year;
    $parsedstud_id_num = (int)$stud_id_num;
    $username = mysqli_real_escape_string($db, $_POST['username']);
    $password_1 = mysqli_real_escape_string($db, $_POST['password_1']);
    $password_2 = mysqli_real_escape_string($db, $_POST['password_2']);

    // form validation: ensure that the form is correctly filled ...
    if (empty($stud_id))
    {
        array_push($errors, "Student Id is required");
    }
    if (empty($username))
    {
        array_push($errors, "Username is required");
    }
    if (empty($password_1))
    {
        array_push($errors, "Password is required");
    }
    if ($password_1 != $password_2)
    {
        array_push($errors, "The passwords do not match");
    }

    // first check the database to make sure
    // a user does not already exist with the same username and/or student Id
    $user_check_query = "SELECT * FROM tblusers WHERE username='$username' OR student_id ='$stud_id' LIMIT 1";
    $result = mysqli_query($db, $user_check_query);
    $user = mysqli_fetch_assoc($result);

    if ($user)
    { // if user exists
        if ($user['username'] === $username)
        {
            array_push($errors, "Username has been taken");
        }
        if ($user['student_id'] === $stud_id)
        {
            array_push($errors, "Student Id already exists");
        }
    }

    // Register user if there are no errors in the form
    if (count($errors) == 0)
    {
        $password = md5($password_1); //Encrypt the password before saving in the database
        $query = "INSERT INTO tblusers (student_id, student_id_year, student_id_num, username, password) 
                VALUES('$stud_id','$parsedstud_id_year', '$parsedstud_id_num', '$username', '$password')";
        $query_run = mysqli_query($db, $query);

        if ($query_run)
        {
            $_SESSION['status'] = "Successfully Added!";
            $_SESSION['status_code'] = "success";
            header('Location: register.php');
        } else{
          $_SESSION['status'] = "Something went wrong!";
            $_SESSION['status_code'] = "error";
            header('Location: register.php');
        }
    }
}

// LOGIN USER
if (isset($_POST['login_user']))
{
    $username = mysqli_real_escape_string($db, $_POST['username']);
    $password = mysqli_real_escape_string($db, $_POST['password']);

    if (empty($username))
    {
        array_push($errors, "Username is required");
    }
    if (empty($password))
    {
        array_push($errors, "Password is required");
    }

    if (count($errors) == 0)
    {
        $password = md5($password);
        $query = "SELECT * FROM tblusers WHERE username='$username' AND password='$password'";
        $results = mysqli_query($db, $query);
        if (mysqli_num_rows($results) == 1)
        {
            $_SESSION['username'] = $username;
            $_SESSION['success'] = "You are now logged in";
            header('location: dashboard.php');
        }
        else
        {
            array_push($errors, "Wrong Username and Password combination");
        }
    }
}

?>
