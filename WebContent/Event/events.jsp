<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.JAVA.Beans.Event" %>
<%@ page import="com.JAVA.Beans.AdminAssociation" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" type="image/png" href="assets/images/logo-16x16.png" />
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Volunteer</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Major+Mono+Display" rel="stylesheet">
    <link href="assets/css/boxicons.min.css" rel="stylesheet">

    <!-- Styles -->
    <link href="assets/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/components.css" rel="stylesheet">
    <link href="assets/css/media.css" rel="stylesheet">
    <link href="assets/css/chat.css" rel="stylesheet">
    <link href="https://vjs.zencdn.net/7.4.1/video-js.css" rel="stylesheet">
    <script src="https://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js" type="text/javascript"></script>
    <script src="assets/js/load.js" type="text/javascript"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
</head>

<body class="newsfeed">
    <div class="container-fluid" id="wrapper">
        <div class="row newsfeed-size">
            <div class="col-md-12 newsfeed-right-side">
<nav id="navbar-main" class="navbar navbar-expand-lg shadow-sm sticky-top">
    <div class="w-100 justify-content-md-center">
        <ul class="nav navbar-nav enable-mobile px-2">
            <!-- Quick make post button -->
            <li class="nav-item">
                <button type="button" class="btn nav-link p-0" data-toggle="tooltip" title="Make Post"><i class="bi bi-camera-fill f-nav-icon"></i></button>
            </li>
            <!-- Search form -->
            <li class="nav-item w-100 py-2">
                <form class="d-inline form-inline w-100 px-4">
                    <div class="input-group">
                        <input type="text" class="form-control search-input" placeholder="Search for people, companies, events and more..." aria-label="Search" aria-describedby="search-addon">
                        <div class="input-group-append">
                            <button class="btn search-button" type="button"><i class='bx bx-search'></i></button>
                        </div>
                    </div>
                </form>
            </li>
            <!-- Messages -->
            <li class="nav-item">
                <a href="messages.html" class="nav-link nav-icon nav-links message-drop drop-w-tooltip" data-placement="bottom" title="Messages">
                    <i class="bi bi-chat-dots-fill message-dropdown f-nav-icon"></i>
                </a>
            </li>
        </ul>
        <!-- Main menu -->
        <ul class="navbar-nav mr-5 flex-row" id="main_menu">
            <!-- Logo -->
            <a class="navbar-brand nav-item mr-lg-5" href="benevole_home.jsp"><img src="assets/images/logo-64x64.png" width="60" height="60" class="mr-3" alt="Logo" style="margin-left:60px;"></a>
            <!-- Search form for events -->
            <form class="w-30 mx-2 my-auto d-inline form-inline mr-5 dropdown search-form" action="eventServlet" method="get">
                <input type="hidden" name="action" value="search">
                <div class="input-group" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="searchDropdown">
                    <label for="searchCategory"></label>
                    <input type="text" class="form-control search-input w-75" placeholder="Search for people, companies, events and more..." aria-label="Search" aria-describedby="search-addon" id="searchCategory" name="searchCategory">
                    <div class="input-group-append">
                        <button class="btn search-button" type="submit">
                            <i class='bx bx-search'></i>
                            <input type="submit" value="search" style="display: none;">
                        </button>
                    </div>
                </div>
            </form>
            <!-- Notifications -->
            <li class="nav-item s-nav dropdown notification">
                <a href="#" class="nav-link nav-links rm-drop-mobile drop-w-tooltip" data-toggle="dropdown" title="Notifications" role="button" aria-haspopup="true" aria-expanded="false">
                    <i class="bi bi-bell-fill notification-bell"></i>
                </a>
                <ul class="dropdown-menu notify-drop dropdown-menu-right nav-drop shadow-sm">
                    <!-- Notification content -->

                </ul>
            </li>
            <!-- Profile -->
            <li class="list-group-item d-flex justify-content-between align-items-center border-0 dropdown">
                <a href="#" class="sidebar-item dropdown-toggle" role="button" id="profileDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" title="Profile">
                    <i class="bi bi-person-circle"></i>
                </a>
                <div class="dropdown-menu" aria-labelledby="profileDropdown">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/ProfileManaging?action=update">Profile</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logoutServlet">Logout</a>
                </div>
            </li>
            <!-- Events -->
            <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                <a href="eventServlet?action=view" class="sidebar-item" title="Events"><i class="bi bi-calendar3"></i> </a>
            </li>
            <!-- My Volunteer Applications -->
            <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                <a href="candidatureServlet?action=view" class="sidebar-item" title="Applications"><i class="bi bi-journal-check"></i> </a>
            </li>
            <!-- Additional list items go here -->
        </ul>
    </div>
