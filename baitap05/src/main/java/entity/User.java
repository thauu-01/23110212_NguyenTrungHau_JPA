package entity;

   import jakarta.persistence.*;
   import jakarta.validation.constraints.NotNull;
   import java.util.List;

   @Entity
   @Table(name = "Users")
   public class User {
       @Id
       @GeneratedValue(strategy = GenerationType.IDENTITY)
       private int id;

       @NotNull
       private String username;

       @Column(name = "fullname")
       private String fullname;

       @NotNull
       private String password;

       private int roleid;  // 1: user, 2: manager, 3: admin

       @Column(name = "phone")
       private String phone;

       @Column(name = "image")
       private String image;

       @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
       private List<Category> categories;

       // Constructors
       public User() {}

       // Getters and Setters
       public int getId() { return id; }
       public void setId(int id) { this.id = id; }
       public String getUsername() { return username; }
       public void setUsername(String username) { this.username = username; }
       public String getFullname() { return fullname; }
       public void setFullname(String fullname) { this.fullname = fullname; }
       public String getPassword() { return password; }
       public void setPassword(String password) { this.password = password; }
       public int getRoleid() { return roleid; }
       public void setRoleid(int roleid) { this.roleid = roleid; }
       public String getPhone() { return phone; }
       public void setPhone(String phone) { this.phone = phone; }
       public String getImage() { return image; }
       public void setImage(String image) { this.image = image; }
       public List<Category> getCategories() { return categories; }
       public void setCategories(List<Category> categories) { this.categories = categories; }
   }