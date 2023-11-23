<?php
class DAO
{
    public function __construct($dbconfig,$user = 'root',$password = '', $opts = array())
    {
        $dns = 'mysql:' . http_build_query($dbconfig, '', ';');
        $this->db = new PDO($dns,$user,$password,$opts); 
    }

    private $db;


    public function queryDB($sql, $params = [])
    {
        $stmnt =  $this->db->prepare($sql);
        
        $stmnt->execute($params);
        return $stmnt;
    }
}