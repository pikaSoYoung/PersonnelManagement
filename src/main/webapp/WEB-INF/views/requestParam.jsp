<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<p>
<form:form commandName="mem">
	id : <input type="text" name="id" value="${mem.id } ">
		<form:input path="id"/>
<p>
hobby : 
<form:checkbox path="hobby" value="baseball" label="�߱�"/>
<form:checkbox path="hobby" value="reding" label="����"/>

<p>
<form:radiobutton path="sex" value="man" label="����"/>
<form:radiobutton path="sex" value="woman" label="����"/>

<p>
<form:select path="selAnimal" cssClass="">
	<form:options items="${animalMap }"/> 
</form:select>
	
</form:form>
</body>
</html>