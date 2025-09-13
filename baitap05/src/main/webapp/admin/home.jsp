<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - Admin Home</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .header { background-color: #007bff; color: white; padding: 15px; border-radius: 5px 5px 0 0; }
        .search-box { background-color: #e9ecef; padding: 10px; border-radius: 5px; margin-bottom: 20px; }
        .table { font-size: 14px; }
        .add-form { background-color: #e3f2fd; padding: 20px; border-radius: 5px; margin-top: 20px; }
        .btn-primary { background-color: #007bff; border-color: #007bff; }
        .btn-primary:hover { background-color: #0056b3; }

        /* Nút đăng xuất cố định ở góc dưới bên phải */
        .logout-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #dc3545;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s ease;
            z-index: 9999;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h2 class="header text-center">Giao diện quản lý danh mục - Admin Home</h2>
                
                <!-- Hộp tìm kiếm -->
                <div class="search-box">
                    <div class="row">
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm danh mục..." onkeyup="searchTable()">
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-primary w-100" onclick="searchTable()">Tìm kiếm danh mục</button>
                        </div>
                        <div class="col-md-3 text-end">
                            <div class="btn-group w-100">
                                <button class="btn btn-success w-100" data-bs-toggle="modal" data-bs-target="#addModal">Thêm danh mục</button>
                                <a href="${pageContext.request.contextPath}/admin/view-profile" class="btn btn-info">Xem Profile</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bảng danh sách (hiển thị tất cả category cho admin) -->
                <div class="table-responsive">
                    <table class="table table-bordered table-striped" id="categoryTable">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Tên danh mục</th>
                                <th>Icon</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cat" items="${categories}">
                                <tr>
                                    <td>${cat.cateId}</td>
                                    <td>${cat.cateName}</td>
                                    <td>
                                        <!-- Đường dẫn ảnh chuẩn: /resources/images/tên-file -->
                                        <img src="${pageContext.request.contextPath}/resources/images/${cat.icons}" 
                                             alt="Icon" 
                                             style="width: 50px; height: 50px; object-fit: contain; border: 1px solid #ccc; border-radius: 5px;"
                                             onerror="this.src='${pageContext.request.contextPath}/resources/images/default-icon.png'">
                                    </td>
                                    <td>
                                        <!-- Dùng contextPath để tránh lỗi 404 -->
                                        <a href="${pageContext.request.contextPath}/category/view?id=${cat.cateId}" 
                                           class="btn btn-sm btn-info">Xem</a>
                                        <a href="${pageContext.request.contextPath}/category/delete?id=${cat.cateId}" 
                                           class="btn btn-sm btn-danger" 
                                           onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Modal Form Thêm danh mục -->
                <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="addModalLabel">Thêm danh mục</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/category/create">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="cateName" class="form-label">Tên danh mục</label>
                                        <input type="text" class="form-control" id="cateName" name="cateName" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="icons" class="form-label">Icon</label>
                                        <input type="text" class="form-control" id="icons" name="icons" 
                                               placeholder="VD: icon1.jpg hoặc icon2.jpg" required>
                                        <div class="form-text">
                                            Nhập tên file icon, ảnh phải nằm trong thư mục <b>resources/images</b>.
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-primary">Thêm mới</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Nút đăng xuất cố định ở góc dưới bên phải -->
    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Đăng xuất</a>

    <!-- Script tìm kiếm -->
    <script>
        function searchTable() {
            var input = document.getElementById("searchInput").value.toLowerCase();
            var rows = document.querySelectorAll("#categoryTable tbody tr");

            rows.forEach(row => {
                let cell = row.getElementsByTagName("td")[1];
                if (cell) {
                    let text = cell.textContent.toLowerCase();
                    row.style.display = text.includes(input) ? "" : "none";
                }
            });
        }
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>