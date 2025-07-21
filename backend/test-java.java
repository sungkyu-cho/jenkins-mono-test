public class TestJava {
    public static void main(String[] args) {
        System.out.println("Java version: " + System.getProperty("java.version"));
        System.out.println("Java home: " + System.getProperty("java.home"));
        System.out.println("Java vendor: " + System.getProperty("java.vendor"));
        System.out.println("OS name: " + System.getProperty("os.name"));
        System.out.println("OS version: " + System.getProperty("os.version"));
        System.out.println("User home: " + System.getProperty("user.home"));
        System.out.println("Current directory: " + System.getProperty("user.dir"));
    }
} 