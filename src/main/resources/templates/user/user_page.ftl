<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人主页</title>
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
                    <a href="/user/${currentUser.username}">个人主页</a>
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
                    <span class="col_fade">个人信息</span>
                </div>
                <div class="inner">
                    <div class="user_card">
                        <div>
                            <a class="user_avatar"><img src="/images/avatar/${currentUser.avatar}"></a>
                            <span class="user_name"><a class="dark">${currentUser.username}</a></span>
                            <div class="space clearfix"></div>
                            <span class="signature">
                                ${currentUser.signature!"这家伙很懒，什么个性签名都没有留下。"}
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
                    </ul>
                </div>
                <div class="inner userinfo">
                    <div class="user_big_avatar">
                        <img src="/images/avatar/${currentUser.avatar}">
                    </div>
                    <a class="dark">${user.username}</a>
                    <p class="col_fade">注册时间: ${user.createdTime?number_to_datetime}</p>

                </div>
            </div>

            <div class="panel">
                <div class="header">
                    <span class="col_fade">最近创建的话题</span>
                </div>
                <#list recent_create_topics as t>
                    <div class="cell">
                        <a class="user_avatar"><img src="/images/avatar/${t.userAvatar}"></a>
                        <span class="last_time pull-right">
                            <span class="last_active_time">${t.createdTime?number_to_datetime}</span>
                        </span>

                        <div class="topic_title_wrapper">
                            <a class="topic_title" href="/topic/detail/${t.id}" title="${t.title}">
                                ${t.title}
                            </a>
                        </div>
                    </div>
                </#list>
            </div>

            <div class="panel">
                <div class="header">
                    <span class="col_fade">最近参与的话题</span>
                </div>
                <#list recent_join_topics as t>
                    <div class="cell">
                        <a class="user_avatar"><img src="/images/avatar/${t.userAvatar}"></a>
                        <span class="last_time pull-right">
                            <span class="last_active_time">${t.createdTime?number_to_datetime}</span>
                        </span>

                        <div class="topic_title_wrapper">
                            <a class="topic_title" href="/topic/detail/${t.id}" title="${t.title}">
                                ${t.title}
                            </a>
                        </div>
                    </div>
                </#list>
            </div>
        </div>
    </div>
</body>
</html>
