<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户设置</title>
    <link rel="stylesheet" type="text/css" href="/css/min.css" />
</head>
<body>
<div class="navbar">
    <div class="navbar-inner">
        <div class="container">
            <a class="brand" href="/">
                <img src="/images/logo.png">
            </a>
            <ul class="nav pull-right">
                <li><a href="/">首页</a></li>
                <li>
                    <a href="/user/${user.username}">个人主页</a>
                </li>
                <li><a href="/user/setting">用户设置</a></li>
                <li><a href="/register">注册</a></li>
                <li><a href="/login">登录</a></li>

            </ul>
            <a class="btn btn-navbar" id="responsive-sidebar-trigger">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
        </div>
    </div>
</div>
<div id="main">
    <div id="sidebar">

        <div class="panel">

            <div class="header">
                <span class="col_fade">用户设置</span>
            </div>
            <div class="inner">
                <div class="user_card">
                    <div>
                        <a class="user_avatar"><img src="/avatar.jpg"></a>
                        <span class="user_name"><a class="dark">${user.username}</a></span>
                        <div class="space clearfix"></div>
                        <span class="signature">
                            ${user.signature!"这家伙很懒，什么个性签名都没有留下。"}
                        </span>
                    </div>
                </div>


            </div>

        </div>
        <div class="panel">
            <div class="inner">
                <a href="/topic/add" id="create_topic_btn">
                    <span class="span-success">发布话题</span>
                </a>
            </div>
        </div>
    </div>
    <div id="content">
        <div class="panel">
            <div class="header">
                <ul class="breadcrumb">
                    <li><a href="/">主页</a><span class="divider">/</span></li>
                    <li class="active">设置</li>
                </ul>
            </div>
            <div class="inner">
                <form id="setting_form" class="form-horizontal" action="/user/update" method="post">
                    <div class="control-group">
                        <label class="control-label" for="name">用户名</label>
                        <div class="controls">
                            <input class="input-xlarge readonly" id="name" name="name" size="30" type="text" readonly="true" value="${user.username}">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="email">电子邮件</label>
                        <div class="controls">
                            <input class="input-xlarge" id="email" name="email" size="30" type="text" value="${user.email!""}">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="signature">个性签名</label>

                        <div class="controls">
                            <textarea class="input-xlarge" id="signature" name="signature" size="30">${user.signature!""}</textarea>
                        </div>
                    </div>
                    <input type="hidden" id="action" name="action" value="change_setting">
                    <input type="hidden" name="_csrf" value="uDC4zN11-lc-GkFuZgImWoqElxhdK0VZE8f8">

                    <div class="form-actions">
                        <input type="submit" class="span-primary submit_btn" data-loading-text="保存中.." value="保存设置">
                    </div>
                </form>
            </div>
        </div>
        <div class="panel">
            <div class="header">
                <span class="col_fade">更改密码</span>
            </div>
            <div class="inner">
                <form id="change_pass_form" class="form-horizontal" action="/user/update" method="post">
                    <div class="control-group">
                        <label class="control-label" for="old_pass">当前密码</label>
                        <div class="controls">
                            <input class="input-xlarge" type="password" id="old_pass" name="old_pass" size="30">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="new_pass">新密码</label>
                        <div class="controls">
                            <input class="input-xlarge" type="password" id="new_pass" name="new_pass" size="30">
                        </div>
                    </div>
                    <input type="hidden" id="action" name="action" value="change_password">
                    <input type="hidden" name="_csrf" value="uDC4zN11-lc-GkFuZgImWoqElxhdK0VZE8f8">

                    <div class="form-actions">
                        <input type="submit" class="span-primary submit_btn" data-loading-text="更改中.." value="更改密码">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
