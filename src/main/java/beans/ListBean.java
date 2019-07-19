package beans;

import objects.User;

import java.util.LinkedList;
import java.util.List;

public class ListBean {

    private List<User> dailyList ;

    public List<User> getDailyList() {
        return dailyList;
    }

    public void addDailyList(User current) {
        this.dailyList.add(current);
    }

    public ListBean() {
        dailyList = new LinkedList();
    }

    @Override
    public String toString() {
        String output = "";
        for (User current : dailyList)
        {
            output += current.toString();
        }
        return output;
    }
}
