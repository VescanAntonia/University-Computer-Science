<!DOCTYPE html>
<html>
<head>
	<title>Links</title>
</head>
<body>
	<h2>Links for selected city:</h2>

	<?php
		include ('connection.php');
		$conn = OpenConnection();

		$selected_city_name = $_POST['city'];
		$selected_city_name = $conn->real_escape_string($selected_city_name);

		$query = "SELECT * FROM cities WHERE name = '$selected_city_name'";
		$result = mysqli_query($conn, $query);
		$row = mysqli_fetch_array($result);
		$selected_city_id = $row[0];

		$sql = "SELECT l.*, c1.name AS city1, c2.name AS city2, (0.6 * duration + 0.4 * distance) AS weighted_avg
				FROM links l 
				INNER JOIN cities c1 ON l.idcity1 = c1.id
				INNER JOIN cities c2 ON l.idcity2 = c2.id
				WHERE l.idcity1 = '$selected_city_id' OR l.idcity2 = '$selected_city_id'
				ORDER BY weighted_avg ASC";
		$result2 = mysqli_query($conn, $sql);
		if(mysqli_num_rows($result2) > 0){
				echo "<table>";
				echo "<tr>";
				echo "<th>City 1</th>";
				echo "<th>City 2</th>";
				echo "<th>Duration</th>";
				echo "<th>Distance</th>";
				echo "<th>Weighted Average</th>";
				echo "</tr>";
				while($row = mysqli_fetch_array($result2)){
					echo "<tr>";
					echo "<td>".$row['city1']."</td>";
					echo "<td>".$row['city2']."</td>";
					echo "<td>".$row['duration']."</td>";
					echo "<td>".$row['distance']."</td>";
					echo "<td>".$row['weighted_avg']."</td>";
					echo "</tr>";
				}
				echo "</table>";
			}
		CloseConnection($conn);
	?>

<button onclick="goBack()">Go Back</button>

<script>
function goBack() {
    window.history.back();
}
</script>

<form action="mainpage2.php" method="POST">
        <label for="city">Enter a city:</label>
        <input type="text" name="city" id="city" required>
        <input type="submit" value="Show links">
    </form>
<br>
</body>
</html>