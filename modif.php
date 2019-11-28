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
	
} else if (isset($_POST['nomclub']) AND !empty ($_POST['nomclub'])){
	
	if(isset($_POST['desc']) AND !empty ($_POST['desc'])){
		
				
 
						$update=$link->prepare('UPDATE clubs SET clubs_title = ?, clubs_desc = ?, clubs_jour = ?, date_time_edition = NOW() WHERE id = ?');
						$update->execute(array($clubs_title, $clubs_desc, $clubs_jour, $edit_id));
						header('Location: http://localhost/Projetweb/joinclubs.php?id='.$edit_id);
						$message='Le club a été mis à jour';
				
				

		
		
		
		
	


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


<div id="creationclubs.php">
				<div id="centre">
					
					<h1>Création/Edition de club</h1>
					
					
					
					
					<form  action="modif.php" method="post" >
						
						
						
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
							
							<input id="clubs_jour" type="text" name="jour" required <?php if($mode_edition==1){ ?> value="<?=$edit_club['jours_semaine'] ?>" <?php } ?>/>
						
						
						</p>
						
						
						
						
						<p> <input type="submit"  value ="Valider"  
						</p>
						
						
						
						
						
						
						
						
						

<!--	Descriptions, notes : <textarea name="clubs_desc" id="clubs_desc"  rows=2 cols=40 maxlength=250 required > Descriptions, consignes, préférence</textarea> <br/><br/> -->
	
	
						
	
	
	
	
						
	
					</form>





</div>
</div>

</body>
</html>