<DOCTYPE html>
<head>
<title>PostgreSQL with php - psycopg2 function demo </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
li {listt-style: none;}
</style>
</head>
<body>
<h2>Refresh the page repeatedly. Each refresh will add one record of the same text to the db and fetch all records. This means the webpage will get the same text showing incrementally on each refresh. Creating table book, inserting one record (one field type text) & fetching it </h2>

</body>
</html>
<?php
$db = pg_connect("host=rds_host port=5432 dbname=pgdb user=pgdbuser password=rds_password");
echo "Creating Table if not exists";
$query = "CREATE TABLE IF NOT EXISTS books  (book_name text)";
$result = pg_query($query);
echo "Inserting a record";
$query = "INSERT INTO books VALUES ('A Good Book name from inside pgdb. ')";
$result = pg_query($query);
echo "Getting the record from DB";
$query = "select * from books";
$result = pg_query($query);
while ($row = pg_fetch_row($result)) {
        echo "<tr>";
        echo "<td>$row[0]</td>";
        echo "<td>$row[1]</td>";
        echo "<td>$row[2]</td>";
        echo "<td>$row[3]</td>";
        echo "<td>$row[4]</td>";
        echo "<td>$row[5]</td>";
        echo "</tr>";
}
pg_close($db);
?>
