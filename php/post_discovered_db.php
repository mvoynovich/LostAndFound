<?php include("db_config.php") ?>

<?php
  // verify post request
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
  $found_timestamp = $_POST["found_timestamp"];
  $comments = $_POST["comments"];

  
  // store image
  $new_filename = ""; // default filename

  // only if the file was passed
  if ( !empty($_FILES) && $_FILES["userImg"]["name"] !== "" ) { // still passes an empty file if none uploaded
    $image_name = basename($_FILES["userImg"]["name"]);
    $ext = pathinfo($_FILES["userImg"]["name"], PATHINFO_EXTENSION); // keep file extension (thanks https://stackoverflow.com/a/10368236)
    $new_filename = date("Ymd_His") . ".$ext"; // the path of the file on the server
    $upload_path = "../user_assets/$new_filename";

    // if the file exists, attempt 50 times to rename it (extremely unlikely as the name is based on the current time with seconds)
    // in hindsight, 50 is probably overkill, but rule #1 of development is never trust the end user (joke) -Travis
    for ($i = 1; $i <= 50 && file_exists($upload_path); $i++) {
      $new_filename = date("Ymd_His") . " ($i).$ext"; // the path of the file on the server
      $upload_path = "../user_assets/$new_filename";
    }

    move_uploaded_file($_FILES["userImg"]["tmp_name"], $upload_path);
  } else {
    echo "No files submitted.";
    return; // file upload required for discovered item
  }

  // put into database
  $mysqli = new mysqli($hostname, $dbuser, $dbpass, $dbname);
  
  // verify connection was established
  if ($mysqli -> connect_error) {
    die("Failed to connect to database: " . $mysqli -> connect_error);
  }
  
  // prepare query
  $statement = $mysqli->prepare("INSERT INTO discovered_items (`first_name`,`last_name`,`email_address`,`phone`,`location`,`item_type`,`color_name`,`image_url`,`found_timestamp`,`comments`) VALUES (?,?,?,?,?,?,?,?,?,?)");
  $statement->bind_param("ssssssssss", $first, $last, $email, $phone, $location, $item_type, $color_name, $new_filename, $found_timestamp, $comments);
  $statement->execute();

  // close statement, then connection
  $statement->close();
  $mysqli->close();
?>