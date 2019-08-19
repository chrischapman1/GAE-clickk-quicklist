package objects;

import java.io.Serializable;

public class AdminUser implements Serializable {
    private String username;
    private boolean valid;

    public AdminUser() {
        this.username = "";
        this.valid = false;
    }

    public AdminUser(String username) {
        this.username = username;
        this.valid = true;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isValid() {
        return valid;
    }
}
