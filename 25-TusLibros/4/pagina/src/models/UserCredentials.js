class UserCredentials {
    constructor() {
        this.userID = ''
        this.password = ''
    }
  
    setUserCredentials(userID, password) {
        this.userID = userID
        this.password = password
    }

    getUserId() {
        return this.userID
    }

    getPassword() {
        return this.password
    }
  }
  