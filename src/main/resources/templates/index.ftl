<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="/css/min.css">
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
                            <span class="user_name">
                                <a class="dark" href="/user/${currentUser.username}">
                                    ${currentUser.username}
                                </a>
                            </span>
                            <div class="space clearfix"></div>
                            <span class="signature">
                                ${currentUser.signature!"这家伙很懒，什么个性签名都没有留下。"}
                            </span>
                        </div>
                    </div>


                </div>

            </div>
        </div>
        <div id="content">
            <div class="panel">
                <div class="header">
                    <span property="itemListElement" typeof="ListItem">
                        <a property="item" typeof="WebPage" href="/" class="home">
                            <span property="name">Gotham BBS</span>
                        </a><meta property="position" content="1">
                    </span> &gt;
                    <span property="itemListElement" typeof="ListItem"><span property="name"> 首页 </span><meta property="position" content="2"></span>
                </div>

                <div class="inner no-padding">
                    <div id="topic_list">
                        <#list topics as t>
                            <div class="cell">
                                <a class="user_avatar pull-left" href="/user/${t.userName}">
                                    <img src="/images/avatar/${t.userAvatar}" title="${t.userName}">
                                </a>

                                <span class="reply_count pull-left">
                                    <span class="count_of_replies" title="回复数">
                                        ${t.commentList?size}
                                    </span>
                                    <span class="count_seperator">/</span>
                                    <span class="count_of_visits" title="点击数">
                                        ${t.viewCount}
                                    </span>
                                </span>
                                <a class="last_time pull-right">
                                    <span class="last_active_time">${t.createdTime?number_to_datetime}</span>
                                </a>

                                <div class="topic_title_wrapper">
                                    <a class="topic_title" href="/topic/detail/${t.id}" title=${t.title}>
                                        ${t.title}
                                    </a>
                                </div>

                            </div>
                        </#list>
                    </div>
                </div>

            </div>
        </div>
    </div>

</body>
</html>