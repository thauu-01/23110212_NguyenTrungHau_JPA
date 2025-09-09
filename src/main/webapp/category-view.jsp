<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Category</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-container { max-width: 400px; padding: 20px; border: 1px solid #ccc; }
    </style>
</head>
<body>
    <h1>Chi tiết Category</h1>
    <div class="form-container">
        <p>ID: ${category.cateId}</p>
        <p>Name: ${category.cateName}</p>
        <p>Icon: ${category.icons}</p>
        <h2>Cập nhật Category</h2>
        <form method="post" action="/category/update">
            <input type="hidden" name="id" value="${category.cateId}"/>
            <div><label>Name:</label> <input type="text" name="cateName" value="${category.cateName}" required/></div><br/>
            <div><label>Icon:</label> <input type="text" name="icons" value="${category.icons}" required/></div><br/>
            <input type="submit" value="Update"/>
        </form>
        <a href="${header.referer}">Back</a>
    </div>
</body>
</html>