<?php
  // database setup
  $hostname = "localhost";
  $dbuser = getenv("ITWS-1100-T6-USER");
  $dbpass = getenv("ITWS-1100-T6-PW");
  $dbname = "itws1100termproject";

  // set default timezone for datetime
  date_default_timezone_set('America/New_York');
?>