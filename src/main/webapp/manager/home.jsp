<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - Manager Home</title>
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
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h2 class="header text-center">Giao diện quản lý danh mục</h2>
                
                <!-- Hộp tìm kiếm -->
                <div class="search-box">
                    <div class="row">
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm danh mục..." onkeyup="searchTable()">
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-primary" onclick="searchTable()">Tìm kiếm danh mục</button>
                        </div>
                        <div class="col-md-3 text-end">
                            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addModal">Thêm danh mục</button>
                        </div>
                    </div>
                </div>

                <!-- Bảng danh sách (hiển thị category của manager) -->
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
                                        <img src="${cat.icons}" alt="Icon" style="width: 50px; height: 50px;" onerror="this.src='default-icon.png'">
                                    </td>
                                    <td>
                                        <a href="/category/view?id=${cat.cateId}" class="btn btn-sm btn-info">Xem</a>
                                        <a href="/category/delete?id=${cat.cateId}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
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
                            <form method="post" action="/category/create">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="cateName" class="form-label">Tên danh mục</label>
                                        <input type="text" class="form-control" id="cateName" name="cateName" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="icons" class="form-label">Icon</label>
                                        <input type="text" class="form-control" id="icons" name="icons" placeholder="URL icon (ví dụ: icon1.png)">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Script tìm kiếm -->
    <script>
        function searchTable() {
            var input = document.getElementById("searchInput");
            var filter = input.value.toLowerCase();
            var table = document.getElementById("categoryTable");
            var tr = table.getElementsByTagName("tr");
            for (var i = 1; i < tr.length; i++) {
                var td = tr[i].getElementsByTagName("td")[1];
                if (td) {
                    var txtValue = td.textContent || td.innerText;
                    if (txtValue.toLowerCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>