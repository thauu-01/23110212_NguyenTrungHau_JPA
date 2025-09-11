<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Category</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-container { max-width: 400px; padding: 20px; border: 1px solid #ccc; }
        .form-container input[type=text] { width: 100%; padding: 5px; }
        .form-container input[type=submit] { padding: 8px 15px; background: #007bff; color: white; border: none; cursor: pointer; }
        .form-container input[type=submit]:hover { background: #0056b3; }
        .back-link { display: inline-block; margin-top: 10px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <h1>Chi tiết Category</h1>
    <div class="form-container">
        <p><strong>ID:</strong> ${category.cateId}</p>
        <p><strong>Name:</strong> ${category.cateName}</p>
        <p><strong>Icon:</strong> ${category.icons}</p>

        <h2>Cập nhật Category</h2>
        <!-- Luôn thêm contextPath để servlet nhận đúng đường dẫn -->
        <form method="post" action="${pageContext.request.contextPath}/category/update">
            <input type="hidden" name="id" value="${category.cateId}" />
            <div>
                <label>Name:</label><br/>
                <input type="text" name="cateName" value="${category.cateName}" required />
            </div><br/>
            <div>
                <label>Icon:</label><br/>
                <input type="text" name="icons" value="${category.icons}" required />
            </div><br/>
            <input type="submit" value="Update" />
        </form>

        <a class="back-link" href="${pageContext.request.contextPath}/category/list">← Back to list</a>
    </div>
</body>
</html>
