<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>修改帖子</title>
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
    <div class="panel">
        <div class="header">
            <ol class="breadcrumb">
                <li><a href="/">主页</a><span class="divider">/</span></li>

                <li class="active">修改帖子</li>

            </ol>
        </div>
        <div class="inner post">

            <form id="create_topic_form" action="/topic/update" method="post">
                <fieldset>
                    <span id="topic_create_warn"></span>
                    <textarea autofocus="" class="span9" id="title" name="title" rows="1" placeholder="请输入标题">${topic.title}</textarea>

                    <div class="markdown_editor in_editor">
                        <div class="markdown_in_editor">
                            <textarea class="editor" name="content" rows="20">${topic.content}</textarea>
                            <div class="editor_buttons">
                                <input type="submit" class="span-primary submit_btn" data-loading-text="提交中" value="提交">
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="id" placeholder="id" value="${topic.id}">
                    <input type="hidden" name="_csrf" value="UlIdkO8C-WjRk755pPMe5vf2vT8zk44jFpR8">
                </fieldset>
            </form>
        </div>

    </div>
</div>
</body>
</html>
