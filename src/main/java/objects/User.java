package objects;

public class User {
    String name;
    String phoneemail;

    public User(String name, String phoneemail) {
        this.name = name;
        this.phoneemail = phoneemail;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneemail() {
        return phoneemail;
    }

    public void setPhoneemail(String phoneemail) {
        this.phoneemail = phoneemail;
    }

    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                ", phoneemail='" + phoneemail + '\'' +
                '}';
    }
}
