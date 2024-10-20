import React, { useState } from "react";
import axios from "axios";
import { Link, useNavigate } from "react-router-dom";

function Create() {
  const [values, setValues] = useState({
    name: "",
    email: "",
    age: "",
    gender: "",
  });

  const navigate = useNavigate();

  function handleSubmit(e) {
    e.preventDefault();

    axios
      .post("/add_user", values)
      .then((res) => {
        navigate("/");
        console.log(res);
      })
      .catch((err) => console.log(err));
  }
  return (
    <div className="container vh-100 vw-100 p-5">
      <div className="row justify-content-center">
        <div className="col-md-6 bg-white p-4 rounded shadow">
          <h3 className="text-center mb-4">Add Student</h3>

          <form onSubmit={handleSubmit}>
            <div className="form-group my-3">
              <label htmlFor="name">Name</label>
              <input
                type="text"
                className="form-control"
                name="name"
                required
                onChange={(e) => setValues({ ...values, name: e.target.value })}
              />
            </div>

            <div className="form-group my-3">
              <label htmlFor="email">Email</label>
              <input
                type="email"
                className="form-control"
                name="email"
                required
                onChange={(e) =>
                  setValues({ ...values, email: e.target.value })
                }
              />
            </div>

            <div className="form-group my-3">
              <label htmlFor="gender">Gender</label>
              <select
                className="form-control"
                name="gender"
                required
                onChange={(e) =>
                  setValues({ ...values, gender: e.target.value })
                }
              >
                <option value="">Select Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
              </select>
            </div>

            <div className="form-group my-3">
              <label htmlFor="age">Age</label>
              <input
                type="number"
                className="form-control"
                name="age"
                required
                onChange={(e) => setValues({ ...values, age: e.target.value })}
              />
            </div>

            <div className="form-group text-center">
              <button type="submit" className="btn btn-success px-5">
                Save
              </button>

              <Link to="/" className="btn btn-success mx-2 px-5">
              Home
            </Link>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}

export default Create;
