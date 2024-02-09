package com.JAVA.Servlets;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.Base64;

import org.mindrot.jbcrypt.BCrypt;

import com.JAVA.Beans.AdminAssociation;
import com.JAVA.Beans.Benevole;
import com.JAVA.Beans.User;
import com.JAVA.DAO.AdminAssociationDAOImpl;
import com.JAVA.DAO.BenevoleDAO;
import com.JAVA.DAO.BenevoleDAOImpl;
import com.JAVA.DAO.DAOException;
import com.JAVA.DAO.DAOFactory;
import com.JAVA.DAO.UserDAOImpl;

@WebServlet("/ProfileManaging")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,    // 2MB
                 maxFileSize = 1024 * 1024 * 10,         // 10MB
                 maxRequestSize = 1024 * 1024 * 50)      // 50MB
public class ProfileManaging extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    private UserDAOImpl userDAO;
    private AdminAssociationDAOImpl adminAssociationDAO;
    private BenevoleDAOImpl benevoleDAO;

    @Override
    public void init() throws ServletException {
        super.init();

        DAOFactory daoFactory = DAOFactory.getInstance();
        userDAO = new UserDAOImpl(daoFactory);
        adminAssociationDAO = new AdminAssociationDAOImpl(daoFactory);
        benevoleDAO = new BenevoleDAOImpl(daoFactory);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            viewProfile(request, response);
        } else if ("update".equals(action)) {
            showUpdateForm(request, response);
        }else {
            // Handle unknown or missing action parameter
            response.sendRedirect("error.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "view":
                    viewProfile(request, response);
                    break;
                case "update":
                    updateProfile(request, response);
                    break;
                default:
                    // Handle unknown action
                    response.sendRedirect("error.jsp");
            }
        } else {
            // Handle case where action parameter is missing
            response.sendRedirect("error.jsp");
        }
    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    try {
        // Retrieve user from the session
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Retrieve the user ID from the request parameter
        int userIdToShow;

        // Check if userIdToShow parameter is present in the request
        if (request.getParameter("userIdToShow") != null) {
            userIdToShow = Integer.parseInt(request.getParameter("userIdToShow"));
        } else {
            // If userIdToShow parameter is not present, show the profile of the logged-in user
            userIdToShow = currentUser.getIdUtilisateur();
        }

        // Retrieve the user details based on the user ID
        UserDAOImpl userDAO = new UserDAOImpl(DAOFactory.getInstance());
        User userProfile = userDAO.getUserById(userIdToShow);
        
        // Calculate base64Photo and set it as an attribute
        byte[] photoProfil = userProfile.getPhotoProfil();
        if (photoProfil != null) {
            String base64Photo = Base64.getEncoder().encodeToString(photoProfil);
            request.setAttribute("base64Photo", base64Photo);
        }

        // Add logic to set attributes for the view
		if (userProfile.getRole() == User.UserRole.adminassociation) {
		    AdminAssociation admin = adminAssociationDAO.getAdminAssociationById(userIdToShow);
		    User user=userDAO.getUserById(admin.getIdUtilisateur());
		    request.setAttribute("admin", admin);
		    request.setAttribute("user", user);

		    request.getRequestDispatcher("adminAssociationProfile.jsp").forward(request, response);
		} else if (userProfile.getRole() == User.UserRole.benevole) {
		    Benevole benevole = benevoleDAO.getBenevoleById(userIdToShow);
		    User user=userDAO.getUserById(benevole.getIdUtilisateur());
		    request.setAttribute("benevole", benevole);
		    request.setAttribute("user", user);

		    request.getRequestDispatcher("benevoleProfile.jsp").forward(request, response);
		} else {
		    // Handle other user roles if needed
		    response.sendRedirect("error.jsp");
		}
    } catch (NumberFormatException e) {
        // Handle the case where userId is not a valid integer
        e.printStackTrace();  // Log the exception or handle it accordingly
        response.sendRedirect("error.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        // Handle other exceptions appropriately
        response.sendRedirect("error.jsp");
    }
}


    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAOImpl userDAO = new UserDAOImpl(DAOFactory.getInstance());
        HttpSession session = request.getSession();

        // Assuming user is stored in session, adapt as needed
        User user = (User) session.getAttribute("user");

        if (user != null) {
            try {
                // Update common fields
                int idUser = user.getIdUtilisateur();

                // Update the password only if it is provided in the form
                String newMotDePasse = request.getParameter("motDePasse");
                String confirmMotDePasse = request.getParameter("confirmMotDePasse");

                // Check if a new password is provided and matches the confirmation
                if (newMotDePasse != null && !newMotDePasse.isEmpty() && newMotDePasse.equals(confirmMotDePasse)) {
                    // Hash the new password securely
                    String hashedPassword = hashPassword(newMotDePasse);
                    user.setMotDePasse(hashedPassword);
                }
                System.out.println("Mot de Passe updated: " + user.getMotDePasse());

                // Handle profile picture deletion
                boolean deletePhotoProfil = request.getParameter("deletePhotoProfil") != null;
                if (deletePhotoProfil) {
                    user.setPhotoProfil(null);
                } else {
                    // Handle profile picture upload
                    Part photoProfilPart = request.getPart("photoProfil");
                    byte[] photoProfil = getBytesFromPart(photoProfilPart);
                    user.setPhotoProfil(photoProfil);
                }
                System.out.println("Photo updated: " + user.getPhotoProfil());

                // Call the common update method
                userDAO.updateUser(user);

                // Update specific attributes based on the user's role
                if (user.getRole().equals(User.UserRole.adminassociation)) {
                    AdminAssociationDAOImpl adminAssociationDAO = new AdminAssociationDAOImpl(DAOFactory.getInstance());

                    // Now you can use the instance to call getAdminAssociationById
                    AdminAssociation admin = adminAssociationDAO.getAdminAssociationById(idUser);

                    System.out.println("AdminAssociation Existing: " + admin);

                    admin.setNom(request.getParameter("nom"));
                    admin.setDescription(request.getParameter("description"));
                    admin.setSecteurActivite(request.getParameter("secteurActivite"));
                    admin.setSiteWeb(request.getParameter("siteWeb"));
                    admin.setAdresse(request.getParameter("adresse"));
                    admin.setPhone(request.getParameter("phone"));
                    admin.setVille(request.getParameter("ville"));

                    System.out.println("AdminAssociation After: " + admin);

                    // Update other AdminAssociation attributes if needed
                    adminAssociationDAO.updateAdminAssociation(admin);

                } else if (user.getRole().equals(User.UserRole.benevole)) {
                    // Assuming you have an instance of BenevoleDAOImpl or another class that implements BenevoleDAO
                    BenevoleDAO benevoleDAO = new BenevoleDAOImpl(DAOFactory.getInstance());
                    Benevole benevole = benevoleDAO.getBenevoleById(idUser);

                    System.out.println("Benevole by id: " + user.getEmail() + benevole.getNom());

                    benevole.setNom(request.getParameter("nom"));
                    benevole.setPrenom(request.getParameter("prenom"));
                    benevole.setTitreProfessionnel(request.getParameter("titreProfessionnel"));
                    benevole.setResume(request.getParameter("resume"));
                    benevole.setSexe(request.getParameter("sexe"));

                    String dateNaissanceString = request.getParameter("dateNaissance");
                    if (dateNaissanceString != null && !dateNaissanceString.isEmpty()) {
                        LocalDate dateNaissance = LocalDate.parse(dateNaissanceString); // Adjust the parsing format if necessary
                        benevole.setDateNaissance(dateNaissance);
                    }

                    // Update other Benevole attributes if needed
                    benevoleDAO.updateBenevole(benevole);
                }

                // After updating the user and admin data
                session.setAttribute("user", user);
                
                response.sendRedirect(request.getContextPath() + "/ProfileManaging?action=view");

             
            } catch (DAOException | IOException | ServletException e) {
                e.printStackTrace();
                // Handle the exception, redirect to an error page, or set an error message attribute
                response.sendRedirect("error.jsp");
            }
        } else {
            // Handle the case where the user is not logged in
            response.sendRedirect("login.jsp");
        }
    }
    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve user from the session
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            // Retrieve the user ID from the request parameter
            int userIdToUpdate;

            // Check if userIdToUpdate parameter is present in the request
            if (request.getParameter("userIdToUpdate") != null) {
                userIdToUpdate = Integer.parseInt(request.getParameter("userIdToUpdate"));
            } else {
                // If userIdToUpdate parameter is not present, show the update form for the logged-in user
                userIdToUpdate = currentUser.getIdUtilisateur();
            }

            // Retrieve the user details based on the user ID
            UserDAOImpl userDAO = new UserDAOImpl(DAOFactory.getInstance());
            User userProfile = userDAO.getUserById(userIdToUpdate);

            // Calculate base64Photo and set it as an attribute
            byte[] photoProfil = userProfile.getPhotoProfil();
            if (photoProfil != null) {
                String base64Photo = Base64.getEncoder().encodeToString(photoProfil);
                request.setAttribute("base64Photo", base64Photo);
            }

            // Add logic to set attributes for the update form
            if (userProfile.getRole() == User.UserRole.adminassociation) {
                AdminAssociation admin = adminAssociationDAO.getAdminAssociationById(userIdToUpdate);
                request.setAttribute("admin", admin);
                request.getRequestDispatcher("update-adminAssociationProfile.jsp").forward(request, response);
            } else if (userProfile.getRole() == User.UserRole.benevole) {
                Benevole benevole = benevoleDAO.getBenevoleById(userIdToUpdate);
                request.setAttribute("benevole", benevole);
                request.getRequestDispatcher("update-benevoleProfile.jsp").forward(request, response);
            } else {
                // Handle other user roles if needed
                response.sendRedirect("error.jsp");
            }
        } catch (NumberFormatException e) {
            // Handle the case where userId is not a valid integer
            e.printStackTrace();  // Log the exception or handle it accordingly
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle other exceptions appropriately
            response.sendRedirect("error.jsp");
        }
    }

    private byte[] getBytesFromPart(Part part) throws IOException {
        if (part != null) {
            InputStream inputStream = part.getInputStream();
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                byteArrayOutputStream.write(buffer, 0, bytesRead);
            }
            return byteArrayOutputStream.toByteArray();
        }
        return null;
    }
    
    private String hashPassword(String password) {
        // Generate a secure hash with BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        return hashedPassword;
    }
}
