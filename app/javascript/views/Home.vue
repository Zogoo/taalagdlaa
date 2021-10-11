<template>
  <div>
    <Header />
    <div class="pad-15-hor pad-15-ver search-parent">
      <div class="search-bar">
        <b-form-input
          @input="search_text()"
          v-model="search.text"
          type="text"
          placeholder="Search by Name"
        ></b-form-input>
        <span class="search-icon">
          <i class="fas fa-search"></i>
        </span>
      </div>
      <div>
        <span class="bold">Total Likes:</span>
        {{ likes.count }}
        <span class="bold">Hits:</span>
        {{ likes.hit }}
      </div>
      <div>
        <b-form-select
          @input="sort()"
          v-model="search.filter"
          :options="options"
        />
      </div>
    </div>
    <div class="container-fluid">
      <div class="row">
        <div
          class="col-md-6 pad-15-ver"
          v-for="company in filtered_companies"
          :key="company.id"
        >
          <div
            class="card-inner"
            @mouseover="show_hover(true, company.id)"
            @mouseout="show_hover(false, 0)"
          >
            <img class="card-img" :src="company.logo.url"/>
            <div
              class="card-bottom pad-15-hor"
              v-show="!hover_flag || active_id != company.id"
            >
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
            <div
              :class="{ 'card-hover': 1 }"
              v-show="hover_flag && active_id == company.id"
            >
              <h3>{{company.name}}</h3>
              <span
                @click="make_active(company.id)"
                :class="{
                  fas: 1,
                  'fa-heart': 1,
                  'absolute-star': 1,
                  green: check_active(company.id),
                }"
                >{{ company.likes }}</span
              >
              <h5>{{ company.address }}</h5>
              <p>{{ company.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Header from "./components/Header.vue";
import StarRating from 'vue-star-rating'

export default {
  name: "Home",
  components: {
    Header,
    StarRating
  },
  data: function () {
    return {
      total_result: 0,
      companies: [],
      filtered_companies: [],
      hover_flag: false,
      active_id: 0,
      options: [
        { value: null, text: "Sort By" },
        { value: "a", text: "Ratings" },
        { value: "b", text: "Likes" },
      ],
      search: { filter: null, text: "" },
      likes: { count: 0, hit: 0 },
    };
  },
  mounted() {
    axios
      .get("/api/company/all")
      .then((response) => {
        this.total_result = response.data.total;
        this.companies = response.data.companies;
        response.data.companies.map((company) => {
          this.likes.count += company.ratings;
        });
        this.companies = this.companies.map((company) => {
          company.active_like = false;
          return company;
        });
        this.filtered_companies = response.data.companies;
      });
  },
  methods: {
    show_hover(flag, active_id) {
      this.hover_flag = flag;
      this.active_id = active_id;
    },
    sort() {
      //console.log(this.search.filter);
      this.search.filter == "b"
        ? this.filtered_companies.sort(function (a, b) {
            return b.likes - a.likes;
          })
        : this.filtered_companies.sort(function (a, b) {
            return b.ratings - a.ratings;
          });
    },
    search_text() {
      //console.log(this.search.text);
      var inside = this;
      this.filtered_companies = this.companies.filter(function (company) {
        if (
          company.name
            .toLowerCase()
            .indexOf(inside.search.text.toLowerCase()) != "-1"
        ) {
          return company;
        }
      });
    },
    check_active(id) {
      var flag = false;
      this.companies.map(function (company) {
        if (company.id == id) {
          flag = company.active_like;
        }
      });
      return flag;
    },
    make_active(id) {
      this.likes.hit++;
      this.companies = this.companies.map(function (
        company
      ) {
        if (company.id == id) {
          company.active_like = !company.active_like;
          company.active_like ? company.likes++ : company.likes--;
        }
        return company;
      });
      var inside = this;
      inside.likes.count = 0;
      this.companies.map(function (company) {
        inside.likes.count += company.likes;
      });
    },
  },
};
</script>

<style scoped>
/* Styles are scoped to this component only.*/
/* Style for Desktop/Tablet  */
.search-parent {
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  background-color: lightgray;
}
.card-inner {
  position: relative;
  overflow: hidden;
  box-shadow: 2px 2px 8px grey;
}
.card-img {
  max-width: 100%;
  height: 100;
  width: 100;
}
.search-bar {
  position: relative;
}
.search-bar input {
  padding-left: 30px;
}
.search-icon {
  position: absolute;
  top: 8px;
  left: 8px;
}
.absolute-star {
  position: absolute;
  top: 10px;
  right: 10px;
}
.card-hover p {
  font-size: 10px;
  text-align: center;
}
.bold {
  font-weight: 500;
}
.rating-div {
  width: 200px;
}
.card-bottom {
  position: absolute;
  bottom: 0;
  left: 0;
  height: 30px;
  width: 100%;
  background-color: white;
  opacity: 0.7;
  display: flex;
  justify-content: space-between;
}
.card-hover {
  position: absolute;
  right: 15px;
  left: 15px;
  top: 15px;
  bottom: 15px;
  background-color: white;
  opacity: 0.7;
  display: flex;
  flex-flow: column wrap;
  justify-content: center;
  align-items: center;
}
/* For Mobile Device, we will be going with column wrap approach */
@media screen and (max-width: 550px) {
  .search-parent {
    display: flex;
    flex-flow: column wrap;
    justify-content: center;
    align-items: center;
    background-color: lightgray;
  }
  .search-parent div {
    width: 100%;
    text-align: center;
  }
}
</style>
