
<?php

session_start();
$link = new PDO('mysql:host=localhost;dbname=project', 'root', '');
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}
	
	
	try
	{
		$link = new PDO('mysql:host=localhost;dbname=project', 'root', '');
		array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION);

	}
  catch (Exception $e)
	{
	 die('Erreur : ' . $e->getMessage()); 
	}
  




if (isset($_GET['id']) AND !empty($_GET['id'])){

	$suppr_id = htmlspecialchars($_GET['id']);
	$suppr = $link->prepare('DELETE FROM clubs WHERE id = ?');
	$suppr->execute(array($suppr_id));

	header('Location: http://localhost/Projetweb/index.php');
	
}

	

	
	?>