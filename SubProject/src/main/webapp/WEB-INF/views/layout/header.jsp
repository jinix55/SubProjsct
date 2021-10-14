<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authorize access="isAuthenticated()">
    <sec:authentication var="user" property="principal" />
</sec:authorize>
<header>
</header>
