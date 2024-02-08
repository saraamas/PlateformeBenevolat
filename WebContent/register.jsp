<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
                                <li><a href="about.jsp">About</a></li>
                                <li ><a href="login.jsp">Login</a></li>
                            </ul>
                        </div>
                        <div class="col-2 text-end">
                            <a href="#" class="burger ms-auto float-end site-menu-toggle js-menu-toggle d-inline-block d-lg-none light">
                                <span></span>
                            </a>

                            <a href="#" class="call-us d-flex align-items-center">
                                <span class="icon-phone"></span>
                                <span>063-969-9614</span>
                            </a>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </nav>

<div class="hero overlay" style="background-image: url('images/img_v_6-min.jpg')">
    <div class="container">
        <div class="row align-items-center justify-content-center">
            <div class="col-lg-6 text-center">
                <h1 class="heading text-white mb-2" data-aos="fade-up">Join Us</h1>
                <p data-aos="fade-up" class="mb-5 text-white lead text-white-50">Embark on a journey of impact and connection. Your contribution matters. Volunteer with us and make a difference in the community.</p>

                <!-- Replace the previous form with the login form below -->
<form action="register" method="post" data-aos="fade-up" data-aos-delay="100">
    <div class="mb-3">
        <input type="text" class="form-control" placeholder="Email" name="email" required style="background-color: rgba(255, 255, 255, 0.8); color: #000;">
    </div>
    <div class="mb-3">
        <input type="password" class="form-control" placeholder="Password" name="password" required style="background-color: rgba(255, 255, 255, 0.8); color: #000;">
    </div>
    <div class="mb-3">
        <input type="password" class="form-control" placeholder="Confirm Password" name="confirmPassword" required style="background-color: rgba(255, 255, 255, 0.8); color: #000;">
    </div>
    <div class="mb-3">
        <select class="form-control" name="role" required style="background-color: rgba(255, 255, 255, 0.8); color: #000;">
            <option value="benevole">Benevole</option>
            <option value="adminassociation">Admin Association</option>
        </select>
    </div>
    <div class="mb-3">
        <input type="submit" value="Register" class="btn btn-primary me-4">
    </div>
</form>

                <!-- Add a link to create an account -->
               <p class="text-white">You have an account? <a href="login.jsp" class="text-primary">Login</a></p>

            </div>
        </div>
    </div>
</div>




 

    <div class="site-footer">
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
