import Vue from 'vue';
import App from '../app.vue'
import axios from "axios";
import router from "../router";
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
// Import Bootstrap an BootstrapVue CSS files (order is important)
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

// Make BootstrapVue available throughout your project
Vue.use(BootstrapVue)
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin)

Vue.prototype.$auth = {
  accessTokenField: "access-token",
  currentUserField: "current-user",

  setCurrentUser(user) {
    localStorage.setItem(this.currentUserField, JSON.stringify(user));
  },
  clearCurrentUser() {
    localStorage.removeItem(this.currentUserField);
  },
  getCurrentUser() {
    let user = localStorage.getItem(this.currentUserField);

    if (user != null && user != "null") {
      return JSON.parse(user);
    } else {
      return null;
    }
  },
  setAccessToken(token) {
    localStorage.setItem(this.accessTokenField, token);
  },
  clearAccessToken() {
    localStorage.removeItem(this.accessTokenField);
  },
  getAccessToken() {
    let storedToken = localStorage.getItem(this.accessTokenField);

    if (storedToken != null && storedToken != "null") {
      this.parseJwt(storedToken);
      return storedToken;
    } else {
      return null;
    }
  },
  checkAuthenticated() {
    try {
      this.parseJwt(localStorage.getItem(this.accessTokenField));
      return true;
    } catch (error) {
      return false;
    }
  },
  parseJwt(token) {
    let base64Url = token.split(".")[1];
    let base64 = base64Url.replace(/-/g, "+").replace(/_/g, "/");
    let jsonPayload = decodeURIComponent(
      atob(base64)
        .split("")
        .map(function(c) {
          return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2);
        })
        .join("")
    );

    return JSON.parse(jsonPayload);
  },
};

axios.defaults.headers.common = {
  "Accept": "application/json",
  "Content-type": "application/json",
  "X-Requested-With": "XMLHttpRequest",
  "Authorization": Vue.prototype.$auth.getAccessToken()
};

axios.interceptors.response.use(response => {
   return response;
}, error => {
  if (error.response.status === 401) {
    localStorage.setItem('currentUser', null);
    this.$auth.clearAccessToken();
    return router.push("/login");
  }
  return error;
});

router.beforeEach((to, from, next) => {
  // redirect to sign-in page if not logged in and trying to access a restricted page
  const authRequired = to.matched.some((record) => record.meta.authRequired);
  const loggedIn = Vue.prototype.$auth.checkAuthenticated();

  if (authRequired && !loggedIn) {
    return next("/login");
  }

  next();
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#home',
    router: router,
    components: { App }
  })
})
