import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { FaHeart } from 'react-icons/fa';
import Na from "./Napage";
import api from "../components/utils/requestAPI"; 
import useAuth from "../hooks/useAuth";
import './SavePage.css'; 

const SavePage = () => {
  const { auth } = useAuth();
  const [savedProducts, setSavedProducts] = useState([]);
  const [artworks, setArtworks] = useState({});

  useEffect(() => {
    if (auth.user) {
      const fetchSavedProducts = async () => {
        try {
          const response = await api.get(`https://localhost:7227/api/LikeCollection/get-all-collection-by-userid?id=${auth.user.userId}`);
          if (Array.isArray(response.data.$values)) {
            const savedProductIds = response.data.$values.map(item => item.artworkId);
            setSavedProducts(savedProductIds);
            await fetchArtworks(savedProductIds);
          } else {
            console.error('Response data is not an array:', response.data);
          }
        } catch (error) {
          console.error('Error fetching saved products:', error);
        }
      };
      fetchSavedProducts();
    } else {
      setSavedProducts([]);
    }
  }, [auth.user]);

  const fetchArtworks = async (artworkIds) => {
    try {
      const promises = artworkIds.map(id =>
        api.get(`https://localhost:7227/api/Artwork/get-by-id?id=${id}`)
      );
      const responses = await Promise.all(promises);
      const artworkMap = {};
      responses.forEach((response, index) => {
        const artworkData = response.data;
        artworkMap[artworkIds[index]] = artworkData;
      });
      setArtworks(artworkMap);
    } catch (error) {
      console.error('Error fetching artwork data:', error);
    }
  };

  const handleUnLove = async (productId, userId) => {
    try {
      // Gọi API xử lý việc bỏ thích sản phẩm
      // Ví dụ: await api.delete(`https://localhost:7227/api/LikeCollection/remove-like?userId=${userId}&artworkId=${productId}`);
      // Sau đó cập nhật lại danh sách sản phẩm đã lưu
      setSavedProducts(savedProducts.filter(id => id !== productId));
    } catch (error) {
      console.error('Error removing like:', error);
    }
  };

  return (
    <div>
      <Na className="Navuser" />
     
      <div className="product-list">
        {/* Hiển thị danh sách sản phẩm đã lưu */}
        {savedProducts.map((productId) => (
          <div key={productId} className="product-item">
            {/* Hiển thị thông tin sản phẩm */}
            <Link to={`/product/${productId}`}>
              <img src={artworks[productId]?.imageUrl} alt={artworks[productId]?.title} className="product-image" />
              <p className="product-name">{artworks[productId]?.title}</p>
              <p className="product-price">{artworks[productId]?.price}</p>
            </Link>
            <FaHeart className="heart-icon" onClick={() => handleUnLove(productId, auth.user.userId)} />
          </div>
        ))}
      </div>
    </div>
  );
};

export default SavePage;
