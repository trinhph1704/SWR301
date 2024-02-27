import React, { useEffect, useState } from "react";
import "./Page.css";
import { FaRegEdit, FaTrashAlt } from "react-icons/fa";
import api from "../components/utils/requestAPI";
import { Link } from "react-router-dom";
import useAuth from "../hooks/useAuth";

const Page = () => {
  const { auth } = useAuth();
  const [genreList, setGenreList] = useState(null);

  useEffect(() => {
    const fetchGenres = async () => {
      const url = "https://localhost:7227/api/Genre/get-all";
      try {
        const response = await api.get(url);
        console.log(response.data);
        const extractedGenres = response.data.$values || []; // Kiểm tra nếu không có dữ liệu, gán một mảng rỗng
        setGenreList(extractedGenres);
      } catch (error) {
        console.error('Error fetching genre data:', error);
      }
    };

    fetchGenres();
  }, []);

  if (!genreList || !Array.isArray(genreList)) {
    return <div>Loading...</div>;
  }

  return (
    <div className="genre-page">
      <div className="genre-list">
        {genreList.map((genre) => (
          <div className="genre-item" key={genre.$id}>
            <div className="genre-item-detail">
              <h3 className="genre-name">{genre.name}</h3>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Page;
