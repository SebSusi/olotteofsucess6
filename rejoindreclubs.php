<?php
session_start();

if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}




?>



<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Bonjour</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css%22%3E">
    <link rel="stylesheet" href="page_accueil_dev_web.css">



</head>
<body>


<div id="join">
				<div id="centre">
					<h1>Rejoindre clubs</h1>

					
				 <?php
	try
	{
		$link = new PDO('mysql:host=localhost;dbname=project', 'root', '');
		array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION);

	}
  
  catch (Exception $e)
	{
	 die('Erreur : ' . $e->getMessage()); 
	}
  
  
  
 
  
  
  
  
  $reponse = $link->query('SELECT * FROM clubs');
  
  
	while ($donnees = $reponse->fetch())
	{
		?>
	<p>
	<strong> Club</strong> : <?php echo $donnees['clubs_title']; ?> <br />



		
		
		
		<form action="joinclubs.php" method="get" id="join" >
					<a href="joinclubs.php?id=<?= $donnees['id']?>"><strong>Afficher</strong></a> 	
					
					<?php if($donnees['createur']==$_SESSION["username"]){?>
					
					<a href="creationclubs.php?edit=<?= $donnees['id'] ?>"><strong>Modifier</strong></a> 
					<a href="supprimer.php?id=<?= $donnees['id'] ?>"><strong>Supprimer <?php } ?></strong></a> <br />
     
		</form> 
		  
		
		<br/>
	</p>
  <?php
	
	
	}
	$reponse->closeCursor();
	?>



				</div>
	</div>


</body>
</html>