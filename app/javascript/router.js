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
      path: "/registration",
      component: () => import("./views/Registration"),
      meta: { authRequired: false },
    },
    {
      path: "/login",
      component: () => import("./views/Login"),
      meta: { authRequired: false },
    },
    {
      path: "/company/:id",
      name:"company",
      props: true,
      component: () => import("./views/Company"),
      meta: { authRequired: false },
    }
  ],
});
