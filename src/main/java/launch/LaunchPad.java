package launch;

import objects.Cart;
import objects.Day;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletContextEvent;
import java.io.IOException;
import java.sql.SQLException;


public class LaunchPad implements ServletContextListener {

        @Override
        public void contextDestroyed(ServletContextEvent arg0) {
            System.out.println("ServletContextListener destroyed");
        }

        //Run this before web application is started
        @Override
        public void contextInitialized(ServletContextEvent event) {
            /**HttpSession sesh = new HttpSession() {
                @Override
                public long getCreationTime() {
                    return 0;
                }

                @Override
                public String getId() {
                    return null;
                }

                @Override
                public long getLastAccessedTime() {
                    return 0;
                }

                @Override
                public ServletContext getServletContext() {
                    return null;
                }

                @Override
                public void setMaxInactiveInterval(int interval) {

                }

                @Override
                public int getMaxInactiveInterval() {
                    return 0;
                }

                @Override
                public HttpSessionContext getSessionContext() {
                    return null;
                }

                @Override
                public Object getAttribute(String name) {
                    return null;
                }

                @Override
                public Object getValue(String name) {
                    return null;
                }

                @Override
                public Enumeration<String> getAttributeNames() {
                    return null;
                }

                @Override
                public String[] getValueNames() {
                    return new String[0];
                }

                @Override
                public void setAttribute(String name, Object value) {

                }

                @Override
                public void putValue(String name, Object value) {

                }

                @Override
                public void removeAttribute(String name) {

                }

                @Override
                public void removeValue(String name) {

                }

                @Override
                public void invalidate() {

                }

                @Override
                public boolean isNew() {
                    return false;
                }
            }; */
            ServletContext session = event.getServletContext();
            Day day = new Day(false);
            Cart cart = new Cart();
            session.setAttribute("day", day);
            session.setAttribute("cart", cart);
            session.setAttribute("isClosed", false);
            session.setAttribute("adminUser", null);
        }
    }

