<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="author" content="Untree.co">
	<link rel="shortcut icon" href="favicon.png">

	<meta name="description" content="" />
	<meta name="keywords" content="" />
	
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Roboto&family=Work+Sans:wght@400;700&display=swap" rel="stylesheet">


	<link rel="stylesheet" href="fonts/icomoon/style.css">
	<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">

	<link rel="stylesheet" href="css/tiny-slider.css">
	<link rel="stylesheet" href="css/aos.css">
	<link rel="stylesheet" href="css/flatpickr.min.css">
	<link rel="stylesheet" href="css/glightbox.min.css">
	<link rel="stylesheet" href="css/style.css">

	<title>Volunteer</title>
</head>
<body>

	<div class="site-mobile-menu site-navbar-target">
		<div class="site-mobile-menu-header">
			<div class="site-mobile-menu-close">
				<span class="icofont-close js-menu-toggle"></span>
			</div>
		</div>
		<div class="site-mobile-menu-body"></div>
	</div>

	<nav class="site-nav">
		<div class="container">
			<div class="menu-bg-wrap">
				<div class="site-navigation">
					<div class="row g-0 align-items-center">
						<div class="col-2">
							<a href="accueil.jsp" class="logo m-0 float-start text-white">Volunteer</a>
						</div>
						<div class="col-8 text-center">
							<ul class="js-clone-nav d-none d-lg-inline-block text-start site-menu mx-auto">
								<li><a href="accueil.jsp">Home</a></li>
								<li class="active"><a href="about.jsp">About</a></li>
								<li><a href="login.jsp">Login</a></li>
							</ul>
						</div>
						<div class="col-2 text-end">
							<a href="#" class="burger ms-auto float-end site-menu-toggle js-menu-toggle d-inline-block d-lg-none light">
								<span></span>
							</a>

							<a href="#" class="call-us d-flex align-items-center">
								<span class="icon-phone"></span>
								<span>063-669-9614</span>
							</a>
						</div>
					</div>

				</div>
			</div>
		</div>
	</nav>

	<div class="hero overlay" style="background-image: url('images/img_v_8-min.jpg')">
		<div class="container">
			<div class="row align-items-center justify-content-center">
				<div class="col-lg-6 text-center">
					<h1 class="heading text-white mb-2" data-aos="fade-up">About Us</h1>
					<p data-aos="fade-up" class=" mb-5 text-white lead text-white-50"> we are a passionate community dedicated to fostering positive change in the world. Our mission is to connect volunteers with impactful organizations, creating a powerful network of individuals committed to making a difference. </p>
					<p data-aos="fade-up"  data-aos-delay="100">
						<a href="register.jsp" class="btn btn-primary me-4">Become a Volunteer</a> 
					</p>		
					
				</div>

				
			</div>
		</div>
	</div>

	<div class="section sec-about">
		<div class="container">
			<div class="row g-5 justify-content-between">
				<div class="col-lg-6 has-bg" data-aos="fade-right">
					<img src="images/hero_2.jpg" alt="Image" class="img-fluid img-box-shadow rounded">
				</div>
				<div class="col-lg-4 align-self-center" data-aos="fade-left" data-aos-delay="100">
					<span class="subheading mb-3">About</span>
					<h2 class="heading mb-4">History</h2>
					<p>our website stands as a testament to our unwavering commitment to meaningful impact. We created this platform with a singular goal in mind — to bridge the gap between those with a passion for making a difference and organizations in need of dedicated volunteers.</p>
					<p>
					Our vision is to empower individuals to contribute their time, skills, and compassion to causes that resonate with them. By providing a centralized hub for connecting volunteers with organizations, we aim to catalyze positive change on a global scale.</p>
				</div>
			</div>
		</div>
	</div>

	
	<div class="section sec-features bg-light">
		<div class="container">
			<div class="row mb-5">
				<div class="col-lg-4" data-aos="fade-up">
					<span class="subheading mb-3">The Team</span>
					<h2 class="heading">Who We Are</h2>
				</div>
				<div class="col-lg-6 text-start" data-aos="fade-up" data-aos-delay="100">
					<p>our website is the collective vision of a dedicated team of individuals who share a common passion for creating positive change.</p>
				</div>
			</div>
		</div>

		<div class="container">

			<div class="features-slider-wrap" data-aos="fade-up" data-aos-delay="100">
				<div class="features-slider" id="features-slider">

					<div class="item">

						<div class="feature bg-color-1">
							<img src="images/person_1.jpeg" alt="Image" class="img-fluid w-50 rounded-circle mb-4">

							<h3 class="mb-0">Fadwa Lacham</h3>
							<span class="text-black-50 mb-3 d-block">Website Creator</span>
							<p class="text-black-50">Far beyond, in the realm of volunteerism, this website serves to connect associations with volunteers.</p>

							
						</div>

					</div>

					<div class="item">

						<div class="feature bg-color-2">
							<img src="images/person_2.jpg" alt="Image" class="img-fluid w-50 rounded-circle mb-4">

							<h3 class="mb-0">Sara Masmoudi</h3>
							<span class="text-black-50 mb-3 d-block">Website Creator</span>
							<p class="text-black-50">Far beyond, in the realm of volunteerism, this website serves to connect associations with volunteers.</p>

						</div>

					</div>

				</div>
			</div>
		</div>

	</div>

	<div class="section ">
		<div class="container">
			<div class="row">
				<div class="col-lg-7" data-aos="fade-up" data-aos-delay="100">
					<div id="features-slider-nav">
						<button class="btn btn-primary" class="prev" data-controls="prev">Prev</button>
						<button class="btn btn-primary" class="next" data-controls="next">Next</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="section bg-light">
		<div class="container">
			<div class="row">
				<div class="col-lg-6" data-aos="fade-up">
					<div class="vision">
						<h2>Our Vision</h2>
						<p class="mb-4 lead">An Engaged World: We envision active communities, united by volunteerism. Each contributing, each benefiting, collectively creating a strong social fabric.</p>
						<p><a href="#" class="link-underline">Learn More</a></p>
					</div>
				</div>
				<div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
					<div class="mission">
						<h2>Our Mission</h2>
						<p class="mb-4 lead">Facilitating Engagement: We connect enthusiasts with volunteer opportunities tailored to their interests. We simplify access to positive action.</p>
						<p><a href="#" class="link-underline">Learn More</a></p>
					</div>
				</div>
			</div>		
		</div>		
	</div>

	<div class="site-footer">
		<div class="container">



			<div class="row mt-5">
				<div class="col-12 text-center">
					<p class="copyright">Copyright &copy;<script>document.write(new Date().getFullYear());</script>. All Rights Reserved. &mdash; Designed with love by us</a> <!-- License information: https://untree.co/license/ -->
					</p>
				</div>
			</div>
		</div> <!-- /.container -->
	</div> <!-- /.site-footer -->


	<!-- Preloader -->
	<div id="overlayer"></div>
	<div class="loader">
		<div class="spinner-border text-primary" role="status">
			<span class="visually-hidden">Loading...</span>
		</div>
	</div>

	<script src="js/bootstrap.bundle.min.js"></script>
	<script src="js/tiny-slider.js"></script>

	<script src="js/flatpickr.min.js"></script>
	<script src="js/glightbox.min.js"></script>


	<script src="js/aos.js"></script>
	<script src="js/navbar.js"></script>
	<script src="js/counter.js"></script>
	<script src="js/custom.js"></script>
</body>
</html>
