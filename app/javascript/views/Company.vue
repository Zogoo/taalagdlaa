<template>
  <table>
    <tbody>
      <tr>
        <th>name</th>
        <th>rating</th>
        <th>description</th>
      </tr>
      <tr v-for="company in companies" :key="company.id">
        <td>{{ company.name }}</td>
        <td>{{ company.rating }}</td>
        <td>{{ company.description }}</td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      total: 0,
      companies: []
    }
  },
  mounted () {
    axios.get('/api/company/all')
        .then(function(response){
          this.total = response.data['total'];
          this.companies = response.data['companies'];
        })
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
