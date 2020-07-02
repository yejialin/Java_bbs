<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>密码重置</title>
    <link rel="stylesheet" type="text/css" href="/css/login.min.css" />
</head>
<body>
<div id="content">
    <div class="login-header">
        <img src="/images/logo.png">
    </div>
    <form action="/reset/update" method="post">
        <div class="login-input-box">
            <span class="icon icon-password"></span>
            <input type="text" name="password" placeholder="请输入新密码">
        </div>
        <input type="hidden" name="token" value=${token}>
        <button class="login-button-box">重置密码</button>
    </form>
</div>

</body>
</html>
