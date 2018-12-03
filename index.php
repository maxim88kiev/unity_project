<?php
require_once 'connection.php'; // подключаем скрипт
session_start();

// подключаемся к серверу
$link = mysqli_connect($host, $user, $password, $database)
or die("Ошибка " . mysqli_error($link));

function getSession($name)
{
    return isset($_SESSION[$name]) ? $_SESSION[$name] : null;
}

function getPOST($name)
{
    return isset($_POST[$name]) ? $_POST[$name] : null;
}
$row = '';
$task = getPOST('task');
$responseJson = getPOST('json');
$response = json_decode($responseJson, true);
$materials = $response[0]['materials']['2'];
// выполняем операции с базой данных
$query ="select parent_id from material_synthesis where child_id = " .$materials;
$result = mysqli_query($link, $query) or die("Ошибка " . mysqli_error($link));
$row = $result->fetch_array();
unset($row[0]);

$access_token = getPOST('access_token');

if (!isset($_SESSION['access_token'])) {
    $_SESSION['access_token'] = rand(1000, 9999);
}

if ($task != null) {
    if ($access_token == getSession('access_token')) {
        switch ($task) {
            case 'calculate':
                $value = getPOST('value');
                if (is_numeric($value)) {
                    echo '{"value":' . $value * $value . ',"error":false}';
                    die;
                } else {
                    echo '{"error":true,"status":"no numeric"}';
                }
                break;
            default:
                echo '{"error":true,"status":"no command"}';
                break;
        }
    } else {
        switch ($task) {
            case 'login':
                $login = getPOST('login');
                $password = getPOST('password');
                if ($login == 'kreng' && $password == '1234') {
                    echo '{"access_token":"' . getSession('access_token') . '","error":false , "json":"' . json_encode($row) . '"}';
//                    echo '{"access_token":"' . getSession('access_token') . '","error":false , "json":"' . $materials . '"}';
//                    echo '{"access_token":"' . getSession('access_token') . '","error":false , "json":" 123"}';
                    die;
                } else {
                    echo '{"error":true,"status":"no correct login or password"}';
                }
                break;
            default:
                echo '{"error":true,"status":"no command"}';
                break;
        }
    }
} else {
    echo '{"error":true,"status":"no task"}';
}


// закрываем подключение
mysqli_close($link);

?>
