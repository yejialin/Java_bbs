<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>话题详情</title>
    <link rel="stylesheet" type="text/css" href="/css/all.css">
    <link rel="stylesheet" type="text/css" href="/css/min.css">
    <link rel="stylesheet" type="text/css" href="/css/list.min.css">
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
                        <a class="user_avatar"><img src="/avatar.jpg"></a>
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
            <div class="header topic_header">
                <span class="topic_full_title">
                    ${topic.title}
                </span>
                <div class="changes">
                    <span>
                      发布于${topic.createdTime?number_to_datetime}
                    </span>
                    <span>
                      作者 <a href="/user/${topic.userName}">${topic.userName}</a>
                    </span>
                    <span>
                      97 次浏览
                    </span>
                    <span> 来自 分享</span>
                </div>
                <div id="manage_topic">
                    <a href="/topic/edit?id=${topic.id}" class="edit_topic_btn">
                        <img src="/images/edit.png">
                    </a>
                    <a href="/topic/delete?id=${topic.id}" class="delete_topic_btn">
                        <img src="/images/delete.png">
                    </a>
                </div>
            </div>
            <div class="inner topic">

                <div class="topic_content">
                    <div class="markdown-text">
                        <p>${topic.content}</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel">
            <div class="header">
                <span class="col_fade">${comments?size} 回复</span>
            </div>
            <#list comments as c>
                <div class="cell reply_area reply_item">
                    <div class="author_content">
                        <a href="/user/${c.userName}" class="user_avatar">
                            <img src="/avatar.jpg" title=${c.userName}>
                        </a>
                        <div class="user_info">
                            <a class="dark reply_author" href="/user/${c.userName}">${c.userName}</a>
                            <a class="reply_time">${c.createdTime?number_to_datetime}</a>
                        </div>

                        <div class="user_action">
                            <a href="/topic/${topic.id}/comment/edit?id=${c.id}" class="edit_reply_btn">
                                <img src="/images/edit.png">
                            </a>
                            <a href="/topic/${topic.id}/comment/delete?id=${c.id}" class="delete_reply_btn">
                                <img src="/images/delete.png">
                            </a>
                        </div>


                    </div>
                    <div class="reply_content from-i5ting">
                        <div class="markdown-text"><p>${c.content}</p>
                        </div>
                    </div>
                </div>
            </#list>
        </div>

        <div class="panel">
            <div class="header">
                <span class="col_fade">添加回复</span>
            </div>
            <div class="inner reply">
                <form id="reply_form" action="/topic/${topic.id}/comment/add" method="post">
                    <div class="markdown_editor in_editor">
                        <div class="markdown_in_editor">
                            <textarea class="editor" name="content"></textarea>
                            <div class="editor_buttons">
                                <input class="span-primary submit_btn" type="submit" data-loading-text="回复中.." value="回复">
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="token" id="_csrf" value="${token}">
                </form>
            </div>
        </div>

    </div>
</div>

</body>
</html>