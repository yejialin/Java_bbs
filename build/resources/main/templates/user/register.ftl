<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册</title>
    <link rel="stylesheet" type="text/css" href="/css/login.min.css" />
</head>
<body>
<div id="content">
    <div class="login-header">
        <img src="/images/logo.png">
    </div>
    <form action="/user/register" method="post">
        <div class="login-input-box">
            <span class="icon icon-user"></span>
            <input type="text" name="username" placeholder="请输入帐号">
        </div>
        <div class="login-input-box">
            <span class="icon icon-password"></span>
            <input type="password" name="password" placeholder="请输入密码">
        </div>
        <button class="login-button-box">注册</button>
    </form>
</div>

</body>
</html>
