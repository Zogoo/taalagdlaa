/* Vue style of writing component: template, script and style*/
<template>
  <div class="pad-15-hor pad-15-ver header">
    <div>Responsive Search</div>
    <div>
      <i class="fas fa-bars"></i>
    </div>
  </div>
</template>
<script>
export default {
  name: "Header",
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