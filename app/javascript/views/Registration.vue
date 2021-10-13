<template>
  <b-container fluid>
    <b-row class="my-1">
      <b-col sm="3">
        <label for="email">Email:</label>
      </b-col>
      <b-col sm="9">
        <b-form-input id="email" type="text" v-model="user.email" />
      </b-col>
    </b-row>
    <b-row class="my-1">
      <b-col sm="3">
        <label for="password">Password:</label>
      </b-col>
      <b-col sm="9">
        <b-form-input id="password" type="password" v-model="user.password" />
      </b-col>
    </b-row>
    <b-row class="my-1">
      <b-col sm="3">
        <label for="phone_number">Phone number:</label>
      </b-col>
      <b-col sm="9">
        <b-form-input
          id="phone_number"
          type="text"
          v-model="user.phone_number"
        />
      </b-col>
    </b-row>
    <b-button variant="outline-primary" @click="register_user">Register</b-button>
  </b-container>
</template>

<script>
import axios from "axios";

export default {
  name: "Registration",
  data: function () {
    return {
      user: {
        email: "",
        password: "",
        phone_number: "",
      },
    };
  },
  methods: {
    async register_user() {
      axios
        .post("/api/users", { user: this.user })
        .then((response) => {
          if (response.statusText == "OK") {
            this.$auth.setCurrentUser(response.data.user);
            this.$auth.setAccessToken(response.data.user.token);
            this.$router.push("/");
          }
        })
        .catch((error) => {
          if (error.response) {
            console.log(error.response.data);
            console.log(error.response.status);
            console.log(error.response.headers);
          }
        });
    },
  },
};
</script>
