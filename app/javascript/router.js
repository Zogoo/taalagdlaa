import Vue from 'vue/dist/vue.esm'
import VueRouter from "vue-router";

Vue.use(VueRouter);

export default new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/",
      component: () => import("./views/Company"),
      meta: { authRequired: false },
    },
  ],
});
