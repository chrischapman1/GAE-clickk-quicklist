package objects;

import java.io.Serializable;

public class AdminUser implements Serializable {
    private String name = "a";
    private String password = "a";
    private boolean valid = false;

    public AdminUser() {}

    public boolean checkValid(String name, String password)
    {
        if ((name.equals(this.name) && password.equals(this.password)))
        {
            valid = true;
        }
        return valid;
    }

    public boolean isValid()
    {
        return valid;
    }
}
