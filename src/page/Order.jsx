import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import useAuth from '../hooks/useAuth';
import api from '../components/utils/requestAPI';

export default function Order() {
  const [shippingMethod, setShippingMethod] = useState('');
  const [showShippingInfo, setShowShippingInfo] = useState(false);
  const [loading, setLoading] = useState(true);
  const [orders, setOrders] = useState([]);
  const { auth } = useAuth();
  const [user, setUser] = useState(null);
  const [artworkList, setArtworkList] = useState([]);

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        if (auth.user) {
          const response = await api.post("https://localhost:7227/api/User/get-by-id", { userId: auth.user.userId });
          setUser(response.data);
          const responseArtworks = await api.get("https://localhost:7227/api/Order/get-all");
          const allOrders = responseArtworks.data.$values;
          const userOrders = allOrders.filter(order => order.userId === auth.user.userId);

          setOrders(userOrders);
          setLoading(false);
        }
      } catch (error) {
        console.error('Error fetching user data:', error);
      }
    };

    fetchUserData();
  }, [auth]);
  useEffect(() => {
    const fetchArtworkData = async () => {
      try {
        const artworkPromises = orders.map(ord => api.get(`https://localhost:7227/api/Artwork/get-by-id?id=${ord.artworkId}`));
        const artworks = await Promise.all(artworkPromises);
        const artworkList = artworks.reduce((acc, artwork, index) => {
          acc[orders[index].artworkId] = artwork.data;
          return acc;
        }, {});
        setArtworkList(artworkList);
      } catch (error) {
        console.error('Error fetching artwork data:', error);
      }
    };

    if (orders.length > 0) {
      fetchArtworkData();
    }
  }, [orders]);

  const handleShippingMethodChange = (method) => {
    setShippingMethod(method);
    setShowShippingInfo(method === 'Shipping');
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // sau khi submit form
  };



  return (
    <div className="container">
      <div className="row">
        <div className="col-md-6">
          <h2 className="text-uppercase">DELIVERY SHIPPING</h2>
          <div className="title">
            <label>
              <input style={{marginLeft:'-10.35em'}}
                type="radio"
                name="shippingMethod"
                value="Shipping"
                checked={shippingMethod === 'Shipping'}
                onChange={() => handleShippingMethodChange('Shipping')}
              />
              Shipping
            </label>
          </div>
          <div className="title">
            <label>
              <input
                type="radio"
                name="shippingMethod"
                value="Arrange for pickup"
                checked={shippingMethod === 'Arrange for pickup'}
                onChange={() => handleShippingMethodChange('Arrange for pickup')}
              />
              Arrange for pickup (Free)
            </label>
          </div>
          {showShippingInfo && (
            <form onSubmit={handleSubmit}>
              <h2 className="text-uppercase">DELIVERY INFORMATION</h2>
              <div className="form-group row">
                <label className="col-sm-3 col-form-label font-weight-bold information">FULL NAME:</label>
                <div className="col-sm-9">
                  <input type="text" className="form-control" name="name" required />
                </div>
              </div>
              <div className="form-group row">
                <label className="col-sm-3 col-form-label font-weight-bold information">PHONE:</label>
                <div className="col-sm-9">
                  <input type="text" className="form-control" name="phone" required />
                </div>
              </div>
              <div className="form-group row">
                <label className="col-sm-3 col-form-label font-weight-bold information">COUNTRY:</label>
                <div className="col-sm-9">
                  <input type="text" className="form-control" name="country" required />
                </div>
              </div>
              <div className="form-group row">
                <label className="col-sm-3 col-form-label font-weight-bold information">ADDRESS:</label>
                <div className="col-sm-9">
                  <input type="text" className="form-control" name="address" required />
                </div>
              </div>
              {showShippingInfo && (
                <div className="mt-3">
                  <p style={{marginTop:'-45px'}}>Save information for later use!</p>
                </div>
              )}
              
              <Link to="/product-payment"><button type="submit" className="btn btn-primary" style={{ fontSize: '1.5rem', background: 'black', color: 'white', width: '400px', height:'40px' }}>Save and Continue</button></Link>
            </form>
          )}
        </div>
        <div className="col-md-6">
          <h2 className="text-uppercase" style={{width:'500px'}}>Order Summary</h2>
          
          <div className="box">
            {orders.map((ord) => (
              <div key={ord.$id} className="image-collection">
                <div className="overlay">
                {/* useEffect(() => {
  async function fetchDataProduct() => {
    try {
      const responseArt = await api.get(`https://localhost:7227/api/Artwork/get-by-id?id=${artworkId}`);
      const allArt = responseArt.data.$values;
          const userArt = allArt.filter(art => art.userId === auth.user.userId);
    } catch (error) {
      console.error('Error fetching artwork:', error);
    }
    }
    fetchDataProduct();
  }, [artworkId]); */}
  
  {artworkList[ord.artworkId] && <img src={artworkList[ord.artworkId].imageUrl} alt="Artwork" />}
                </div>
                <div className="details">
                  <div className="authors">{ord.total}</div>
                  <div className="titles">{ord.createDate}</div>   
                </div>
              </div>
            ))}
          </div>
          
        </div>
      </div>
    </div>
  );
}