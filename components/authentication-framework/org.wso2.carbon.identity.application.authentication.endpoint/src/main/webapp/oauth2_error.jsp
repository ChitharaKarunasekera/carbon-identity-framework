<%--
  ~ Copyright (c) 2014, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="localize.jsp" %>
<%@include file="init-url.jsp" %>

<%
    String errorCode = request.getParameter("oauthErrorCode");
    String errorMsg = request.getParameter("oauthErrorMsg");
    String regex = "application=";
    String errorMsgContext = errorMsg;
    String errorMsgApp = "";
    String[] error = errorMsg.split(regex);
    if (error.length > 1) {
        errorMsgContext = errorMsg.split(regex)[0] + regex;
        errorMsgApp = errorMsg.split(regex)[1];
    }
%>

<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--title-->
    <jsp:directive.include file="title.jsp"/>

    <link rel="icon" href="images/favicon.png" type="image/x-icon"/>
    <link href="libs/bootstrap_3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/Roboto.css" rel="stylesheet">
    <link href="css/custom-common.css" rel="stylesheet">

    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<script type="text/javascript">
    function approved() {
        document.getElementById('consent').value = "approve";
        document.getElementById("oauth2_authz").submit();
    }
    function approvedAlways() {
        document.getElementById('consent').value = "approveAlways";
        document.getElementById("oauth2_authz").submit();
    }
    function deny() {
        document.getElementById('consent').value = "deny";
        document.getElementById("oauth2_authz").submit();
    }
</script>

<!--header-->
<jsp:directive.include file="header.jsp"/>

<!-- page content -->
<div class="container-fluid body-wrapper">

    <div class="row">
        <div class="col-md-12">

            <!-- content -->
            <div class="container col-xs-10 col-sm-6 col-md-6 col-lg-3 col-centered wr-content wr-login col-centered">
                <div>
                    <h2 class="wr-title uppercase blue-bg padding-double white boarder-bottom-blue margin-none">
                        <%=AuthenticationEndpointUtil.i18n(resourceBundle, "invalid.request")%>
                    </h2>
                </div>

                <div class="boarder-all ">
                    <div class="clearfix"></div>
                    <form action="<%=commonauthURL%>" method="post" id="oauth2_authz" name="oauth2_authz" class="form-horizontal" >
                        <div class="padding-double login-form">
                            <div id="workArea">
                                <table>
                                    <%
                                        if (errorCode != null && errorMsg != null) {
                                    %>
                                    <tr>
                                        <td><b><%=AuthenticationEndpointUtil.i18n(resourceBundle, errorCode)%>
                                        </b></td>
                                    </tr>
                                    <tr>
                                        <td><%=AuthenticationEndpointUtil.i18nBase64(resourceBundle, errorMsgContext)%><%=Encode.forHtml(errorMsgApp)%>
                                        </td>
                                    </tr>
                                    <%
                                    } else {
                                    %>
                                    <tr>
                                        <td><%=AuthenticationEndpointUtil.i18n(resourceBundle,
                                                "oauth.processing.error.msg")%></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>
                            </div>
                        </div>
                    </form>

                </div>
            </div>


        </div>
        <!-- /content -->

    </div>
</div>
<!-- /content/body -->

</div>

<!--footer-->
<jsp:directive.include file="footer.jsp"/>

<script src="libs/jquery_3.4.1/jquery-3.4.1.js"></script>
<script src="libs/bootstrap_3.4.1/js/bootstrap.min.js"></script>
</body>
</html>
