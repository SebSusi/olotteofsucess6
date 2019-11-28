<?php

session_start();

if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}


try
{
	$link = new PDO('mysql:host=localhost;dbname=project', 'root', '');
	array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION);
}
catch(Exception $e)
{
die('Erreur : '.$e->getMessage());
}

		if (isset($_GET['t'],$_GET['id']) AND !empty($_GET['t']) AND !empty($_GET['id'])){
			
			
			$getid =(int) $_GET['id'];
			$gett = (int) $_GET['t'];
			
			$sessionid = $_SESSION['id'];
			
			$check = $link->prepare('SELECT id FROM clubs WHERE id = ?');
			$check->execute(array($getid));
			
		if($check->rowCount() == 1) {
        if($gett == 1) {
         $check_like = $link->prepare('SELECT id FROM likes WHERE id_clubs = ? AND id_users = ?');
         $check_like->execute(array($getid,$sessionid));
         $del = $link->prepare('DELETE FROM dislikes WHERE id_clubs = ? AND id_users = ?');
         $del->execute(array($getid,$sessionid));



         if($check_like->rowCount() == 1) {
            $del = $link->prepare('DELETE FROM likes WHERE id_clubs = ? AND id_users = ?');
            $del->execute(array($getid,$sessionid));
         } else {
            $ins = $link->prepare('INSERT INTO likes (id_clubs, id_users) VALUES (?, ?)');
            $ins->execute(array($getid, $sessionid));
			
		 
		 }
			header('Location: http://localhost/Projetweb/joinclubs.php?id='.$getid);
      } 
	  
	  elseif($gett == 2) {
         $check_like = $link->prepare('SELECT id FROM dislikes WHERE id_clubs = ? AND id_users = ?');
         $check_like->execute(array($getid,$sessionid));
         $del = $link->prepare('DELETE FROM likes WHERE id_clubs = ? AND id_users = ?');
         $del->execute(array($getid,$sessionid));




         if($check_like->rowCount() == 1) {
            $del = $link->prepare('DELETE FROM dislikes WHERE id_clubs = ? AND id_users = ?');
            $del->execute(array($getid,$sessionid));
         } else {
            $ins = $link->prepare('INSERT INTO dislikes (id_clubs, id_users) VALUES (?, ?)');
            $ins->execute(array($getid, $sessionid));
         }
		header('Location: http://localhost/Projetweb/joinclubs.php?id='.$getid);
	  
	  }
	  
	  
	  elseif($gett == 3){
			$check_like = $link->prepare('SELECT id FROM usersclubs WHERE IDCLUBS = ? AND IDUSERS = ?');
			$check_like->execute(array($getid,$sessionid));
			$del = $link->prepare('DELETE FROM usersclubs WHERE IDUSERS = ? AND IDCLUBS = ?');
			$del->execute(array($getid,$sessionid));
			
			
			if($check_like->rowCount() == 1) {	
            $del = $link->prepare('DELETE FROM usersclubs WHERE IDCLUBS = ? AND IDUSERS = ?');
            $del->execute(array($getid,$sessionid));
			} 
			else {
			$ins = $link->prepare('INSERT INTO usersclubs (IDCLUBS, IDUSERS) VALUES (?, ?)');
            $ins->execute(array($getid, $sessionid));
			}
		
	  
	  header('Location: http://localhost/Projetweb/#club');
	  }
	  
		

		
			
			
		}

		


		
		
	}
		
		
		
		
		$reponse = $link->query('SELECT COUNT(likes.id_clubs)  FROM likes WHERE id_clubs = ?');
		$reponse->execute(array($getid));
		 if($donnees['likes.id_clubs']>=4){
			 $donnees['statut_clubs']==1;
			 }elseif($donnees['likes.id_clubs']<=4){
			 $donnees['statut_clubs']==0;
			 }




?>