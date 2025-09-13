package entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "Category")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int cateId;

    @NotNull
    @Column(name = "cate_name")
    private String cateName;

    @Column(name = "icons")
    private String icons;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;  // Owner

    // Constructors, Getters, Setters
    public Category() {}

    public int getCateId() { return cateId; }
    public void setCateId(int cateId) { this.cateId = cateId; }
    public String getCateName() { return cateName; }
    public void setCateName(String cateName) { this.cateName = cateName; }
    public String getIcons() { return icons; }
    public void setIcons(String icons) { this.icons = icons; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}