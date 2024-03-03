/* eslint-disable react/prop-types */
// src/components/ProductPage.js

import './ProductPageDetail.css';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { AiFillBell } from "react-icons/ai";
import api from '../../../../components/utils/requestAPI';
import LayoutMorder from "../../../../components/layout/LayoutMorder";


// eslint-disable-next-line no-unused-vars, react/prop-types
export default function ProductPage (){
  const {productId} = useParams();
  const [product, setProduct] = useState(null);
  const [loading, setLoading] = useState(true);
  const [rejectReason, setRejectReason] = useState('');
  const [approved, setApproved] = useState(false);
  const [notification, setNotification] = useState('');
  const [isNotificationVisible, setIsNotificationVisible] = useState(false);
  const navigate = useNavigate();
  // const history = useHistory();

  useEffect(() => {
    async function fetchDataProduct() {
      const url = `https://localhost:7227/api/Artwork/get-by-id?id=${productId}`;
      try {
        const response = await api.get(url);
        setProduct(response.data);
      } catch (error) {
        console.error('Error fetching product:', error);
      } finally {
        setLoading(false);
      }
    }

    fetchDataProduct();
  }, [productId]);
  

  if (loading) {
    return <div>Loading...</div>;
  }

  if (!product) {
    return <div>Product not found.</div>;
  }

  const handleApprove = async () => {
    try {
      const url = `https://localhost:7227/api/Artwork/update-artwork-proccessing?artworkId=${productId}`;
      const data = {
          reason: rejectReason        
      };
      const response = await api.post(url,data);
      console.log(response.data);
      console.log("Product Approve");
      setApproved(true);
      navigate("/content");
    } catch (error) {
      console.error("Error approving product:", error);
    }
  };
  const handleUnApprove = async () => {
    try {
      const url = `https://localhost:7227/api/Artwork/delete-artwork?id=${productId}`;
      const data = {
          reason: rejectReason        
      };
      const response = await api.delete(url);
      console.log(response.data);
      console.log("Product are delete");
      navigate("/content");
      const userid = product.userId; // Lấy userId của người dùng tương ứng với sản phẩm
    localStorage.setItem(`notification_${userid}`, rejectReason);
    // Hiển thị thông báo
    setIsNotificationVisible(true);
    } catch (error) {
      console.error("Error approving product:", error);
    }
  }
  const toggleNotification = () => {
    // Đóng hoặc mở thông báo khi nhấn vào icon
    setIsNotificationVisible(!isNotificationVisible);
  };
  return ( 
    <LayoutMorder>
    <div className="productdetail-page">
      <div className="body1">
     
          <img src={product.imageUrl} alt="Product" />        
        <div className="info-container">
        <div className='Box-notification'>
        <div className="notification-icon" >
        <AiFillBell onClick={toggleNotification}/>
        </div>
        {!isNotificationVisible && (
        <div className="notification-popup">
          {/* Nội dung thông báo */}
          <p>{notification}</p>
          
        </div>
      )}
        </div>
        {/* <button class="back-button"></button> */}
          <div className="details">
            <div className="author">{product.description}</div>
            <div className="title">{product.title}</div>
            <div className="image-info">
              <div className='price'>{product.price}$</div>
            </div>
          </div>
          <div className="actions">
            <textarea placeholder="Lý do " className="reject-reason"
            value={rejectReason}
            onChange={(e) => setRejectReason(e.target.value)}
            ></textarea>
            
            <button onClick={handleUnApprove}className="reject-button">UNAPPROVE</button>
            <div className="posting-time">Thời gian đăng: {product.time}</div>
            <button onClick={handleApprove}className="approve-button">APPROVE</button>
          </div>
        </div>
      </div>
      </div>
      </LayoutMorder>
  );
}

