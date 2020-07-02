<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>忘记密码</title>
    <link rel="stylesheet" type="text/css" href="/css/login.min.css" />
</head>
<body>
<div id="content">
    <div class="login-header">
        <img src="/images/logo.png">
    </div>
    <form action="/reset/send" method="post">
        <div class="login-input-box">
            <span class="icon icon-user"></span>
            <input type="text" name="username" placeholder="请输入帐号">
        </div>
        <button class="login-button-box">重置密码</button>
    </form>
</div>

</body>
</html>
