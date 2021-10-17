<template>
  <div>
    <Header />
    <div class="pad-15-hor pad-15-ver search-parent">
      <!-- Quick filters -->
      <div class="quick-filters">
        <div class="filter-line">
          <div class="filter-content">
            <div class="filter-container">
              <div class="filter-button"
                v-if="categories"
                v-for="category in categories"
                :key="category.id"
              >
                <a class="hollow-button" @click="filter_by_category(category.name)">
                  <span class="hollow-btn-txt">
                    <span class="label-txt">{{category.name}}</span>
                  </span>
                  <span viewBox="0 0 24 24" width="24px" height="24px" class="filter-btn-icon-container">
                    <!-- put some svg icons -->
                  </span>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Search panel -->
      <div class="search-panel">
        <div class="search-panel-inner">
          <picture class="search-bar-pic">
            <img alt="" role="none" src="/public/assets/ub-cartoon.jpeg">
          </picture>
          <div class="search-bar-container">
            <div class="search-bar-container-inner">
              <div role="search" class="sb-form">
                <input @input="search_by_text()" v-model="search.text" type="search" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" required="" name="search-bar" class="sb-input" placeholder="Where to?" title="Search" role="searchbox" aria-label="Search" aria-controls="typeahead_results" aria-autocomplete="list" value="">
                <button class="sb-search-btn" title="Search" aria-label="Search" tabindex="-1">
                <!-- put some svg icon viewBox="0 0 24 24" width="1em"  -->
                </button>
              </div>
              <b-form-select
                @input="sort()"
                v-model="search.filter"
                :options="options"
              />
            </div>
          </div>
        </div>
      </div>

      <div>
        <span class="bold">Total Likes:</span>
        {{ likes.count }}
        <span class="bold">Hits:</span>
        {{ likes.hit }}
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
            @click="showCompanyDetail(company.id)"
          >
            <img class="card-img" :src="company.logo.url" />
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
              <h3>{{ company.name }}</h3>
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
import StarRating from "vue-star-rating";

export default {
  name: "Home",
  components: {
    Header,
    StarRating,
  },
  data: function () {
    return {
      total_result: 0,
      categories: [],
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
    axios.get('/api/category/all').then((response)=>{
      this.categories = response.data.categories;
    });
    axios.get("/api/company/all").then((response) => {
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
    showCompanyDetail(company_id) {
      this.$router.push({ name: "company", params: { id: company_id } });
    },
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
    search_by_text() {
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
    filter_by_category(name){
      this.filtered_companies = this.companies.filter(function (company) {
        if (
          company.category.name
            .toLowerCase()
            .indexOf(name.toLowerCase()) != "-1"
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
      this.companies = this.companies.map(function (company) {
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
.quick-filters {
  padding-top: 32px;
  padding-bottom: 24px;
}
.filter-line {
  position: relative;
  background-color: #fff;
}
.filter-content {
  width:calc(1300 + 2*24px);
  max-width: 100%;
  padding-left: 24px;
  padding-right: 24px;
  margin-left: auto;
  margin-right: auto;
  box-sizing: border-box;
}
.filter-container {
  margin-left: 10px;
  display: flex;
  -webkit-flex-wrap: wrap;
  flex-wrap: wrap;
  max-width: 100%;
}
.filter-button {
  display: flex;
  flex: 1 1 0;
  margin-left: 10px;
  margin-bottom: 20px;
}
.hollow-button {
  color: rgb(53, 147, 255);
  background-color: white;
  border: 1px solid;
  min-width: 150px;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  gap: 12px;
  padding: 11px 16px;
  transition: background-color .2s,color .2s;
  text-align: left;
  border-radius: 12px;
  align-items: flex-start;
  position: relative;
  cursor: pointer;
  box-sizing: border-box;
  text-decoration: none;
  width: 100%;
  flex-direction: row;
  overflow: hidden;
  justify-content: space-between;
  -webkit-justify-content: space-between;
  -ms-flex-pack: justify;
  height: 100%;
}
.hollow-button:hover {
  color: rgb(52, 88, 250);
  background-color: rgb(189, 229, 255);
  border-color: rgb(42, 195, 255);
}
.hollow-btn-txt {
  margin-top: 4px;
  text-overflow: ellipsis;
  overflow: hidden; 
  text-align: left;
  cursor: pointer;
}
.filter-btn-icon-container {
  line-height: 0;
  text-align: left;
      cursor: pointer;
}
.filter-btn-icon {
  fill: currentColor;
  vertical-align: bottom;
  display: inline-block;
  color: #000;
  line-height: 0;
  text-align: left;
  cursor: pointer;
}
.label-txt {
  font-family: "Trip Sans VF","Trip Sans",Arial,sans-serif;
  font-weight: 700;
  font-size: 16px;
  line-height: 20px;
  font-style: normal;
}
/* Search panel */
.search-panel {
  width: calc(1300px + 2*24px);
  max-width: 100%;
  padding-left: 24px;
  padding-right: 24px;
  margin-left: auto;
  margin-right: auto;
  box-sizing: border-box;
}
.search-panel-inner {
  height: 415px;
  background-color: #fdc735;
  position: relative;
  display: grid;
}
.search-bar-pic {
  position: absolute;
  top: 0;
  left: 0;
}
.search-bar-pic img {
  width: 1300px;
  height: 415px;
}
.search-bar-container {
  width: 807px;
  justify-self: center;
  padding-left: 0;
  padding-right: 0;
  align-self: center;
}
.search-bar-container-inner {
  height: 60px;
  position: relative;
  margin: 0 auto;
  z-index: 0;
  text-align: left;
}
.sb-form {
  padding: 0 12px;
  border-radius: 30px;
  box-shadow: 0 4px 4px rgb(0 0 0 / 25%);
  display: block;
  position: relative;
  background: #fff;
  overflow: hidden;
  text-align: left;
}
.sb-input {
  font-size: 18px;
  line-height: 36px;
  padding-left: 42px;
  height: 60px;
  text-overflow: ellipsis;
  outline: none;
  box-shadow: none;
  background: none;
  width: 100%;
  border-radius: 0;
  color: #000;
  border: none;
  appearance: none;
  box-sizing: border-box;
}
.sb-search-btn {
  width: 60px;
  height: 60px;
  pointer-events: none;
  background: none;
  position: absolute;
  display: flex;
  line-height: 0;
  color: #000;
  border: none;
  cursor: pointer;
  touch-action: manipulation;
  appearance: none;
  align-items: center;
  top: 0;
  justify-content: center;
}
/* Company */
.card-img {
  width: 200px;
  height: 200px;
}
</style>
