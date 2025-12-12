package AdminPackage;


public class notices {

    private int id;
    private String title;
    private String message;

    // Constructor
    public notices(int id, String title, String message) {
        this.id = id;
        this.title = title;
        this.message = message;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
