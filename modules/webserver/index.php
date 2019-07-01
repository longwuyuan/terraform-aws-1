<DOCTYPE html>
<head>
<title>psycopg2 demo </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
li {listt-style: none;}
</style>
</head>
<body>
</body>
</html>
<?php
$db = pg_connect("host=rds_host port=5432 dbname=pgdb user=pgdbuser password=rds_password");
$query = "CREATE TABLE IF NOT EXISTS books  (book_name text)";
$result = pg_query($query);
$query = "INSERT INTO books VALUES ('A Good Book name from inside pgdb. ')";
$result = pg_query($query);
$query = "select * from books";
$result = pg_query($query);
while ($row = pg_fetch_row($result)) {
        echo "<tr>";
        echo " 0 <td>$row[0]</td>";
        echo "</tr>";
}
pg_close($db);
?>
