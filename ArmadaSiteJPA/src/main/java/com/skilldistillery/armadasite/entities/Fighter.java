package com.skilldistillery.armadasite.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Fighter {

	// FIELDS

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private boolean unique;
	private int health;
	private int movement;
	private int cost;
	@Column(name = "special_ability")
	private String specialAbility;
	private String alignment;
	private String model;
	private Integer rating;
	@Column(name = "af_red")
	private int afRed;
	@Column(name = "af_blue")
	private int afBlue;
	@Column(name = "af_black")
	private int afBlack;
	@Column(name = "as_red")
	private int asRed;
	@Column(name = "as_blue")
	private int asBlue;
	@Column(name = "as_black")
	private int asBlack;

	// RELATIONSHIPS

	@ManyToMany
	@JoinTable(name = "fighter_keyword", joinColumns = @JoinColumn(name = "fighter_id"), inverseJoinColumns = @JoinColumn(name = "keyword_id"))
	private List<Keyword> keywords;

	@OneToMany(mappedBy = "fighter")
	@JsonIgnore
	private List<ListFighter> lists;

	@OneToOne
	@JoinColumn(name = "image_id")
	private Image image;
	
	@OneToMany(mappedBy = "fighter")
	private List<FighterDefenseToken> defenseTokens;
	
	// CONSTRUCTORS

	public Fighter() {
		super();
	}

	public Fighter(int id, String name, boolean unique, int health, int movement, int cost, String specialAbility,
			String alignment, String model, Integer rating, int afRed, int afBlue, int afBlack, int asRed, int asBlue,
			int asBlack, List<Keyword> keywords, List<ListFighter> lists, Image image, List<FighterDefenseToken> defenseTokens) {
		super();
		this.id = id;
		this.name = name;
		this.unique = unique;
		this.health = health;
		this.movement = movement;
		this.cost = cost;
		this.specialAbility = specialAbility;
		this.alignment = alignment;
		this.model = model;
		this.rating = rating;
		this.afRed = afRed;
		this.afBlue = afBlue;
		this.afBlack = afBlack;
		this.asRed = asRed;
		this.asBlue = asBlue;
		this.asBlack = asBlack;
		this.keywords = keywords;
		this.lists = lists;
		this.image = image;
		this.defenseTokens = defenseTokens;
	}

	// METHODS

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<FighterDefenseToken> getDefenseTokens() {
		return defenseTokens;
	}

	public void setDefenseTokens(List<FighterDefenseToken> defenseTokens) {
		this.defenseTokens = defenseTokens;
	}

	public Image getImage() {
		return image;
	}

	public void setImage(Image image) {
		this.image = image;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isUnique() {
		return unique;
	}

	public void setUnique(boolean unique) {
		this.unique = unique;
	}

	public int getHealth() {
		return health;
	}

	public void setHealth(int health) {
		this.health = health;
	}

	public int getMovement() {
		return movement;
	}

	public void setMovement(int movement) {
		this.movement = movement;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public String getSpecialAbility() {
		return specialAbility;
	}

	public void setSpecialAbility(String specialAbility) {
		this.specialAbility = specialAbility;
	}

	public String getAlignment() {
		return alignment;
	}

	public void setAlignment(String alignment) {
		this.alignment = alignment;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	public int getAfRed() {
		return afRed;
	}

	public void setAfRed(int afRed) {
		this.afRed = afRed;
	}

	public int getAfBlue() {
		return afBlue;
	}

	public void setAfBlue(int afBlue) {
		this.afBlue = afBlue;
	}

	public int getAfBlack() {
		return afBlack;
	}

	public void setAfBlack(int afBlack) {
		this.afBlack = afBlack;
	}

	public int getAsRed() {
		return asRed;
	}

	public void setAsRed(int asRed) {
		this.asRed = asRed;
	}

	public int getAsBlue() {
		return asBlue;
	}

	public void setAsBlue(int asBlue) {
		this.asBlue = asBlue;
	}

	public int getAsBlack() {
		return asBlack;
	}

	public void setAsBlack(int asBlack) {
		this.asBlack = asBlack;
	}

	public List<Keyword> getKeywords() {
		return keywords;
	}

	public void setKeywords(List<Keyword> keywords) {
		this.keywords = keywords;
	}

	public List<ListFighter> getLists() {
		return lists;
	}

	public void setLists(List<ListFighter> lists) {
		this.lists = lists;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + afBlack;
		result = prime * result + afBlue;
		result = prime * result + afRed;
		result = prime * result + ((alignment == null) ? 0 : alignment.hashCode());
		result = prime * result + asBlack;
		result = prime * result + asBlue;
		result = prime * result + asRed;
		result = prime * result + cost;
		result = prime * result + health;
		result = prime * result + id;
		result = prime * result + ((image == null) ? 0 : image.hashCode());
		result = prime * result + ((keywords == null) ? 0 : keywords.hashCode());
		result = prime * result + ((lists == null) ? 0 : lists.hashCode());
		result = prime * result + ((model == null) ? 0 : model.hashCode());
		result = prime * result + movement;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + rating;
		result = prime * result + ((specialAbility == null) ? 0 : specialAbility.hashCode());
		result = prime * result + (unique ? 1231 : 1237);
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Fighter other = (Fighter) obj;
		if (afBlack != other.afBlack)
			return false;
		if (afBlue != other.afBlue)
			return false;
		if (afRed != other.afRed)
			return false;
		if (alignment == null) {
			if (other.alignment != null)
				return false;
		} else if (!alignment.equals(other.alignment))
			return false;
		if (asBlack != other.asBlack)
			return false;
		if (asBlue != other.asBlue)
			return false;
		if (asRed != other.asRed)
			return false;
		if (cost != other.cost)
			return false;
		if (health != other.health)
			return false;
		if (id != other.id)
			return false;
		if (image == null) {
			if (other.image != null)
				return false;
		} else if (!image.equals(other.image))
			return false;
		if (keywords == null) {
			if (other.keywords != null)
				return false;
		} else if (!keywords.equals(other.keywords))
			return false;
		if (lists == null) {
			if (other.lists != null)
				return false;
		} else if (!lists.equals(other.lists))
			return false;
		if (model == null) {
			if (other.model != null)
				return false;
		} else if (!model.equals(other.model))
			return false;
		if (movement != other.movement)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (rating != other.rating)
			return false;
		if (specialAbility == null) {
			if (other.specialAbility != null)
				return false;
		} else if (!specialAbility.equals(other.specialAbility))
			return false;
		if (unique != other.unique)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Fighter [id=" + id + ", name=" + name + ", unique=" + unique + ", health=" + health + ", movement="
				+ movement + ", cost=" + cost + ", specialAbility=" + specialAbility + ", alignment=" + alignment
				+ ", model=" + model + ", rating=" + rating + ", afRed=" + afRed + ", afBlue=" + afBlue + ", afBlack="
				+ afBlack + ", asRed=" + asRed + ", asBlue=" + asBlue + ", asBlack=" + asBlack + "]";
	}

}
