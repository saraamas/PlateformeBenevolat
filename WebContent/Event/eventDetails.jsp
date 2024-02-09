<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.JAVA.Beans.Avis" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
    <style>
    /* Style du cadre autour des commentaires */
    .comment-box {
        border: 1px solid #ddd; /* Bordure grise */
        border-radius: 5px; /* Coins arrondis */
        padding: 10px; /* Espace à l'intérieur du cadre */
        margin-bottom: 15px; /* Marge en bas pour séparer les commentaires */
    }

    /* Style pour la réaction */
    .user-name {
        font-weight: bold; /* Texte en gras */
        color: #365899; /* Couleur bleue similaire à Facebook */
    }

    /* Style pour le timestamp */
    .timestamp {
        font-size: 0.8em; /* Taille de police plus petite */
        color: #888; /* Couleur grise pour le timestamp */
        margin-left: 10px; /* Marge à gauche pour séparer le timestamp de la réaction */
    }
     /* Styles de formulaire */
    .add-comment-form {
        margin-top: 20px;
    }

    .add-comment-form label {
        display: block;
        margin-bottom: 5px;
    }

    .add-comment-form textarea {
        width: 100%;
        padding: 5px;
        margin-bottom: 10px;
    }

    .add-comment-form select {
        padding: 5px;
        margin-bottom: 10px;
    }
</style>
<style>
    .event-card {
        border: 2px solid #008000; /* Bordure verte */
        border-radius: 10px;
        margin-top: 20px; /* Espace entre le navbar et la card */
        background-color: #fff; /* Couleur de fond */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Ombre */
    }

    .event-card-header {
        background-color: #008000 !important; /* Header vert */
        color: #fff;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
    }
</style>
<style>
        /* Add your custom styles here */
        .dropdown-item.active, .dropdown-item:active {
            background-color: green !important;
        }
</style>
</head>
<body>
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

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card event-card">
                <div class="card-body">
                    <c:if test="${not empty eventDetails}">
                        <h5 class="card-title">${eventDetails.titre}</h5>
                        <p class="card-text">Creator: ${eventDetails.adminAssociation.nom}</p>
                        <p class="card-text">Description: ${eventDetails.description}</p>
                        <p class="card-text">Category: ${eventDetails.categorie}</p>
                        <p class="card-text">Start Date: ${eventDetails.dateDebut}</p>
                        <p class="card-text">End Date: ${eventDetails.dateFin}</p>
                        <p class="card-text">Location: ${eventDetails.lieu}</p>
                    </c:if>
                    <!-- Formulaire pour ajouter un nouvel avis -->
                    <form action="AvisServlet" method="post" class="add-comment-form">
                        <input type="hidden" name="action" value="addAvis">
                        <input type="hidden" name="eventId" value="${eventDetails.idEvent}">
                        <label for="commentaire">Commentaire:</label>
                        <textarea name="commentaire" id="commentaire" class="form-control" required></textarea>
                        <input type="submit" class="btn btn-success btn-sm mt-2" value="Ajouter Avis">
                    </form>
                    <!-- Afficher la liste des avis -->
                    <div class="mt-3">
                        <h5 class="card-title">Comments</h5>
                        <c:forEach var="avis" items="${avisList}">
                            <div class="comment-box">
                                <p>                                
                                    <span class="user-name">${userName}</span> <!-- Affichage du nom d'utilisateur -->
                                    <span class="timestamp">${avis.timestamp}</span><!-- Affichage du timestamp -->
                                </p>
                                <p>${avis.commentaire}</p> <!-- Affichage du commentaire -->
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>