</nav>

                <div class="row newsfeed-right-side-content d-flex justify-content-center mt-3">
                   
                    <div class="col-md-6 second-section" id="page-content-wrapper">
                        <div class="mb-3">
                            <div class="btn-group d-flex">
                                
                            </div>
                        </div>

                        <!-- Posts -->
                        <c:if test="${not empty allEvents}">
                        <c:forEach var="event" items="${allEvents}">
                        <div class="posts-section mb-5">
                            <div class="post border-bottom p-3 bg-white w-shadow">
                                <div class="media text-muted pt-3">
                                    <img src="assets/images/users/placeholder-image.jpg" alt="Online user" class="mr-3 post-user-image">
                                    <div class="media-body pb-3 mb-0 small lh-125">
                                        <div class="d-flex justify-content-between align-items-center w-100">
                                            <a href="#" class="text-gray-dark post-user-name">${event.adminAssociation.nom}</a>
                                            <div class="dropdown">
                                                <a href="#" class="post-more-settings" role="button" data-toggle="dropdown" id="postOptions" aria-haspopup="true" aria-expanded="false">
                                                    <i class='bx bx-dots-horizontal-rounded'></i>
                                                </a>
                                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left post-dropdown-menu">
                                                    <a href="#" class="dropdown-item" aria-describedby="savePost">
                                                        <div class="row">
                                                            <div class="col-md-2">
                                                                <i class='bx bx-bookmark-plus post-option-icon'></i>
                                                            </div>
                                                            <div class="col-md-10">
                                                                <span class="fs-9">Save post</span>
                                                                <small id="savePost" class="form-text text-muted">Add this to your saved items</small>
                                                            </div>
                                                        </div>
                                                    </a>
                                                    <a href="#" class="dropdown-item" aria-describedby="hidePost">
                                                        <div class="row">
                                                            <div class="col-md-2">
                                                                <i class='bx bx-hide post-option-icon'></i>
                                                            </div>
                                                            <div class="col-md-10">
                                                                <span class="fs-9">Hide post</span>
                                                                <small id="hidePost" class="form-text text-muted">See fewer posts like this</small>
                                                            </div>
                                                        </div>
                                                    </a>
                                                    <a href="#" class="dropdown-item" aria-describedby="snoozePost">
                                                        <div class="row">
                                                            <div class="col-md-2">
                                                                <i class='bx bx-time post-option-icon'></i>
                                                            </div>
                                                            <div class="col-md-10">
                                                                <span class="fs-9">Snooze Lina for 30 days</span>
                                                                <small id="snoozePost" class="form-text text-muted">Temporarily stop seeing posts</small>
                                                            </div>
                                                        </div>
                                                    </a>
                                                    <a href="#" class="dropdown-item" aria-describedby="reportPost">
                                                        <div class="row">
                                                            <div class="col-md-2">
                                                                <i class='bx bx-block post-option-icon'></i>
                                                            </div>
                                                            <div class="col-md-10">
                                                                <span class="fs-9">Report</span>
                                                                <small id="reportPost" class="form-text text-muted">I'm concerned about this post</small>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <span class="d-block">de ${event.dateDebut} à ${event.dateFin} <i class='bx bx-globe ml-3'></i></span>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <h1><a href="${pageContext.request.contextPath}/AvisServlet?eventId=${event.idEvent}">${event.titre}</a></h1>
                                    <p>${event.description}</p>
                                </div>
                                <div class="d-block mt-3">
                                    <img src="data:image/jpg;base64,${event.pictureBase64}" class="post-content" alt="post image">
                                </div>
                                <div class="mb-3">
                                    <!-- Reactions -->
                                    <div class="argon-reaction">
                                        <span class="like-btn">
                                            <a href="#" class="post-card-buttons" id="reactions"><i class='bx bxs-like mr-2'></i> 67</a>
                                            <ul class="reactions-box dropdown-shadow">
                                                <li class="reaction reaction-like" data-reaction="Like"></li>
                                                <li class="reaction reaction-love" data-reaction="Love"></li>
                                                <li class="reaction reaction-haha" data-reaction="HaHa"></li>
                                                <li class="reaction reaction-wow" data-reaction="Wow"></li>
                                                <li class="reaction reaction-sad" data-reaction="Sad"></li>
                                                <li class="reaction reaction-angry" data-reaction="Angry"></li>
                                            </ul>
                                        </span>
                                    </div>
                                    <a href="javascript:void(0)" class="post-card-buttons" id="show-comments"><i class='bx bx-message-rounded mr-2'></i> 5</a>
<c:if test="${user ne null && user.idUtilisateur eq event.getAdminAssociation().getIdUtilisateur()}">
    <form action="eventServlet" method="get" style="display: inline;">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="idEvent" value="${event.idEvent}">
        <button type="submit" value="Update" class="btn btn-link text-dark"><i class="bi bi-pencil"></i></button>
    </form>

    <form action="eventServlet" method="post" style="display: inline;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="idEvent" value="${event.idEvent}">
        <button type="submit" value="Delete" class="btn btn-link text-dark"><i class="bi bi-trash"></i></button>
    </form>
