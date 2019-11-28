<?php


session_start();


try
{
	$link = new PDO('mysql:host=localhost;dbname=project', 'root', '');
	array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION);
}
catch(Exception $e)
{
die('Erreur : '.$e->getMessage());
}
	
	
	if (isset($_GET['id']) AND !empty ($_GET['id'])){
	$get_id = htmlspecialchars($_GET['id']);
	$req = $link->prepare("SELECT * FROM clubs WHERE id = ?");
	$insertIsOk =	$req->execute(array($get_id));
	$sessionid = $_SESSION['id'];	
		
		if($req->rowCount() == 1){
			
			$req = $req->fetch();
			
			$id = isset($_GET['id']) ? $_GET['id'] : NULL;
			
			$club = $req['clubs_title'];
			$desc = $req['clubs_desc'];
			$jour = $req['jours_semaine'];
			
			
			$likes = $link->prepare ('SELECT id FROM likes WHERE id_clubs = ?');
			$likes->execute(array($id));
			$likes = $likes->rowcount();
			
			
			$dislikes = $link->prepare ('SELECT id FROM dislikes WHERE id_clubs = ?');
			$dislikes->execute(array($id));
			$dislikes = $dislikes->rowcount();
			

			$inscrip = $link->prepare ('SELECT id FROM usersclubs WHERE IDCLUBS = ? AND IDUSERS = ?'); //SELECT (EXISTS (SELECT 1 FROM test WHERE id = 100))::int;
			$inscrip->execute(array($id,$sessionid));
			$inscrip = $inscrip->rowcount();
			

			} 
	

	
	
	
	
	}else
	
	{
			
			die('Erreur');
		}
		
		

	

	
	
	
	

	if($insertIsOk){

		$message = 'Tout fonctionne!';

		}
	else{
		
		$message = "Echec du vote";
		
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


	<h1>	Club Sélectionné 			</h1>

	<p> <strong> Nom : </strong> <?= $club; ?> </p>
	<p>  <strong> Description : </strong> <?= $desc; ?> </p> <br/><br />
	<p>  <strong> Jour(s) : </strong> <?= $jour; ?> </p> <br/><br />
	
	<a href="php/action.php?t=1&id=<?= $id?>"><strong> J'aime</strong> </a> (<?= $likes ?>) <br /><br />
	<a href="php/action.php?t=2&id=<?= $id?>"><strong>Je n'aime pas </strong> </a> (<?= $dislikes ?>) <br /><br /><br />
	
	
  
  
  
  
  <?php if($req['statut_clubs']==1){ ?>	<a href="php/action.php?t=3&id=<?= $id?>"><strong><?php if($inscrip =='1') { ?> Quitter <?php } else { ?> Rejoindre <?php }}else{ ?> Club non validé (4 likes nécessaires) <?php } ?></strong> </a><br />
	
	
	
	
	
	<p> <?= $message; ?> </p>
	
		<form action="index.php">
    <input type="submit" value="Retour" />
	</form>

	
	

  </body>
</html>