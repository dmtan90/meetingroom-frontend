<template>
  <div class="register container">
    <div class="row">
      <div class="col-md-3"></div>
      <div class="col-md-6">
        <img src="/img/logo.svg" alt="Logo" class="img-logo" />
        <div class="card">
          <h1 class="card-header">LOGIN</h1>
          <div class="card-body">
            <form @submit.prevent="onSubmit()">
              <div class="form-group">
                <label for>ชื่อผู้ใช้งาน</label>
                <input
                  type="text"
                  name="u_username"
                  v-validate="{ required: true }"
                  v-model.trim="form.u_username"
                  :class="{ 'is-invalid': errors.has('u_username') }"
                  class="form-control"
                />
                <span class="invalid-feedback">
                  {{ errors.first("u_username") }}
                </span>
              </div>

              <div class="form-group">
                <label for>รหัสผ่าน</label>
                <input
                  type="password"
                  name="u_password"
                  v-validate="{ required: true }"
                  v-model.trim="form.u_password"
                  :class="{ 'is-invalid': errors.has('u_password') }"
                  class="form-control"
                />
                <span class="invalid-feedback">
                  {{ errors.first("u_password") }}
                </span>
              </div>

              <div v-if="errorMessage" class="alert alert-warning text-center">
                {{ errorMessage }}
              </div>

              <div class="form-group buttons">
                <button type="submit" class="btn btn-info btn-block">
                  เข้าสู่ระบบ
                </button>

                <button
                  type="button"
                  @click="onRedirectToRegister()"
                  class="btn btn-secondary btn-block"
                >
                  ลงทะเบียน
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="col-md-3"></div>
    </div>
  </div>
</template>

<script>
import { api } from "../services/api";
export default {
  data() {
    return {
      form: {
        u_username: "",
        u_password: ""
      },
      errorMessage: ""
    };
  },
  methods: {
    // ส่งข้อมูลไปตรวจสอบ
    onSubmit() {
      /* eslint-disable no-unused-vars */
      this.$validator.validateAll().then(valid => {
        if (!valid) return;
        api
          .post("api/account/login", this.form)
          .then(response => {
            console.log("Login Success:", response);
            this.$router.push({ name: "home" }); // redirect
          })
          .catch(err => (this.errorMessage = err.response.data.message));
      });
      /* eslint-enable no-unused-vars */
    },
    // ล้างค่า Form
    onReset() {
      this.errorMessage = null;
      this.$validator.reset();
      this.form = {
        u_username: "",
        u_password: ""
      };
    },
    // ไปที่หน้าเข้าลงทะเบียน
    onRedirectToRegister() {
      this.$router.push({ name: "register" });
    }
  }
};
</script>

<style scoped>
.img-logo {
  width: 90%;
  display: block;
  margin: auto;
  margin-top: 10%;
  margin-bottom: 30px;
}
h1 {
  font-size: 18px;
  font-weight: 600;
  text-align: center;
  letter-spacing: 5px;
}
.card {
  margin-bottom: 15%;
}
.card-body {
  padding-left: 15%;
  padding-right: 15%;
}
.buttons .btn-secondary {
  margin-top: 20px;
}
.buttons {
  margin-top: 30px;
  margin-bottom: 50px;
}
</style>
