import Vue from 'vue/dist/vue.esm'
import App from '../src/app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#home',
    data: {
      message: "Can you say hello?"
    },
    components: { App }
  })
})
