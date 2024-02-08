<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.JAVA.Beans.User" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" type="image/png" href="assets/images/logo-16x16.png" />
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Volunteer</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Major+Mono+Display" rel="stylesheet">
    <link href='https://cdn.jsdelivr.net/npm/boxicons@1.9.2/css/boxicons.min.css' rel='stylesheet'>

    <!-- Styles -->
    <link href="assets/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/components.css" rel="stylesheet">
    <link href="assets/css/media.css" rel="stylesheet">
    <link href="https://vjs.zencdn.net/7.4.1/video-js.css" rel="stylesheet">
    <script src="https://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

</head>

<body class="newsfeed"  >
    <div class="container-fluid" id="wrapper">
        <div class="row newsfeed-size">
            <div class="col-md-12 newsfeed-right-side">
             <nav id="navbar-main" class="navbar navbar-expand-lg shadow-sm sticky-top">
                    <ul class="navbar-nav mr-5" id="main_menu">
                        <a class="navbar-brand nav-item mr-lg-5" href="admin_home.jsp"><img src="assets/images/logo-64x64.png" width="60" height="60" class="mr-3" alt="Logo" style="margin-left:60px;"></a>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <form class="w-30 mx-2 my-auto d-inline form-inline mr-5">
                            <div class="input-group">
                                <input type="text" class="form-control search-input w-75" placeholder="Search for people, companies, events and more..." aria-label="Search" aria-describedby="search-addon">
                                <div class="input-group-append">
                                    <button class="btn search-button" type="button"><i class='bx bx-search'></i></button>
                                </div>
                            </div>
                        </form>
                        <li class="nav-item btn-group d-mobile">
                            <a href="#" class="nav-link nav-icon nav-links" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="bx bx-plus"></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right nav-dropdown-menu">
                                <a href="${pageContext.request.contextPath}/eventServlet?action=create" class="dropdown-item" aria-describedby="createEvent">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <i class='bx bx-calendar post-option-icon'></i>
                                        </div>
                                        <div class="col-md-10">
                                            <span class="fs-9">Event</span>
                                            <small id="createEvent" class="form-text text-muted">bring people together with a public or private event</small>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>

                        <li class="nav-item dropdown">
                            <a href="#" class="nav-link nav-links" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                <i class='bx bxs-bell notification-bell'></i> </span>
                            </a>
                            <ul class="dropdown-menu notify-drop notify-mobile dropdown-menu-right nav-drop">
                                <div class="notify-drop-title">
                                    <div class="fs-8">Notifications</div>
                                    <div>
                                        <a href="#" class="notify-right-icon">
                                            Mark All as Read
                                        </a>
                                    </div>
                                </div>
                                <!-- end notify title -->
                                <!-- notify content -->
                                <div class="drop-content">
                                    <li>
                                        <div class="col-md-3 col-sm-3 col-xs-3">
                                            <div class="notify-img">
                                                <img src="assets/images/users/user-10.png" alt="notification user image">
                                            </div>
                                        </div>
                                        <div class="col-md-9 col-sm-9 col-xs-9 pd-l0">
                                            <a href="#" class="notification-user">Sean</a> <span class="notification-type">replied to your comment on a post in </span><a href="#" class="notification-for">PHP</a>
                                            <a href="#" class="notify-right-icon">
                                                <i class='bx bx-radio-circle-marked'></i>
                                            </a>
                                            <p class="time">
                                                <span class="badge badge-pill badge-primary"><i class='bx bxs-group'></i></span> 3h
                                            </p>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col-md-3 col-sm-3 col-xs-3">
                                            <div class="notify-img">
                                                <img src="assets/images/users/user-7.png" alt="notification user image">
                                            </div>
                                        </div>
                                        <div class="col-md-9 col-sm-9 col-xs-9 pd-l0">
                                            <a href="#" class="notification-user">Kimberly</a> <span class="notification-type">likes your comment "I would really... </span>
                                            <a href="#" class="notify-right-icon">
                                                <i class='bx bx-radio-circle-marked'></i>
                                            </a>
                                            <p class="time">
                                                <span class="badge badge-pill badge-primary"><i class='bx bxs-like'></i></span> 7h
                                            </p>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col-md-3 col-sm-3 col-xs-3">
                                            <div class="notify-img">
                                                <img src="assets/images/users/user-8.png" alt="notification user image">
                                            </div>
                                        </div>
                                        <div class="col-md-9 col-sm-9 col-xs-9 pd-l0">
                                            <span class="notification-type">10 people saw your story before it disappeared. See who saw it.</span>
                                            <a href="#" class="notify-right-icon">
                                                <i class='bx bx-radio-circle-marked'></i>
                                            </a>
                                            <p class="time">
                                                <span class="badge badge-pill badge-primary"><i class='bx bx-images'></i></span> 23h
                                            </p>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col-md-3 col-sm-3 col-xs-3">
                                            <div class="notify-img">
                                                <img src="assets/images/users/user-11.png" alt="notification user image">
                                            </div>
                                        </div>
                                        <div class="col-md-9 col-sm-9 col-xs-9 pd-l0">
                                            <a href="#" class="notification-user">Michelle</a> <span class="notification-type">posted in </span><a href="#" class="notification-for">Argon Social Design System</a>
                                            <a href="#" class="notify-right-icon">
                                                <i class='bx bx-radio-circle-marked'></i>
                                            </a>
                                            <p class="time">
                                                <span class="badge badge-pill badge-primary"><i class='bx bxs-quote-right'></i></span> 1d
                                            </p>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col-md-3 col-sm-3 col-xs-3">
                                            <div class="notify-img">
                                                <img src="assets/images/users/user-5.png" alt="notification user image">
                                            </div>
                                        </div>
                                        <div class="col-md-9 col-sm-9 col-xs-9 pd-l0">
                                            <a href="#" class="notification-user">Karen</a> <span class="notification-type">likes your comment "Sure, here... </span>
                                            <a href="#" class="notify-right-icon">
                                                <i class='bx bx-radio-circle-marked'></i>
                                            </a>
                                            <p class="time">
                                                <span class="badge badge-pill badge-primary"><i class='bx bxs-like'></i></span> 2d
                                            </p>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col-md-3 col-sm-3 col-xs-3">
                                            <div class="notify-img">
                                                <img src="assets/images/users/user-12.png" alt="notification user image">
                                            </div>
                                        </div>
                                        <div class="col-md-9 col-sm-9 col-xs-9 pd-l0">
                                            <a href="#" class="notification-user">Irwin</a> <span class="notification-type">posted in </span><a href="#" class="notification-for">Themeforest</a>
                                            <a href="#" class="notify-right-icon">
                                                <i class='bx bx-radio-circle-marked'></i>
                                            </a>
                                            <p class="time">
                                                <span class="badge badge-pill badge-primary"><i class='bx bxs-quote-right'></i></span> 3d
                                            </p>
                                        </div>
                                    </li>
                                </div>
                                <div class="notify-drop-footer text-center">
                                    <a href="#">See More</a>
                                </div>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a href="#" class="nav-link nav-links" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                <div class="menu-user-image">
                                    <img src="assets/images/users/user-4.jpg" class="menu-user-img ml-1" alt="Menu Image">
                                </div>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right nav-drop">
                                <a class="dropdown-item" href="profile.html"><i class='bx bx-user mr-2'></i> Account</a>
                                <div role="separator" class="dropdown-divider"></div>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/logoutServlet"><i class='bx bx-undo mr-2'></i> Logout</a>
                                <a class="dropdown-item" href="#"><i class='bx bx-undo mr-2'></i> Delete Account</a>
                            </div>
                        </li>
                    </ul>
                    <button type="button" class="btn btn-primary mr-3" id="menu-toggle"><i class='bx bx-align-left'></i></button>
                </nav>



 <div class="blog-container max-w-2xl mx-auto p-8 bg-white rounded-md shadow-md mt-8">
    <h2 class="text-2xl font-bold mb-4">Update your Event</h2>
    <c:if test="${not empty event}">
    <form action="eventServlet" method="post" enctype="multipart/form-data" class="space-y-4">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="idEvent" value="${event.idEvent}">
        <div>
            <label for="titre" class="block text-sm font-medium text-gray-600">Title:</label>
            <input type="text" name="titre" value="${event.titre}" required
                class="mt-1 p-2 w-full border rounded-md focus:outline-none focus:border-blue-500" >
        </div>

        <div>
            <label for="description" class="block text-sm font-medium text-gray-600">Description:</label>
            <textarea rows="4" name="description" required
                class="mt-1 p-2 w-full border rounded-md focus:outline-none focus:border-blue-500">${event.description}</textarea>
        </div>

        <div>
            <label for="categorie" class="block text-sm font-medium text-gray-600">Category:</label>
            <input type="text" name="categorie" value="${event.categorie}" required
                class="mt-1 p-2 w-full border rounded-md focus:outline-none focus:border-blue-500">
        </div>

        <div>
            <label for="dateDebut" class="block text-sm font-medium text-gray-600">Start Date:</label>
            <input type="text" name="dateDebut" value="${event.dateDebut}" required
                class="mt-1 p-2 w-full border rounded-md focus:outline-none focus:border-blue-500">
        </div>

        <div>
            <label for="dateFin" class="block text-sm font-medium text-gray-600">End Date:</label>
            <input type="text"  name="dateFin" value="${event.dateFin}" required
                class="mt-1 p-2 w-full border rounded-md focus:outline-none focus:border-blue-500">
        </div>

        <div>
            <label for="lieu" class="block text-sm font-medium text-gray-600">Location:</label>
            <input type="text" name="lieu" value="${event.lieu}" required
                class="mt-1 p-2 w-full border rounded-md focus:outline-none focus:border-blue-500">
        </div>

        <div class="relative mt-1">
            <label for="picture" class="block text-sm font-medium text-gray-600">Image:</label>
            <input type="file" name="picture" accept="image/*" class="hidden" id="picture" onchange="updateFileName(this)">
            <div class="flex justify-between items-center">
                <input type="text" id="file-name" readonly  class="p-2 w-full border rounded-md focus:outline-none focus:border-blue-500 bg-gray-100">
                <label for="picture" id="file-button" class="px-4 py-2 bg-green-500 text-white rounded-md hover:bg-green-600 cursor-pointer" style="margin-bottom:-2px;">Choose</label>
            </div>
        </div>

        <div>
            <input type="submit" value="Update"
                class="px-4 py-2 bg-green-500 text-white rounded-md hover:bg-green-600 cursor-pointer">
        </div>
    </form>
 </c:if>
</div>



</body>



                        <!-- Posts -->


                        <!-- Suggestions -->
  
                        <!-- Suggestions -->


    <!-- Modals -->
    

    <!-- Core -->
    <script src="assets/js/jquery/jquery-3.3.1.min.js"></script>
    <script src="assets/js/popper/popper.min.js"></script>
    <script src="assets/js/bootstrap/bootstrap.min.js"></script>
    <!-- Optional -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    <script type="text/javascript">
        $("#menu-toggle").click(function(e) {
            e.preventDefault();
            $("#wrapper").toggleClass("toggled");
        });
         
        function updateFileName(input) {
      var fileName = input.files[0].name;
      document.getElementById('file-name').value = fileName;
}

        

    </script>
    <script src="assets/js/app.js"></script>
    <script src="assets/js/components/components.js"></script>
    <script type="text/javascript">
   



 </html>
