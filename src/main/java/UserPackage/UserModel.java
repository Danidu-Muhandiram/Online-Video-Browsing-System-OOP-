package UserPackage;

public class UserModel {
	// User class
	public static class User {
		private String userId;
		private String firstName;
		private String lastName;
		private String username;
		private String email;
		private String password;
		private String profilePicture;
		private String userType;

		public User() {
		}

		public User(String userId, String firstName, String lastName, String username, String email, String password,
				String profilePicture, String userType) {
			this.userId = userId;
			this.firstName = firstName;
			this.lastName = lastName;
			this.username = username;
			this.email = email;
			this.password = password;
			this.profilePicture = profilePicture;
			this.userType = userType;
		}

		// Getters and Setters
		public String getUserId() {
			return userId;
		}

		public void setUserId(String userId) {
			this.userId = userId;
		}

		public String getFirstName() {
			return firstName;
		}

		public void setFirstName(String firstName) {
			this.firstName = firstName;
		}

		public String getLastName() {
			return lastName;
		}

		public void setLastName(String lastName) {
			this.lastName = lastName;
		}

		public String getUsername() {
			return username;
		}

		public void setUsername(String username) {
			this.username = username;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public String getProfilePicture() {
			return profilePicture;
		}

		public void setProfilePicture(String profilePicture) {
			this.profilePicture = profilePicture;
		}

		public String getUserType() {
			return userType;
		}

		public void setUserType(String userType) {
			this.userType = userType;
		}
	}
}