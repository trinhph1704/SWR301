import React, { useEffect, useState } from "react";
import "./Page.css";
import { FaRegEdit, FaTrashAlt } from "react-icons/fa";
import api from "../components/utils/requestAPI";
import { Link } from "react-router-dom";
import useAuth from "../hooks/useAuth";

const Page = () => {
  const { auth } = useAuth();
  const [genreList, setGenreList] = useState(null);
  const [selectedGenre, setSelectedGenre] = useState("");
  const [artworkTitle, setArtworkTitle] = useState("");
  const [artworkDescription, setArtworkDescription] = useState("");
  const [artworkPrice, setArtworkPrice] = useState("");
  const [imageFile, setImageFile] = useState(null);
  const [medium, setMedium] = useState("");
  useEffect(() => {
    const fetchGenres = async () => {
      const url = "https://localhost:7227/api/Genre/get-all";
      try {
        const response = await api.get(url);
        console.log(response.data);
        const extractedGenres = response.data.$values || [];
        setGenreList(extractedGenres);
      } catch (error) {
        console.error('Error fetching genre data:', error);
      }
    };

    fetchGenres();
  }, []);

  const handleGenreChange = (event) => {
    setSelectedGenre(event.target.value);
  };

  const handleArtworkTitleChange = (event) => {
    setArtworkTitle(event.target.value);
  };

  const handleArtworkDescriptionChange = (event) => {
    setArtworkDescription(event.target.value);
  };

  const handleArtworkPriceChange = (event) => {
    setArtworkPrice(event.target.value);
  };

  const handleImageUpload = (event) => {
    const file = event.target.files[0];
    setImageFile(file);
  };
  const handleSubmit = (e) => {
    e.preventDefault();
    // Gửi dữ liệu đến server hoặc xử lý dữ liệu theo nhu cầu
  };
  

  const handleCreateArtwork = async () => {
    try {
      const formData = new FormData();
      formData.append("title", artworkTitle);
      formData.append("description", artworkDescription);
      formData.append("price", artworkPrice);
      formData.append("genre", selectedGenre);
      formData.append("image", imageFile);

      const response = await api.post("https://localhost:7227/api/Artwork/create-new-artwork", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });

      console.log("Artwork created successfully:", response.data);
      // You may want to redirect the user to a success page or perform other actions.
    } catch (error) {
      console.error('Error creating artwork:', error);
      // Handle error scenarios, e.g., display an error message to the user.
    }
  };

  if (!genreList || !Array.isArray(genreList)) {
    return <div>Loading...</div>;
  }

  return (
    <div className="artwork-form">
      <h1 className="form-title">Create Artwork</h1>
      <form onSubmit={handleSubmit}>
        
      <label className="form-label">
            Select Genre:
          <select id="genre" 
          value={selectedGenre} 
          onChange={handleGenreChange}>
            <option value="" disabled>Select a genre</option>
            {genreList.map((genre) => (
              <option key={genre.$id} value={genre.name}>
                {genre.name}
              </option>
            ))}
          </select>
        </label>

        <br />
        <label className="form-label">
            Title:
            <input
              type="text"
              value={artworkTitle}
              onChange={(e) => handleArtworkTitleChange(e.target.value)}
              className="form-input"
            />
        </label>
        
        <br />

        <label className="form-label">
            Description
            <input
              value={artworkDescription}
              onChange={(e) => handleArtworkDescriptionChange(e.target.value)}
              className="form-textarea"
            />
        </label>

        <br/>

        
        <label className="form-label">
            Price Paid:
            <input
              type="text"
              value={artworkPrice}
              onChange={(e) => handleArtworkPriceChange(e.target.value)}
              className="form-input"
            />
        </label>
        
        <br />

        <div className="image-upload">
            <label className="form-label">
              Upload Image:
              <input
                type="file"
                value={imageFile}
                onChange={handleImageUpload}
                className="form-select"
              />
            </label>
        </div>

        <br />

        <button type="submit" className="submit-button" onClick={handleCreateArtwork}>
          Create Artwork
        </button>
      </form>
    </div>
  );
};
export default Page;
