<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
     <!-- Vous devez inclure ces bibliothèques pour que les graphiques fonctionnent -->
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
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* Add your custom styles here */
        .dropdown-item.active, .dropdown-item:active {
            background-color: green !important;
        }
    </style>

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
            <a class="navbar-brand nav-item mr-lg-5" href="admin_home.jsp"><img src="assets/images/logo-64x64.png" width="60" height="60" class="mr-3" alt="Logo" style="margin-left:60px;"></a>
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
                    <a class="dropdown-item" href="<%= request.getContextPath() %>/update-adminAssociationProfile.jsp">Profile</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logoutServlet">Logout</a>
                </div>
            </li>
            <!-- Events -->
<li class="list-group-item d-flex justify-content-between align-items-center border-0 dropdown">
    <a href="#" class="sidebar-item dropdown-toggle" role="button" id="addEventDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" title="Add Event">
        <i class="bi bi-calendar3"></i>
    </a>
    <div class="dropdown-menu" aria-labelledby="addEventDropdown">
        <a class="dropdown-item" href="${pageContext.request.contextPath}/eventServlet?action=create">Create New Event</a>
        <a class="dropdown-item" href="eventServlet?action=view">Events</a>
    </div>
</li>

            <!-- My Volunteer Applications -->
            <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                <a href="candidatureServlet?action=view" class="sidebar-item" title="Applications"><i class="bi bi-journal-check"></i> </a>
            </li>
            <!-- Additional list items go here -->
        </ul>
    </div>
</nav>


    <div class="dashboard-container grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 max-w-7xl mx-auto p-4">
        <div class= "container">
        <a href="events.ev">
        <div class="widget bg-white p-4 rounded-md shadow-md">
            <img style="display: inline-block; margin-right:80px;" src="assets/images/calendrier.png" width=60px height=60>
            <h2 style="display: inline-block; float:right; margin-top:15px" class="text-xl font-bold mb-4"> ${numberOfEvents } Events</h2>
        </div>
        </a>
        </div>
        <a href="donnateur.do">
        <div class="widget bg-white p-4 rounded-md shadow-md">
            <img style="display: inline-block; margin-right:80px;" src="assets/images/donors.png" width=60px height=60>
            <h2 style="display: inline-block; float:right;margin-top:15px" class="text-xl font-bold mb-4">${benevolesCount} Volunteers</h2>
        </div>
        </a >
        <a href="blog.bce">
        <div class="widget bg-white p-4 rounded-md shadow-md">
            <img style="display: inline-block; margin-right:80px;" src="assets/images/candidature.jpg" width=60px height=60>
            <h2 style="display: inline-block; float:right;margin-top:15px" class="text-xl font-bold mb-4">${candidaturesEnAttenteCount} Applications</h2>
        </div>
        </a>
    </div>
    
    
            <!-- 1.Création d'une pie chart pour le nombre de bénévoles par sexe -->
    
    <div style=" display: grid; place-items: center;">   
        <h2 style="place-items: center;" class="text-xl font-bold mb-4">Volunteers by gender </h2>
        <div id="chartContainer"  style="width: 800px; height: 600px; background-color:white; padding:20px; border-radius:10px;margin-bottom:20px;">
            <canvas id="genderChart" width="600" height="400" ></canvas>
        </div>
    </div>  
		    <script>
		
			// Création d'un graphique en secteurs (pie chart) pour représenter les données de maleCount et femaleCount
		    var ctx = document.getElementById('genderChart').getContext('2d');
		    var genderChart = new Chart(ctx, {
		        type: 'pie',
		        data: {
		            labels: ['Homme', 'Femme'],
		            datasets: [{
		                label: 'Répartition par sexe',
		                data: [${maleCount}, ${femaleCount}],
		                backgroundColor: ['rgba(64, 145, 108,0.5)', 'rgba(149, 213, 178,0.5)'],
		                borderColor: ['rgba(64, 145, 108,1)', 'rgba(149, 213, 178,1)'],
		                borderWidth: 1
		            }]
		        },
		        options: {
		            scales: {
		                y: {
		                    beginAtZero: true
		                }
		            }
		        }
		    });
		</script>

    <!-- 2- Evénements et du nombre de candidatures acceptées pour chaque événement (Pie chart) -->
    
    <div style=" display: grid; place-items: center;">   
        <h2 style="place-items: center;" class="text-xl font-bold mb-4">Events by number of volunteers </h2>
        <div id="chartContainer"  style="width: 800px; height: 600px; background-color:white; padding:20px; border-radius:10px;margin-bottom:20px;">
            <canvas id="eventsChart" width="600" height="400" ></canvas>
        </div>
    </div>  
	<script>
	//Récupération des données des événements et des candidatures acceptées depuis les attributs de la requête
	var eventsData = ${eventsDataJson};
	
	// Création des listes pour les titres des événements et le nombre de candidatures acceptées
	var eventTitles = [];
	var candidaturesAccepteesCount = [];
	
	// Parcours des données des événements pour extraire les titres et les nombres de candidatures acceptées
	for (var i = 0; i < eventsData.length; i++) {
	    eventTitles.push(eventsData[i].eventTitle);
	    candidaturesAccepteesCount.push(eventsData[i].candidaturesAccepteesCount);
	}
	
	// Création d'un graphique en barres pour représenter les événements et le nombre de candidatures acceptées
	var ctxEvents = document.getElementById('eventsChart').getContext('2d');
	var eventsChart = new Chart(ctxEvents, {
	    type: 'bar',
	    data: {
	        labels: eventTitles,
	        datasets: [{
	            label: 'Volunteers by events',
	            data: candidaturesAccepteesCount,
	            backgroundColor: ['rgba(88, 129, 87, 0.5)','rgba(244, 162, 89,0.5)','rgba(244, 226, 133,0.5)'],
	            borderColor: ['rgba(88, 129, 87, 1)','rgba(244, 162, 89,1)','rgba(244, 226, 133,0.5)'],
	            borderWidth: 1
	        }]
	    },
	    options: {
	        scales: {
	            y: {
	                beginAtZero: true
	            }
	        }
	    }
	});
	</script>
		 <!-- 3- Affichage des événements par categorie -->
		 
		 <div style=" display: grid; place-items: center;">   
        <h2 style="place-items: center;" class="text-xl font-bold mb-4">Evénementts par catégorie</h2>
        <div id="chartContainer"  style="width: 800px; height: 600px; background-color:white; padding:20px; border-radius:10px;margin-bottom:20px;">
            <canvas id="eventsByCategoryChart" width="600" height="400" ></canvas>
        </div>
    </div>  
    
    
    <script>
    var ctx = document.getElementById('eventsByCategoryChart').getContext('2d');
    var eventsByCategoryChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ${categories},
            datasets: [{
                label: 'Nombre d\'événements par catégorie',
                data: ${eventCounts},
                backgroundColor:[ 'rgba(251, 176, 45, 0.5)','rgba(188, 75, 81,0.5)','rgba(91, 142, 125,0.5)'],
                borderColor: ['rgba(251, 176, 45, 1)','rgba(188, 75, 81,1)','rgba(91, 142, 125,1)'],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                x: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
	

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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
  $(".dropdown-item").click(function() {
    $(".dropdown-item").css("color", ""); // Reset color for all dropdown items
    $(this).css("color", "green"); // Change color only for the clicked item
  });
});
</script>
    <script src="assets/js/app.js"></script>
    <script src="assets/js/components/components.js"></script>

</body>

</html>

