/* Vue style of writing component: template, script and style*/
<template>
  <div class="pad-15-hor pad-15-ver header">
    <div>Hello, {{ currentUserName() }}</div>
    <div>
      <i class="fas fa-bars"></i>
    </div>
    <b-button v-if="showLoginBar()" variant="outline-primary" @click="redreictToLogin">Login</b-button>
    <b-button v-if="showLoginBar()" variant="outline-primary" @click="redirectToSignUp">Register</b-button>
    <b-button v-if="!showLoginBar()" variant="outline-primary" @click="logOut">Logout</b-button>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  name: "Header",
  data: function () {
    return {
    }
  },
  methods: {
    showLoginBar(){
      return this.currentUserName() == 'Guest';
    },
    currentUserName(){
      const user = this.$auth.getCurrentUser();
      return user.email;
    },
    redirectToSignUp(){
      this.$router.push('/registration');
    },
    redreictToLogin(){
      this.$router.push('/login');
    },
    async logOut(){
      axios
        .delete('/api/users/sign_out')
        .then((response)=>{
          console.log(response.status);
          this.$auth.clearCurrentUser();
          this.$auth.clearAccessToken();
          this.$router.push("/");
          this.$router.go();
        })
        .catch((error)=>{
          if (error.response) {
            console.log(error.response.data);
            console.log(error.response.status);
            console.log(error.response.headers);
          }
        });
    }
  }
};
</script>
<style scoped>
.header {
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  padding: 15px 20px;
}

.header-title {
  font-weight: 700;
}
</style>
