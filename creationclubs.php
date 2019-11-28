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

$mode_edition =0;


if (isset($_GET['edit']) AND !empty($_GET['edit'])){
	$mode_edition =1;
	$edit_id = htmlspecialchars($_GET['edit']);

	$edit_club = $link ->prepare('SELECT * FROM clubs WHERE id = ?');
	$edit_club->execute(array($edit_id));
			
	
	if ($edit_club->rowcount() ==1) {
		
	$edit_club=$edit_club->fetch();
	
	
	
	}else{
		die('Erreur : ce clubs n\'éxiste pas.');
	}
	
}  

	if (isset($_POST['nomclub']) AND !empty ($_POST['nomclub'])){
	
		if(isset($_POST['desc']) AND !empty ($_POST['desc'])){
		
			
			
			
			$sessionid = $_SESSION['username'];
			

				if($mode_edition==0){
					
									$req = $link->prepare("INSERT INTO `clubs` (`id`,`clubs_title`,`clubs_desc`,`jours_semaine`, 
															`statut_clubs`, `createur`,`date_time_publication`, `date_time_edition`) 
										VALUES (NULL, :clubs_title, :clubs_desc, :clubs_jour,'0', '".$sessionid."', NOW(), NULL)");
		$insertIsOk=$req->execute(array(
		"clubs_title" => htmlspecialchars ($_POST["nomclub"]),
		"clubs_desc" => htmlspecialchars ($_POST["desc"]),
		"clubs_jour" => htmlspecialchars ($_POST["jour"])));
		
		

		
		 $message = 'Votre club a bien été posté';			
				
			
				
				} else{ 


						$update=$link->prepare('UPDATE clubs SET clubs_title = :clubs_title, clubs_desc = :clubs_desc, jours_semaine = :jours_semaine, date_time_edition = NOW() WHERE id = :edit_id');
						$insertIsOk = $update->execute(array(
						"clubs_title" => htmlspecialchars ($_POST["nomclub"]),
						"clubs_desc" => htmlspecialchars ($_POST["desc"]),
						"jours_semaine" => htmlspecialchars ($_POST["jour"]),
						"edit_id" => htmlspecialchars($_GET['edit'])));
						

						if($insertIsOk){

						
						
						header('Location: http://localhost/Projetweb/creationclubs.php?edit='.$edit_id);
						$message = 'Club modifié';
										}
							else{
		
						$message = "Echec lors de la modification";
		
								}
						
						
						
				}
				

		
		
		
		
	


}
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


<div id="creation.php">
				<div id="centre">
					
					<h1>Création/Edition de club</h1>
					
					
					
					
					<form method="post" >
						
						
						
						<p>

							<label for="clubs_title"> Nom du club </label>
							
							<input id="clubs_title" type="text" name="nomclub" required <?php if($mode_edition==1){ ?> value=" <?=$edit_club['clubs_title'] ?>" <?php } ?>/>
						
						
						</p>
						
					
						
						
						<p>

							<label for="clubs_desc"> Descriptions </label>
							
							<input id="clubs_desc" type="text" name="desc" required <?php if($mode_edition==1){ ?> value="<?=$edit_club['clubs_desc'] ?>" <?php }?>/>
						
						
						</p>
						
						
						<p>

							<label for="clubs_jour"> Jours de la semaine </label>
							
							<input id="clubs_jour" type="text" name="jour" required <?php if($mode_edition==1){ ?> value="<?=$edit_club['jours_semaine'] ?>" <?php  } ?>/>
						
						
						</p>
						
						
						
						
						<p> <input type="submit"  value ="Valider"> </p> 
						
					 </form>
					
						

					

					<form action="index.php">
					<input type="submit" value="Retour" />
					</form> </br>

	<?php if(isset($message)) { echo $message; } ?>



</div>
</div>

</body>
</html>