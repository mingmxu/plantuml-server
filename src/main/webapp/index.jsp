<%@ page info="index" contentType="text/html; charset=utf-8" pageEncoding="utf-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="cfg" value="${applicationScope['cfg']}" />
<c:set var="contextroot" value="${pageContext.request.contextPath}" />
<c:if test="${(pageContext.request.scheme == 'http' && pageContext.request.serverPort != 80) ||
        (pageContext.request.scheme == 'https' && pageContext.request.serverPort != 443) }">
    <c:set var="port" value=":${pageContext.request.serverPort}" />
</c:if>
<c:set var="scheme" value="${(not empty header['x-forwarded-proto']) ? header['x-forwarded-proto'] : pageContext.request.scheme}" />
<c:set var="hostpath" value="${scheme}://${pageContext.request.serverName}${port}${contextroot}" />
<c:if test="${!empty encoded}">
    <c:set var="imgurl" value="${hostpath}/png/${encoded}" />
    <c:set var="svgurl" value="${hostpath}/svg/${encoded}" />
    <c:set var="txturl" value="${hostpath}/txt/${encoded}" />
    <c:if test="${!empty mapneeded}">
        <c:set var="mapurl" value="${hostpath}/map/${encoded}" />
    </c:if>
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache, must-revalidate" />
    <link rel="icon" href="${hostpath}/favicon.ico" type="image/x-icon"/> 
    <link rel="shortcut icon" href="${hostpath}/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${hostpath}/plantuml.css" />
    <link rel="stylesheet" href="${hostpath}/webjars/codemirror/3.21/lib/codemirror.css" />
    <!-- Start of CodeMirror, see https://stackoverflow.com/questions/1995370/adding-line-numbers-to-html-textarea
    <script language="javascript" type="text/javascript" src="https://codemirror.net/lib/codemirror.js"></script>
    <script language="javascript" type="text/javascript" src="https://codemirror.net/mode/shell/shell.js"></script>
    <link rel="stylesheet" type="text/css" href="https://codemirror.net/lib/codemirror.css"></link>
    <link rel="stylesheet" type="text/css" href="https://codemirror.net/theme/liquibyte.css"></link>
    End of CodeMirror -->
    <title>PlantUMLServer</title>
</head>
<body>
<%-- PAGE TITLE --%>
<div id="header">
    <h3>PlantUML Server</h3>
    <p>Resources:
        <a href="https://plantuml.com/sequence-diagram" target="_blank">Sequence</a>,
        <a href="https://plantuml.com/class-diagram" target="_blank">Class</a>,
        <a href="https://plantuml.com/component-diagram" target="_blank">Component</a>,
        <a href="https://plantuml.com/deployment-diagram" target="_blank">Deployment</a>,
        <a href="https://crashedmind.github.io/PlantUMLHitchhikersGuide/layout/layout.html" target="_blank">Layout</a>,
        <a href="https://crashedmind.github.io/PlantUMLHitchhikersGuide/color/color.html" target="_blank">Color</a>,
        <a href="https://crashedmind.github.io/PlantUMLHitchhikersGuide/diagramAnnotation/diagramAnnotation.html" target="_blank">Annotation</a>,
        <a href="https://real-world-plantuml.com/">Real World PlantUML</a>,
    </p>
</div>

<%--<div id="preurl">--%>
<%--    <p>You can enter here a previously generated URL:</p>--%>
<%--    <form method="post" action="${contextroot}/form">--%>
<%--        <p>--%>
<%--            <input type="submit" value="Restore UML"/>--%>
<%--            <input name="url" type="text" size="100" value="${imgurl}" />--%>
<%--        </p>--%>
<%--    </form>--%>
<%--</div>--%>

<%-- CONTENT --%>
<div id="content">
    <div id="umlcode">
        <form method="post" accept-charset="UTF-8"  action="${contextroot}/form">
            <p>
                <input type="submit" value="Refresh UML" />
                <textarea id="umltext" name="text" cols="120" rows="20"><c:out value="${decoded}"/></textarea>
            </p>
        </form>
    </div>

    <div id="umlimg">
        <c:if test="${!empty imgurl}">
            <a href="${svgurl}" target="_blank">View as SVG</a>&nbsp;
            <a href="${txturl}" target="_blank">View as ASCII Art</a>&nbsp;
            <c:if test="${!empty mapurl}">
                <a href="${mapurl}">View Map Data</a>
            </c:if>
            <c:if test="${cfg['SHOW_SOCIAL_BUTTONS'] == 'on' }">
                <%@ include file="resource/socialbuttons2.jspf" %>
            </c:if>
            <p id="diagram">
                <c:choose>
                    <c:when test="${!empty mapurl}">
                        <img src="${imgurl}" alt="PlantUML diagram" />
                    </c:when>
                    <c:otherwise>
                        <img src="${imgurl}" alt="PlantUML diagram" />
                    </c:otherwise>
                </c:choose>
            </p>
        </c:if>
    </div>
</div>
<%-- FOOTER --%>
<%@ include file="footer.jspf" %> 
</body>
<script type="text/javascript">
    var editor = CodeMirror.fromTextArea(document.getElementById("umltext_123"), {
        lineNumbers: true,
        mode: 'text/x-sh',
        theme: 'liquibyte',
    });
</script>
</html>
