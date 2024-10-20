import React, { useState, useEffect } from "react";
import { Link, useParams, useNavigate } from "react-router-dom";
import axios from "axios";

function Edit() {
  const [data, setData] = useState([]);
  const { id } = useParams();
  useEffect(() => {
    axios
      .get(`/get_student/${id}`)
      .then((res) => {
        setData(res.data);
      })
      .catch((err) => console.log(err));
  }, [id]);

  const navigate = useNavigate();

  function handleSubmit(e) {
    e.preventDefault();

    axios
      .post(`/edit_user/${id}`, data[0])
      .then((res) => {
        navigate("/");
        console.log(res);
      })
      .catch((err) => console.log(err));
  }

  return (
    <div className="container-fluid vw-100 vh-100 p-5">
      <h1>User {id}</h1>
      {data.map((student, index) => (
        <form
          key={student.id}
          onSubmit={handleSubmit}
          className="bg-white p-4 rounded shadow"
        >
          <div className="form-group my-3">
            <label htmlFor="name">Name</label>
            <input
              value={student.name}
              type="text"
              name="name"
              className="form-control"
              required
              onChange={(e) => {
                const updatedData = [...data];
                updatedData[index].name = e.target.value;
                setData(updatedData);
              }}
            />
          </div>

          <div className="form-group my-3">
            <label htmlFor="email">Email</label>
            <input
              value={student.email}
              type="email"
              name="email"
              className="form-control"
              required
              onChange={(e) => {
                const updatedData = [...data];
                updatedData[index].email = e.target.value;
                setData(updatedData);
              }}
            />
          </div>

          <div className="form-group my-3">
            <label htmlFor="gender">Gender</label>
            <input
              value={student.gender}
              type="text"
              name="gender"
              className="form-control"
              required
              onChange={(e) => {
                const updatedData = [...data];
                updatedData[index].gender = e.target.value;
                setData(updatedData);
              }}
            />
          </div>

          <div className="form-group my-3">
            <label htmlFor="age">Age</label>
            <input
              value={student.age}
              type="number"
              name="age"
              className="form-control"
              required
              onChange={(e) => {
                const updatedData = [...data];
                updatedData[index].age = e.target.value;
                setData(updatedData);
              }}
            />
          </div>

          <div className="form-group text-center">
            <button type="submit" className="btn btn-success px-5">
              Save
            </button>

            <Link to="/" className="btn btn-success mx-3 px-5">
              Back
            </Link>
          </div>
        </form>
      ))}
    </div>
  );
}

export default Edit;
