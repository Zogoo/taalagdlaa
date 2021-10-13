<template>
  <div class="container-fluid">
    <img class="card-img" :src="company.logo.url"/>
    <div class="card-bottom pad-15-hor">
      <div class="max-width-160">
        <span class="bold">{{ company.name }}</span>
      </div>
      <div class="min-width-160">
        <span class="bold">Ratings:</span>
        <star-rating
          :rating="company.ratings"
          :show-rating="false"
          :inline="true"
          :star-size="15"
        ></star-rating>
      </div>
      <div class="max-width-160">
        <span class="bold">{{ company.address }}</span>
      </div>
    </div>
    <comment :company-id="company.id"/>
  </div>
</template>

<script>
import axios from 'axios';
import StarRating from 'vue-star-rating';
import Comment from './components/Comment';
export default {
  props: ['id'],
  components: {
    Comment,
    StarRating
  },
  data: function(){
    return {
      company: {}
    }
  },
  mounted(){
    axios.get('/api/company', {
      params: {
        id: this.id
      }
    }).then((response) => {
      this.company = response.data;
    }).catch((error) => {
      console.log(error.response);
      this.$router.push("/");
    });
  },
}
</script>

<style>
.card-img {
  max-width: 100%;
  height: 200;
  width: 200;
}
</style>