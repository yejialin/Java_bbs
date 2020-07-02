<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="/css/login.min.css" />
</head>
<body>
    <div id="content">
        <div class="login-header">
            <img src="/images/logo.png">
        </div>
        <form action="/user/login" method="post">
            <div class="login-input-box">
                <span class="icon icon-user"></span>
                <input type="text" name="username" value="test" placeholder="请输入帐号">
            </div>
            <div class="login-input-box">
                <span class="icon icon-password"></span>
                <input type="password" name="password" value="123" placeholder="请输入密码">
            </div>
            <button class="login-button-box">登录</button>
        </form>
        <div class="logon-box">
            <a href="/reset/index">忘记密码?</a>
            <a href="/register">注册</a>
        </div>
    </div>

</body>
</html>
