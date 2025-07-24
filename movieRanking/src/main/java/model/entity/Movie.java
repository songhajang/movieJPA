package model.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity

@Table(name = "MOVIE")
public class Movie {
    @Id
    @Column(name = "\"userId\"")
    private long userId;

    @Column(name = "\"movieId\"")
    private long movieId;

    @Column(name = "\"rating\"")
    private double rating;

    @Column(name = "\"title\"")
    private String title;

    @Column(name = "\"genres\"")
    private String genres;
}
