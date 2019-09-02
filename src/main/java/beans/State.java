package beans;

import objects.AdminUser;
import objects.Day;

public class State {
    public enum Action {

    }

    private Day day;
    private Action currentState;
    private boolean adminUser;
    private String lastBooked;
}
