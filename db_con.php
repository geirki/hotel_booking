<?php
   try {
    $con = new PDO('mysql:host=localhost;dbname=martr_uin_v19','martr','pI82edmds8');
  } catch (PDOException $e) {
    die("Could not connect to database");
  }
?>