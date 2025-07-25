package model.domain;

import java.util.Arrays;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class MovieDTO {
	private String title;
	private List<String> genres;
	
	public static MovieDTO fromRaw(String title, String rawGenres) {
	    List<String> genreList = Arrays.asList(rawGenres.split("\\|"));
	    return new MovieDTO(title, genreList);
	}

}


