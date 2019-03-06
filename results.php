<?php session_start(); ?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
<?php require('db_con.php'); 
  ini_set('display_errors', 1);
  ini_set('display_startup_errors', 1);
  error_reporting(E_ALL);
?>

  
  <p>Innsjekk: <?php echo $_POST["inn"] ?> </p>
  <p>Utsjekk: <?php echo $_POST["ut"] ?> </p>
  <p>Antall på rom 1: <?php echo $_POST["rom1"] ?> </p>

<?php 
  $statement = $con->prepare("
    SELECT rom.romnr, rom.type, romtype.beskrivelse, romtype.pris FROM rom
    JOIN romtype on rom.type = romtype.type
      LEFT JOIN reserverte_rom b
      ON (
        b.romnr = rom.romnr AND NOT (
          (b.innsjekk <= :inn AND b.utsjekk <= :inn)
           OR
          (b.innsjekk >= :ut AND b.utsjekk >= :ut)
        )
      )
    WHERE b.romnr IS NULL AND romtype.maks_sengeplasser >= :rom1
    GROUP BY rom.type ORDER BY romtype.prioritet;
  ");

  $statement->execute([
    'inn' => $_POST["inn"],
    'ut' => $_POST["ut"],
    'rom1' => $_POST["rom1"]
  ]);

  $results = $statement->fetchAll(PDO::FETCH_ASSOC);
  
if($results) {
  echo "<h2>Rom 1</h2>
        <table>
          <tr>
            <td>Type</td>
            <td>" . $results[0]["type"] ."</td>
          </tr>
          <tr>
            <td>Beskrivelse</td>
            <td>" . $results[0]["beskrivelse"] . "</td>
          </tr>
          <tr>
            <td>Pris</td>
            <td> kr " . $results[0]["pris"] . "</td>
          </tr>
        </table>";
} else {
  echo "Ingen rom funnet";
}

if(sizeof($results) > 1) {
  echo "<h3>Alternativer</h3>";
  for ($i = 1; $i < sizeof($results); $i++) {
    echo "<table>
            <tr>
              <td>Type</td>
              <td>".$results[$i]["type"]."</td>
            </tr>
            <tr>
              <td>Beskrivelse</td>
              <td>".$results[$i]["beskrivelse"]."</td>
            </tr>
            <tr>
              <td>Pris</td>
              <td> kr ".$results[$i]["pris"]."</td>
            </tr>
          </table>
          <br>";
  }
}

$_SESSION["rom1_choice"] = $results[0];
?>
<a href="reg.php">Videre</a>
  
</body>
</html>