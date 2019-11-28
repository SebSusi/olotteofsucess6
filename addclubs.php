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
	





	if (isset($_POST['nomclub']) AND !empty ($_POST['nomclub'])){
		
		
		
		
		
		
	$sessionid = $_SESSION['username'];
	$title = trim(stripslashes($_POST['nomclub']));
	$descrip = trim(stripslashes($_POST['desc']));
	$joursemaine = trim(stripslashes($_POST["jour"]));

		if (strlen($title) < 4) {
		$error['title'] = "Veuillez entrer le nom du club.";
		}
		
		if (strlen($descrip) < 10) {
		$error['descrip'] = "Veuillez entrer une description d'au moins 15 caractères.";
		}	
		
		if (strlen($joursemaine) < 4) {
		$error['joursemaine'] = "Veuillez entrer au moins 1 jour";
		}	
		
		
		
		
		
		
	
	$req = $link->prepare("INSERT INTO `clubs` (`id`,`clubs_title`,`clubs_desc`,`jours_semaine`, `statut_clubs`, `createur`,`date_time_publication`, `date_time_edition`) 
							VALUES (NULL, :clubs_title, :clubs_desc, :clubs_jour,'0', '".$sessionid."', NOW(), NULL)");
	$insertIsOk =	$req->execute(array(
		"clubs_title" => htmlspecialchars ($_POST["nomclub"]),
		"clubs_desc" => htmlspecialchars ($_POST["desc"]),
		"clubs_jour" => htmlspecialchars ($_POST["jour"])
		
		
		));
		
		}
	
	
	
	
	 else {

		$response = (isset($error['title'])) ? $error['title'] . "<br /> \n" : null;
		$response = (isset($error['descrip'])) ? $error['descrip'] . "<br /> \n" : null;
		$response = (isset($error['joursemaine'])) ? $error['joursemaine'] . "<br />" : null;

		echo $response;

	}
		
		
		
			
		

		
		
	
	
	
	if($insertIsOk){

		$message = 'Club créé!';

		}
	else{
		
		$message = "Echec lors de la création";
		
	}

	
			
?>


<!DOCTYPE html>
<html lang=fr>
  <head>
    <title>test</title>
      <meta charset="utf-8"/>
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css%22%3E">
    <link rel="stylesheet" href="page_accueil_dev_web.css">
    
  </head>
  <body>


	<h1>	Insertion du club			</h1>

	<p> <?php echo $message; ?> </p>
	
	<form action="index.php">
    <input type="submit" value="Retour" />
	</form>



  </body>
</html>
