import Vue from 'vue';
import VueRouter from "vue-router";

Vue.use(VueRouter);

export default new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/",
      component: () => import("./views/Home"),
      meta: { authRequired: false },
    },
    {
      path: "/sign_up",
      component: () => import("./views/Signup"),
      meta: { authRequired: false },
    }
  ],
});
