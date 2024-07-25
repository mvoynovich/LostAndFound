<?php include("db_config.php") ?>

<?php
  // get from database
  // verify get request
  if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo "Need GET request.";
    return;
  } else if (!isset($_GET["table"])) {
    echo "Missing \"table\" URL parameter.";
    return;
  }

  // extract url parameters
  $limit = isset($_GET["limit"]) ? (int)$_GET["limit"] : 100;
  $table = $_GET["table"];

  // verify the table is valid
  if ($table !== "discovered_items" && $table !== "lost_items") {
    echo "Invalid table: $table";
    return;
  }

  // establish database connection
  $mysqli = new mysqli($hostname, $dbuser, $dbpass, $dbname);
  
  // verify connection was established
  if ($mysqli -> connect_error) {
    die("Failed to connect to database: " . $mysqli -> connect_error);
  }
  
  // prepare query
  $statement = $mysqli->prepare("SELECT * FROM $table ORDER BY `id` DESC LIMIT ?");
  $statement->bind_param("i", $limit);
  $statement->execute();

  // get result
  $result = $statement->get_result()->fetch_all(MYSQLI_ASSOC);

  // close statement, then connection
  $statement->close();
  $mysqli->close();

  // format and return result
  $result_arr = array( "body"=>array() );

  foreach ($result as $row) {
    $result_arr["body"][] = $row;
  }

  echo json_encode($result_arr);
?>