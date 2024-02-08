<%@ page import="com.JAVA.Beans.Benevole" %>
<%@ page import="com.JAVA.Beans.User" %>
<%@ page import="com.JAVA.Beans.AdminAssociation" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="com.JAVA.Beans.Benevole" %>
<%@ page import="com.JAVA.Beans.User" %>
<%@ page import="com.JAVA.DAO.BenevoleDAO" %>
<%@ page import="com.JAVA.DAO.BenevoleDAOImpl" %>
<%@ page import="com.JAVA.DAO.DAOFactory" %>
<%@ page import="java.util.Base64" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js"></script>
    <style>
        body {
.form-control:focus {
    box-shadow: none;
    border-color: #39B54A
}

        <!-- Display Benevole-specific fields -->
        Nom: ${benevole.nom}<br>
        Prenom: ${benevole.prenom}<br>
        Titre Professionnel: ${benevole.titreProfessionnel}<br>
        Resume: ${benevole.resume}<br>
        <label for="sexe">Sexe :</label>
        <input type="text" id="sexe" name="sexe" value="${benevole.sexe}" readonly><br>
        <label for="dateNaissance">Date de Naissance :</label>
        <input type="text" id="dateNaissance" name="dateNaissance" value="${benevole.dateNaissance}" readonly><br>
        <label for="age">Âge :</label>
        <input type="text" id="age" name="age" value="${benevole.age}" readonly><br>
	
        <!-- Display associations -->
        <h3>Associations</h3>
        <c:forEach var="association" items="${benevole.associations}">
            ${association.nom} - ${association.secteurActivite}<br>
            <!-- Add more fields as needed -->
        </c:forEach>
>>>>>>> bd30c91687f1b51e46da976cf32d0e88866f1e70

.profile-button {
    background: #39B54A;
    box-shadow: none;
    border: none
}

.profile-button:hover {
    background: #39B54A
}

.profile-button:focus {
    background: #39B54A;
    box-shadow: none
}

.profile-button:active {
    background: #39B54A;
    box-shadow: none
}

.back:hover {
    color: #39B54A;
    cursor: pointer
}

.labels {
    font-size: 11px
}

.add-experience:hover {
    background: #39B54A;
    color: #39B54A;
    cursor: pointer;
    border: solid 1px #39B54A
}
    </style>
    <style>
    /* Custom CSS styles for the green color */
    .form-check-input:checked {
        background-color: #39B54A;
        border-color: #39B54A;
    }
</style>
    <style>
        /* Add your custom styles here */
        .dropdown-item.active, .dropdown-item:active {
            background-color: green !important;
        }
    </style>

</head>

<body class="newsfeed"  >
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

<div class="container rounded bg-white mt-5 mb-5">
    <div class="row">
        <div class="col-md-3 border-right">
            <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                <img class="rounded-circle mt-5" width="150px" src="data:image/png;base64,${base64Photo}">
                <span class="font-weight-bold">${benevole.nom}</span>
                <span class="text-black-50">${user.email}</span>
                <!-- Change "Edit Details" link to a button -->
                <a href="${pageContext.request.contextPath}/ProfileManaging?action=update" class="btn btn-success mt-3">Edit Details</a>
            </div>
        </div>
        <div class="col-md-9 border-right">
            <div class="p-3 py-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">Profile </h4>
                </div>
                <div>
                    <label>Nom:</label>
                    <span>${benevole.nom}</span><br>
                    <label>Prenom:</label>
                    <span>${benevole.prenom}</span><br>
                    <label>Sexe:</label>
                    <span>${benevole.sexe}</span><br>
                    <label>Titre Professionnel:</label>
                    <span>${benevole.titreProfessionnel}</span><br>
                    <label>Resume:</label>
                    <span>${benevole.resume}</span><br>
                    <label>Date de Naissance:</label>
                    <span>${benevole.dateNaissance}</span><br>
                    <label>Âge:</label>
                    <span>${benevole.age}</span><br>
                    <h3>Associations</h3>
                    <ul>
                        <!-- Loop through associations -->
                        <c:forEach var="association" items="${benevole.associations}">
                            <li>${association.nom} - ${association.secteurActivite}</li>
                            <!-- Add more fields as needed -->
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>








</body>
</html>



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
        function updateFilePath(input) {
            if (input.files.length > 0) {
                document.getElementById('filePath').value = input.files[0].name;
            } else {
                document.getElementById('filePath').value = "";
            }
        }

    </script>
    <script src="assets/js/app.js"></script>
    <script src="assets/js/components/components.js"></script>
    <script type="text/javascript">

</body>

</html>
