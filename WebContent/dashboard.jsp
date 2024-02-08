<!DOCTYPE html>
<html>
	<head>
    <title>Dashboard</title>
 
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
     <!-- Vous devez inclure ces bibliothèques pour que les graphiques fonctionnent -->
    
    <style>
    canvas {
    max-width: 40%; /* Pour s'assurer que le canvas ne dépasse pas la largeur de son conteneur */
    height: auto; /* Pour conserver le rapport hauteur/largeur d'origine */
    display: block; /* Pour éviter tout espace supplémentaire autour du canvas */
}
    
       
    </style>
    </head>
<body>
    <h1>Dashboard</h1>

    <!-- Affichage du nombre de bénévoles -->
    <h3>Nombre de bénévoles : ${benevolesCount}</h3>

    <!-- Affichage du nombre de candidatures en attente -->
    <h3>Nombre de candidatures en attente : ${candidaturesEnAttenteCount}</h3>
    
    <!-- Affichage du nombre des events -->
    <h3>Nombre des events : ${numberOfEvents }</h3>
    <!-- 1.Création d'une pie chart pour le nombre de bénévoles par sexe -->
    <h2>Nombre des Adherents par genre</h2>
    
    <canvas id="genderChart" ></canvas>
   
	<script >
	
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
    


    <!-- Affichage des événements et du nombre de candidatures acceptées pour chaque événement sous forme de graphique en barres -->
    <h2>Événements et nombre d'Adherents acceptées :</h2>
    <canvas id="eventsChart" ></canvas>
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
	            label: 'Benevoles participants par événement',
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
	
	<h1>Events par categorie</h1>
	<canvas id="eventsByCategoryChart" width="400" height="200"></canvas>

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
	
	
	

</body>

</html>
