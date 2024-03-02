import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { FaHeart, FaRegHeart } from 'react-icons/fa';
import Na from "./Napage";
import api from "../components/utils/requestAPI"; 
import useAuth from "../hooks/useAuth";

const SavePage = () => {
  const { auth } = useAuth();
  const [savedProducts, setSavedProducts] = useState([]);

  useEffect(() => {
    const fetchSavedProducts = async () => {
      try {
        if (auth.user) {
          const response = await api.get(`https://localhost:7227/api/LikeCollection/get-collection-by-userid?userId=${auth.user.userId}`);
          const likedArtworks = response.data;
          const promises = likedArtworks.map(likedArtwork => api.get(`https://localhost:7227/api/Artwork/get-by-id?id=${likedArtwork.artworkId}`));
          const artworkResponses = await Promise.all(promises);
          const savedProducts = artworkResponses.map(response => response.data);
          setSavedProducts(savedProducts);
        }
      } catch (error) {
        console.error('Error fetching saved products:', error);
      }
    };

    fetchSavedProducts();
  }, [auth.user]);

  const handleUnLove = async (id, userId) => {
    try {
      // Gọi API để xóa sản phẩm khỏi danh sách lưu
      await api.delete(`https://localhost:7227/api/LikeCollection/Un-Love`, { data: { userId, artworkId: id } });

      // Cập nhật lại danh sách sản phẩm sau khi thay đổi
      const updatedProducts = savedProducts.filter(product => product.id !== id);
      setSavedProducts(updatedProducts);
    } catch (error) {
      console.error('Error un-loving product:', error);
    }
  };

  return (
    <div>
      <Na className="Navuser" />
      <h1>Your Saved Products</h1>
      <div className="product-list">
        {savedProducts.map((product) => (
          <div key={product.id} className="product-item">
            <div className="product-card">
              <div className="product-images">
                <img src={product.imageUrl} alt={product.name} className="product-image" />
              </div>
              <div className="product-content">
                <p>Author: {product.author}</p>
                <h3 className="product-title">{product.name}</h3>
                <p>Price: {product.price}</p>
                <button onClick={() => handleUnLove(product.id, auth.user.userId)} className="liked">
                  <FaHeart />
                </button>
                <Link to={`/product/${product.id}`}>View Details</Link>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default SavePage;
