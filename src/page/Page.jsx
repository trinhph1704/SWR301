import React, { useState, useEffect } from "react";
import api from "../components/utils/requestAPI";
import useAuth from "../hooks/useAuth";
import "./Page.css";

const Page = () => {
  const { auth } = useAuth();
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [price, setPrice] = useState(0);
  const [genreID, setGenreID] = useState("");
  const [imageUrl, setImageUrl] = useState(""); // Sử dụng để lưu đường dẫn đến hình ảnh dưới dạng base64
  const [reason, setReason] = useState("");
  const [genreList, setGenreList] = useState([]);

  useEffect(() => {
    // Fetch genre list
    const fetchGenres = async () => {
      try {
        const response = await api.get("https://localhost:7227/api/Genre/get-all");
        const data = response.data.$values;
        setGenreList(data);
      } catch (error) {
        console.error('Error fetching genre data:', error);
      }
    };

    fetchGenres();
  }, []);

  const handleImageChange = (event) => {
    const file = event.target.files[0]; // Lấy file từ sự kiện onChange

    // Tạo một đối tượng FileReader
    const reader = new FileReader();

    // Đọc file như một chuỗi dạng data URL
    reader.readAsDataURL(file);

    // Được gọi khi quá trình đọc file hoàn thành
    reader.onload = () => {
      const imageUrl = reader.result; // Nhận kết quả dạng base64
      setImageUrl(imageUrl); // Cập nhật state imageUrl với đường dẫn mới
    };
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    const artworkData = {
      title: title,
      description: description,
      price: price,
      genreID: genreID,
      imageUrl: imageUrl, // Sử dụng đường dẫn imageUrl để lưu hình ảnh dưới dạng base64
      reason: reason
    };

    try {
      const response = await api.post(
        "https://localhost:7227/api/Artwork/create-new-artwork",
        artworkData,
      {
        headers: {
          Authorization: `Bearer ${auth.token}`,
        },
      }
      );
    
      console.log("Artwork created successfully:", response.data);
      // Handle success here, e.g., redirect user to another page
    } catch (error) {
      console.error("Error creating artwork:", error);
      // Handle error here, e.g., show error message to the user
    }
  }  

  return (
    <div className="artwork-form">
      <h1 className="form-title">Create Artwork</h1>
      <form onSubmit={handleSubmit}>

      <label className="form-label">
          Genre:
          <select
            value={genreID}
            onChange={(e) => setGenreID(e.target.value)}
          >
            <option value="">Select a genre</option>
            {genreList.map(genre => (
              <option key={genre.genreID} value={genre.genreID}>{genre.name}</option>
            ))}
          </select>
        </label>

        <label className="form-label">
          Title:
          <input
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            className="form-input"
          />
        </label>

        <label className="form-label">
          Description:
          <input
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            className="form-textarea"
          />
        </label>

        <label className="form-label">
          Price Paid:
          <input
            type="text"
            value={price}
            onChange={(e) => setPrice(e.target.value)}
            className="form-input"
          />
        </label>
        <div className="img-column-left">
          <p>your artwork in upload Image</p>
        
        <img src="/public/i.png" alt="your artwork in upload Image" />

        </div>
        <div className="img-column-right">
          <p>your artwork with your sign in Upload Image With Your Sign</p>
        
        <img src="/public/i_sign.png" alt="your artwork in upload Image" />

        </div>
        
        <div className="image-upload">
        <label className="form-label">
            Upload Image :
            <input
              
              type="file"
              accept="image/*"
              onChange={handleImageChange}
              className="form-select"
            />
          </label>
        </div>

        

        {/* Hiển thị hình ảnh */}
        {imageUrl && (
          <img src={imageUrl} alt="Artwork" style={{ maxWidth: "100px", maxHeight: "100px" }} />
        )}
        
         <div className="image-upload">
          <label className="form-label">
            Upload Image With Your Sign:
            <input
              
              type="file"
              accept="image/*"
              onChange={handleImageChange}
              className="form-select"
            />
          </label>
        </div>
        {imageUrl && (
          <img src={imageUrl} alt="Artwork" style={{ maxWidth: "100px", maxHeight: "100px" }} />
        )} 

        <label className="form-label">
          Reason:
          <input
            type="text"
            value={reason}
            onChange={(e) => setReason(e.target.value)}
          />
        </label>

        <button type="submit" className="submit-button">Add Artwork</button>
      </form>
    </div>
  );
};

export default Page;