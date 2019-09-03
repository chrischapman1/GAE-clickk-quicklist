package controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet(urlPatterns={"/IndexServlet"})
public class IndexServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(IndexServlet.class.getName());

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        // Extract the pool from the Servlet Context, reusing the one that was created
        // in the ContextListener when the application was started
        DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");

        boolean status = false;
        try (Connection conn = pool.getConnection()) {
            // PreparedStatements are compiled by the database immediately and executed at a later date.
            // Most databases cache previously compiled queries, which improves efficiency.
            PreparedStatement adminLoginStmt =  conn.prepareStatement(
                    "SELECT * FROM admin WHERE username=\'admin\' AND password=\'1234\'");
            // Execute the statement
            ResultSet loginResults = adminLoginStmt.executeQuery();
            // Convert a ResultSet into Vote objects
            while (loginResults.next()) {
                status = true;
            }

        } catch (SQLException ex) {
            // If something goes wrong, the application needs to react appropriately. This might mean
            // getting a new connection and executing the query again, or it might mean redirecting the
            // user to a different page to let them know something went wrong.
            throw new ServletException("Unable to successfully connect to the database. Please check the "
                    + "steps in the README and try again.", ex);
        }

        // Add variables and render the page
        req.setAttribute("status", status);
        req.getRequestDispatcher("WEB-INF/jsp/result.jsp").forward(req, resp);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        doPost(req, resp);
    }
}