</c:if>
<c:if test="${user ne null && user.role eq 'benevole'}">
    <a href="${pageContext.request.contextPath}/candidatureServlet?action=create&benevoleId=${user.idUtilisateur}&eventId=${event.idEvent}">
        <i class="bi bi-person-plus-fill mr-2"></i> <!-- Icône de candidature -->
        Déposer Candidature
    </a>
</c:if>




                            </div>
                        </div>
  </c:forEach>
</c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>





    <!-- Modals -->
    <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" id="postModal" aria-labelledby="postModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-body post-body">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-7 post-content">
                                <img src="https://scontent.fevn1-2.fna.fbcdn.net/v/t1.0-9/56161887_588993861570433_2896723195090436096_n.jpg?_nc_cat=103&_nc_eui2=AeFI0UuTq3uUF_TLEbnZwM-qSRtgOu0HE2JPwW6b4hIki73-2OWYhc7L1MPsYl9cYy-w122CCak-Fxj0TE1a-kjsd-KXzh5QsuvxbW_mg9qqtg&_nc_ht=scontent.fevn1-2.fna&oh=ea44bffa38f368f98f0553c5cef8e455&oe=5D050B05" alt="post-image">
                            </div>
                            <div class="col-md-5 pr-3">
                                <div class="media text-muted pr-3 pt-3">
                                    <img src="assets/images/users/user-1.jpg" alt="user image" class="mr-3 post-modal-user-img">
                                    <div class="media-body">
                                        <div class="d-flex justify-content-between align-items-center w-100 post-modal-top-user fs-9">
                                            <a href="#" class="text-gray-dark">John Michael</a>
                                            <div class="dropdown">
                                                <a href="#" class="postMoreSettings" role="button" data-toggle="dropdown" id="postOptions" aria-haspopup="true" aria-expanded="false">
                                                    <i class='bx bx-dots-horizontal-rounded'></i>
                                                </a>
                                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left postDropdownMenu">
                                                    <a href="#" class="dropdown-item" aria-describedby="savePost">
                                                        <div class="row">
                                                            <div class="col-md-2">
                                                                <i class='bx bx-bookmark-plus postOptionIcon'></i>
                                                            </div>
                                                            <div class="col-md-10">
                                                                <span class="postOptionTitle">Save post</span>
                                                                <small id="savePost" class="form-text text-muted">Add this to your saved items</small>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <span class="d-block fs-8">3 hours ago <i class='bx bx-globe ml-3'></i></span>
                                    </div>
                                </div>
                                <div class="mt-3 post-modal-caption fs-9">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quis voluptatem veritatis harum, tenetur, quibusdam voluptatum, incidunt saepe minus maiores ea atque sequi illo veniam sint quaerat corporis totam et. Culpa?</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

 
    <div id="callModal" class="modal fade call-modal" tabindex="-1" role="dialog" aria-labelledby="callModalLabel" aria-hidden="true">
        <div class="modal-dialog call-modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header align-items-center">
                    <div class="call-status">
                        <h1 id="callModalLabel" class="modal-title mr-3">Connected</h1>
                        <span class="online-status bg-success"></span>
                    </div>
                    <div class="modal-options d-flex align-items-center">
                        <button type="button" class="btn btn-quick-link" id="minimize-call-window">
                            <i class='bx bx-minus'></i>
                        </button>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row h-100">
                        <div class="col-md-12 d-flex align-items-center justify-content-center">
                            <div class="call-user text-center">
                                <div class="call-user-img-anim">
                                    <img src="assets/images/users/user-1.jpg" class="call-user-img" alt="Call user image">
                                </div>
                                <p class="call-user-name">Name Surename</p>
                                <p class="text-muted call-time">05:28</p>
                            </div>
                        </div>
                        <div class="col-md-4 offset-md-4 d-flex align-items-center justify-content-between call-btn-list">
                            <a href="#" class="btn call-btn" data-toggle="tooltip" data-placement="top" data-title="Disable microphone"><i class='bx bxs-microphone'></i></a>
                            <a href="#" class="btn call-btn" data-toggle="tooltip" data-placement="top" data-title="Enable camera"><i class='bx bxs-video-off'></i></a>
                            <a href="#" class="btn call-btn drop-call" data-toggle="tooltip" data-placement="top" data-title="End call" data-dismiss="modal" aria-label="Close"><i class='bx bxs-phone'></i></a>
                            <a href="#" class="btn call-btn" data-toggle="tooltip" data-placement="top" data-title="Share Screen"><i class='bx bx-laptop'></i></a>
                            <a href="#" class="btn call-btn" data-toggle="tooltip" data-placement="top" data-title="Dark mode"><i class='bx bx-moon'></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END call modal -->

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

    </script>
    <script src="assets/js/app.js"></script>
    <script src="assets/js/components/components.js"></script>
</body>

</html>
