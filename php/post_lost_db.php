<?php include("db_config.php") ?>

<?php
  // verify get request
  if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo "Need POST request.";
    return;
  }

  // extract metadata from FormData
  $first = $_POST["first"];
  $last = $_POST["last"];
  $email = $_POST["email"];
  $phone = $_POST["phone"];
  $location = $_POST["location"];
  $item_type = $_POST["item_type"];
  $color_name = $_POST["color_name"];
  $lost_timestamp = $_POST["lost_timestamp"];
  $comments = $_POST["comments"];

  
  // store image
  $new_filename = ""; // default filename

  // only if the file was passed
  if ( !empty($_FILES) && $_FILES["userImg"]["name"] !== "" ) { // still passes an empty file if none uploaded
    $image_name = basename($_FILES["userImg"]["name"]);
    $ext = pathinfo($_FILES["userImg"]["name"], PATHINFO_EXTENSION); // keep file extension (thanks https://stackoverflow.com/a/10368236)
    $new_filename = date("Ymd_His") . ".$ext"; // the path of the file on the server
    $upload_path = "../user_assets/$new_filename";

    move_uploaded_file($_FILES["userImg"]["tmp_name"], $upload_path);
  }

  // NOTE: file uploads aren't necessary for lost items but are strongly encouraged

  // put into database
  $mysqli = new mysqli($hostname, $dbuser, $dbpass, $dbname);
  
  // verify connection was established
  if ($mysqli -> connect_error) {
    die("Failed to connect to database: " . $mysqli -> connect_error);
  }
  
  // prepare query
  $statement = $mysqli->prepare("INSERT INTO lost_items (`first_name`, `last_name`, `email_address`, `phone`, `location_last_known`, `item_type`, `color_name`, `image_url`, `lost_timestamp`, `comments`) VALUES (?,?,?,?,?,?,?,?,?,?)");
  $statement->bind_param("ssssssssss", $first, $last, $email, $phone, $location, $item_type, $color_name, $new_filename, $lost_timestamp, $comments);
  $statement->execute();

  // close statement, then connection
  $statement->close();
  $mysqli->close();
?>