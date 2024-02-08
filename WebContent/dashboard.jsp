<!DOCTYPE html>
<html>
	<head>
    <title>Dashboard</title>
 
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
     <!-- Vous devez inclure ces biblioth�ques pour que les graphiques fonctionnent -->
    
    <style>
    canvas {
    max-width: 40%; /* Pour s'assurer que le canvas ne d�passe pas la largeur de son conteneur */
    height: auto; /* Pour conserver le rapport hauteur/largeur d'origine */
    display: block; /* Pour �viter tout espace suppl�mentaire autour du canvas */
}
    
       
    </style>
    </head>
<body>
    <h1>Dashboard</h1>

    <!-- Affichage du nombre de b�n�voles -->
    <h3>Nombre de b�n�voles : ${benevolesCount}</h3>

    <!-- Affichage du nombre de candidatures en attente -->
    <h3>Nombre de candidatures en attente : ${candidaturesEnAttenteCount}</h3>
    
    <!-- Affichage du nombre des events -->
    <h3>Nombre des events : ${numberOfEvents }</h3>
    <!-- 1.Cr�ation d'une pie chart pour le nombre de b�n�voles par sexe -->
    <h2>Nombre des Adherents par genre</h2>
    
    <canvas id="genderChart" ></canvas>
   
	<script >
	
	// Cr�ation d'un graphique en secteurs (pie chart) pour repr�senter les donn�es de maleCount et femaleCount
    var ctx = document.getElementById('genderChart').getContext('2d');
    var genderChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Homme', 'Femme'],
            datasets: [{
                label: 'R�partition par sexe',
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
    


    <!-- Affichage des �v�nements et du nombre de candidatures accept�es pour chaque �v�nement sous forme de graphique en barres -->
    <h2>�v�nements et nombre d'Adherents accept�es :</h2>
    <canvas id="eventsChart" ></canvas>
	<script>
	//R�cup�ration des donn�es des �v�nements et des candidatures accept�es depuis les attributs de la requ�te
	var eventsData = ${eventsDataJson};
	
	// Cr�ation des listes pour les titres des �v�nements et le nombre de candidatures accept�es
	var eventTitles = [];
	var candidaturesAccepteesCount = [];
	
	// Parcours des donn�es des �v�nements pour extraire les titres et les nombres de candidatures accept�es
	for (var i = 0; i < eventsData.length; i++) {
	    eventTitles.push(eventsData[i].eventTitle);
	    candidaturesAccepteesCount.push(eventsData[i].candidaturesAccepteesCount);
	}
	
	// Cr�ation d'un graphique en barres pour repr�senter les �v�nements et le nombre de candidatures accept�es
	var ctxEvents = document.getElementById('eventsChart').getContext('2d');
	var eventsChart = new Chart(ctxEvents, {
	    type: 'bar',
	    data: {
	        labels: eventTitles,
	        datasets: [{
	            label: 'Benevoles participants par �v�nement',
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
                label: 'Nombre d\'�v�nements par cat�gorie',
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
