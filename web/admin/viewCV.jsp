<%-- 
    Document   : viewCV
    Created on : Mar 7, 2025, 10:41:14 AM
    Author     : dvdung
--%>

<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>G4 SmartTutor</title>
        <link rel="stylesheet" href="assets/css/styleCV.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    </head>
    <%
        ResultSet cv = (ResultSet)request.getAttribute("cv");
        cv.next();
    %>
    <body>
        <div class="container">
            <div class="avatar">
                <img src="<%=cv.getString("Avatar")%>" alt="">
            </div>
            <div class="name">
                <h1><%=cv.getString("FullName")%></h1>
                <div class="specialize"><%=cv.getString("SubjectName")%></div>
                <ul class="contact">
                    <li>
                        <span>P</span> <%=cv.getString("Phone")%>
                    </li>
                    <li>
                        <span>E</span> <%=cv.getString("Email")%>
                    </li>
                </ul>
            </div>
            <div class="info">
                <ul>
                    <li><%=cv.getString("Address")%></li>
                    <li><%=cv.getDate("Dob")%></li>
                    <li><%=cv.getString("Education")%></li>
                </ul>
            </div>
            <div class="intro">
                <h2>INTRODUCE MYSELT</h2>
                <%=cv.getString("Description")%>
            </div>
            <div class="experience">
                <h2>EXPERIENCE</h2>

                <div class="item">
                    <h4>Frond-end Developer</h4>
                    <div class="time">
                        <span>2020 - 2022</span>
                        <span>ABC D company</span>
                    </div>
                    <div class="des">
                        Lorem, ipsum dolor sit amet consectetur adipisicing elit. Architecto accusantium officia nobis quas excepturi consectetur quidem quia est neque doloremque.
                    </div>
                </div>

                <div class="item">
                    <h4>Student</h4>
                    <div class="time">
                        <span>2015 - 2019</span>
                        <span>ACDC University</span>
                    </div>
                    <div class="des">
                        Lorem, ipsum dolor sit amet consectetur adipisicing elit. Architecto accusantium officia nobis quas excepturi consectetur quidem quia est neque doloremque.
                    </div>
                </div>
                <h2 class="skills">
                    SKILLS
                </h2>
                <ul>
                    <li>HTML</li>
                    <li>CSS</li>
                    <li>Bootstrap</li>
                    <li>Javascript</li>
                    <li>PHP</li>
                    <li>MySql</li>
                    <li>Git</li>
                    <li>Laravel</li>
                </ul>

            </div>
            <div class="project">
                <h2>PROJECTS</h2>
                <div class="item">
                    <h4>Website shopping</h4>
                    <div class="time">
                        2020
                    </div>
                    <div class="web">
                        www.lundevweb.com
                    </div>
                    <div class="location">
                        Frond-end Developer
                    </div>
                    <div class="des">
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto consequatur amet sed, est eum facilis repellendus 
                        atque perspiciatis iste porro nobis autem explicabo expedita fugiat nostrum. Eveniet eum autem culpa!
                        <ul>
                            <li>Lorem ipsum dolordolores.</li>
                            <li>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Consequuntur, dolores.</li>
                            <li>Lorem ipsum dolor sit amet consectetur dolores.</li>
                        </ul>
                    </div>
                </div>

                <div class="item">
                    <h4>Website shopping</h4>
                    <div class="time">
                        2020
                    </div>
                    <div class="web">
                        www.lundevweb.com
                    </div>
                    <div class="location">
                        Frond-end Developer
                    </div>
                    <div class="des">
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto consequatur amet sed, est eum facilis repellendus 
                        atque perspiciatis iste porro nobis autem explicabo expedita fugiat nostrum. Eveniet eum autem culpa!
                        <ul>
                            <li>Lorem ipsum dolordolores.</li>
                            <li>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Consequuntur, dolores.</li>
                            <li>Lorem ipsum dolor sit amet consectetur dolores.</li>
                        </ul>
                    </div>
                </div>

                <div class="item">
                    <h4>Website shopping</h4>
                    <div class="time">
                        2020
                    </div>
                    <div class="web">
                        www.lundevweb.com
                    </div>
                    <div class="location">
                        Frond-end Developer
                    </div>
                    <div class="des">
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto consequatur amet sed, est eum facilis repellendus 
                        atque perspiciatis iste porro nobis autem explicabo expedita fugiat nostrum. Eveniet eum autem culpa!
                        <ul>
                            <li>Lorem ipsum dolordolores.</li>
                            <li>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Consequuntur, dolores.</li>
                            <li>Lorem ipsum dolor sit amet consectetur dolores.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
