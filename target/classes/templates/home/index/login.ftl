<html xmlns="http://www.w3.org/1999/xhtml"><head>
<title>欢迎登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/home/css/login2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/home/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/home/js/login.js"></script>

</head>
<body>
<h1 style="color: #4BC0A5">${siteName!""}<sup></sup></h1>

<div class="login" style="margin-top:50px;">
    
    <div class="header">
        <div class="switch" id="switch">
            <a class="switch_btn_focus" id="switch_qlogin" href="javascript:void(0);" tabindex="7">快速登录</a>
			<a class="switch_btn" id="switch_login" href="javascript:void(0);" tabindex="8">快速注册</a>

            <div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 0px;">
            </div>
        </div>
    </div>


    <!--登录-->
    <!--登录-->
    <div class="web_login" id="web_login">
        <div class="login-box">
            <div class="login_form">
                <div id="loginCue" class="cue">欢迎登录</div>

                <form action="login" name="loginform" accept-charset="utf-8" id="login_form" class="loginForm" method="post">
                    <div class="input-group">
                        <label for="id">学号：</label>
                        <input type="text" id="login-sn" name="sn" class="inputstyle" value=""/>
                    </div>
                    <div class="input-group">
                        <label for="pwd">密码：</label>
                        <input type="password" id="pwd" name="password" class="inputstyle"/>
                    </div>
                    <div class="input-group">
                        <label for="phone">手机号：</label>
                        <input type="text" id="phone" name="phone" class="inputstyle" value=""/>
                    </div>
                    <div class="input-group">
                        <label for="code">验证码：</label>
                        <input type="text" id="code" name="code" class="inputstyle" />
                        <button id="get_code" type="button" class="button_blue">获取验证码</button>
                    </div>
                    <div class="input-group">
                        <button id="login_button" type="button" class="button_blue">登录按钮</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--登录end-->
    <!--登录end-->

  <!--注册-->
    <div class="qlogin" id="qlogin" style="display: none; ">
   
    <div class="web_login">
        <form name="form2" id="regForm" accept-charset="utf-8"  action="register" method="post">
        <ul class="reg_form" id="reg-ul">
        		<div id="userCue" class="cue">快速注册请注意格式</div>
                <li>
                	
                    <label for="user"  class="input-tips2">学号：</label>
                    <div class="inputOuter2">
                        <input type="text" id="user-sn" name="sn" maxlength="12" class="inputstyle2"/>
                    </div>
                    
                </li>
                
                <li>
                <label for="passwd" class="input-tips2">密码：</label>
                    <div class="inputOuter2">
                        <input type="password" id="password"  name="password" maxlength="16" class="inputstyle2"/>
                    </div>
                    
                </li>
                <li>
                <label for="passwd2" class="input-tips2">确认密码：</label>
                    <div class="inputOuter2">
                        <input type="password" id="password2" maxlength="16" class="inputstyle2" />
                    </div>
                    
                </li>
                
                <li>
                 <label for="qq" class="input-tips2">QQ：</label>
                    <div class="inputOuter2">
                       
                        <input type="text" id="qq" name="qq" maxlength="10" class="inputstyle2"/>
                    </div>
                   
                </li>
                
                <li>
                    <div class="inputArea">
                        <input type="button" id="reg_button"  style="margin-top:10px;margin-left:85px;" class="button_blue" value="注册成为会员"/> 
                    </div>
                    
                </li><div class="cl"></div>
            </ul>
        </form>
           
    
    </div>
   
    
    </div>
    <!--注册end-->

</div>
<div class="jianyi">*推荐使用ie8或以上版本ie浏览器或Chrome内核浏览器访问本站</div>
</body>

<script>

    var generatedVerificationCode = ""; // 用于存储生成的验证码

    function isValidPhoneNumber(phone) {
        // 使用正则表达式验证手机号是否合法
        var phonePattern = /^[1-9]\d{10}$/;
        return phonePattern.test(phone);
    }

    function generateRandomCode(length) {
        let result = '';
        const characters = '0123456789';
        const charactersLength = characters.length;
        for (let i = 0; i < length; i++) {
            result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
    }



    var canGetCode = true; // 初始状态可以获取验证码

    function enableGetCodeButton() {
        canGetCode = true;
        $("#get_code").prop("disabled", false);
        $("#get_code").text("获取验证码");
    }

    function disableGetCodeButton() {
        canGetCode = false;
        $("#get_code").prop("disabled", true);
        var count = 5;
        var countdown = setInterval(function() {
            $("#get_code").text("还有 " + count + " 秒");
            count--;
            if (count === 0) {
                clearInterval(countdown);
                enableGetCodeButton();
            }
        }, 1000);
    }

    $("#get_code").click(function () {
        if (!canGetCode) {
            return; // 如果不能获取验证码，则直接返回
        }

        var phone = $("#phone").val();

        if (!isValidPhoneNumber(phone)) {
            alert("请输入有效的手机号！");
            return;
        }

        var code = generateRandomCode(4); // 生成四位随机验证码

        // 发送手机号和验证码到后端
        $.ajax({
            type: "POST",
            url: "/send-verification-code",
            data: { phone: phone, code: code },
            success: function(data) {
                alert("验证码已发送至手机号：" + phone);
                generatedVerificationCode = code; // 将实际生成的验证码赋值给generatedVerificationCode
            }
        });

        disableGetCodeButton(); // 禁用获取验证码按钮并显示倒计时



    });








</script>








</html>