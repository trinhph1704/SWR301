import React, { useState, useEffect } from 'react';
import "./HomePage.css";
import ReactPaginate from 'react-paginate';
import { FaHeart, FaRegHeart } from "react-icons/fa";
import { useNavigate } from 'react-router-dom'; // Import useNavigate instead of navigate
import api from "../components/utils/requestAPI"; // Import the api module
import useAuth from "../hooks/useAuth";

const HomePage = () => {
  const [savedProducts, setSavedProducts] = useState([]);
  const [currentPage, setCurrentPage] = useState(0);
  const productsPerPage = 6;

  const [artworkList, setArtworkList] = useState(null);
  const [userMap, setUserMap] = useState({}); // State để lưu thông tin người dùng
  const { auth } = useAuth();
  const navigate = useNavigate(); // Sử dụng useNavigate để chuyển hướng

  useEffect(() => {
    const fetchArtworks = async () => {
      const url = "https://localhost:7227/api/Artwork/get-all";
      try {
        const response = await api.get(url);
        const extractedArtworks = response.data.$values || [];
        setArtworkList(extractedArtworks);
        // Tạo bản đồ người dùng dựa trên userId từ danh sách các tác phẩm nghệ thuật
        const userIds = extractedArtworks.map(product => product.userId);
        fetchUsers(userIds);
      } catch (error) {
        console.error('Error fetching artwork data:', error);
      }
    };

    fetchArtworks();
  }, []);

  const fetchUsers = async (userIds) => {
    try {
      const promises = userIds.map(userId =>
        api.post("https://localhost:7227/api/User/get-by-id", { userId })
      );
      const responses = await Promise.all(promises);
      const userMap = {};
      responses.forEach((response, index) => {
        const userData = response.data;
        const userId = userIds[index];
        userMap[userId] = userData;
      });
      setUserMap(userMap);
    } catch (error) {
      console.error('Error fetching user data:', error);
    }
  };

  useEffect(() => {
    if (artworkList && artworkList.length > 0) {
      // Tạo bản đồ người dùng dựa trên userId từ danh sách các tác phẩm nghệ thuật
      const userIds = artworkList.map(product => product.userId);
      fetchUsers(userIds);
    }
  }, [artworkList]);

  if (!artworkList || !Array.isArray(artworkList)) {
    return <div>Loading...</div>;
  }

  const handlePageChange = ({ selected }) => {
    setCurrentPage(selected);
  };

  const indexOfLastProduct = (currentPage + 1) * productsPerPage;
  const indexOfFirstProduct = indexOfLastProduct - productsPerPage;
  const currentProducts = artworkList.slice(indexOfFirstProduct, indexOfLastProduct);

  const handleLikeToggle = (id, userId) => {
    if (!auth.user) {
      navigate('/log-in');
      return;
    }

    const likedProduct = artworkList.find(product => product.$id === id);

    if (!savedProducts.find(product => product.$id === id)) {
      setSavedProducts(prevSavedProducts => [...prevSavedProducts, likedProduct]);
    }

    setArtworkList(prevArtworkList =>
      prevArtworkList.map(product =>
        product.$id === id ? { ...product, liked: !product.liked } : product
      )
    );
  };

  const pageCount = Math.ceil(artworkList.length / productsPerPage);

  return (
    <div className="product-page">
      <h1>Collect art and design online</h1>
      <div className="product-list">
        {currentProducts.map((product) => (
          <div key={product.$id} className="product-itemm">
            <div className="product-card">
              <div className="product-images">
                <img src={product.imageUrl} alt={product.title} className="product-imagee" />
              </div>
              <div className="product-content">
                <p>Tác giả: {userMap[product.userId]?.username}</p>
                <h3 className="product-title">{product.title}</h3>
                <p>Giá: {product.price}</p>
                <div className="button-heart"> 
                  <button onClick={() => handleLikeToggle(product.$id, product.userId)} className={product.liked ? 'liked' : ''}>
                    {product.liked ? <FaHeart /> : <FaRegHeart />}
                  </button>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
      <ReactPaginate
        previousLabel={'Previous'}
        nextLabel={'Next'}
        pageCount={pageCount}
        marginPagesDisplayed={2}
        pageRangeDisplayed={5}
        onPageChange={handlePageChange}
        containerClassName={'pagination'}
        activeClassName={'active'}
      />
    </div>
  );
};

export default HomePage;
