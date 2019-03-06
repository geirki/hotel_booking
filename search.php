<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
  <form action="results.php" method="post">
  <label for="inn">Innsjekk</label>
  <input type="date" name="inn" id="inn" required />
  <label for="ut">Utsjekk</label>
  <input type="date" name="ut" id="ut" required />

  <label for="rom1">Rom 1: </label>
  <input type="number" name="rom1" min="1" max="3">
  <button type="submit">Søk</button>
</body>
</html>