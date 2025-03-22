<%-- 
    Document   : payment
    Created on : Mar 20, 2025, 10:44:45 PM
    Author     : minht
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thanh Toán Buổi Học</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f7f7f7;
                text-align: center;
                margin-top: 50px;
            }
            .payment-box {
                background: white;
                padding: 30px;
                border-radius: 10px;
                width: 400px;
                margin: auto;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }
            .payment-box h2 {
                margin-bottom: 20px;
            }
            .details {
                text-align: left;
                margin-bottom: 20px;
            }
            .btn {
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }
            .btn:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="payment-box">
            <h2>Thanh Toán Buổi Học</h2>
            <div class="details">
                <p><strong>Gia sư:</strong> Nguyễn Văn A</p>
                <p><strong>Môn học:</strong> Tiếng Anh Giao Tiếp</p>
                <p><strong>Ngày học:</strong> 22/03/2025</p>
                <p><strong>Giờ học:</strong> 19:00 - 20:00</p>
                <p><strong>Giá tiền:</strong> 200.000 VNĐ</p>
            </div>
            <form action="payment" method="post">
                <input type="hidden" name="totalBill" value="200000">
                <button type="submit" class="btn">Thanh Toán</button>
            </form>
        </div>
    </body>
</html>
