/* Vue style of writing component: template, script and style*/
<template>
  <div class="pad-15-hor pad-15-ver header">
    <div>Responsive Search</div>
    <div>
      <i class="fas fa-bars"></i>
    </div>
    <b-button variant="outline-primary" @click="redreictToLogin">Login</b-button>
    <b-button variant="outline-primary" @click="redirectToSignUp">Register</b-button>
  </div>
</template>
<script>
export default {
  name: "Header",
  methods: {
    redirectToSignUp(){
      this.$router.push('/sign_up');
    },
    redreictToLogin(){
      this.$router.push('/login');
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