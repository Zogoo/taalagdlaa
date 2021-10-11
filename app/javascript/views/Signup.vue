<template>
  <b-container fluid>
    <b-row class="my-1">
      <b-col sm="3">
        <label for="email">Email:</label>
      </b-col>
      <b-col sm="9">
        <b-form-input id="email" type="text" v-bind="email"/>
      </b-col>
    </b-row>
    <b-row class="my-1">
      <b-col sm="3">
        <label for="password">Password:</label>
      </b-col>
      <b-col sm="9">
        <b-form-input id="password" type="password" v-bind="password"/>
      </b-col>
    </b-row>
    <b-row class="my-1">
      <b-col sm="3">
        <label for="phone_number">Phone number:</label>
      </b-col>
      <b-col sm="9">
        <b-form-input id="phone_number" type="text" :v-bind="phone_number"/>
      </b-col>
    </b-row>
    <b-button variant="outline-primary" @click="register_user">Register</b-button>
  </b-container>
</template>

<script>
import axios from "axios";

export default {
  name: 'Signup',
  data: function (){
    return {
      email: '',
      password: '',
      phone_number: ''
    }
  },
  methods: {
    register_user() {
      axios.post('/api/users',{
        email: this.email,
        password: this.password,
        password_confirmation: this.password,
        phone_number: this.phone_number
      }).then((response) => {
        if (response.data.status == '200') {
          localStorage.setItem('currentUser', JSON.stringify(response.data.user));
          this.$auth.setAccessToken(response.data.user.token);
          this.$router.push('/');
        }
      });
    }
  }
}
</script>

