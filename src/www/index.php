<?php
echo phpinfo();die;
//连接本地的 Redis 服务
$redis = new Redis();
$redis->connect('redis', 6379);
//echo "Connection to server successfully";
//设置 redis 字符串数据
$redis->set("tutorial-name", "Redis tutorial111111");
// 获取存储的数据并输出
echo "Stored string in redis:: " . $redis->get("tutorial-name");


$servername = "mysql";
$username = "root";
$password = "123456";

try {
    $conn = new PDO("mysql:host=$servername;", $username, $password);
    echo "连接成功";
}
catch(PDOException $e)
{
    echo $e->getMessage();
}
