import React, { useState, useEffect } from 'react';
import api from '../../../../components/utils/requestAPI';
import'./Report.css';

function HistoryPage() {
  const [history, setHistory] = useState([]);

  useEffect(() => {
    async function fetchHistory() {
      try {
        const response = await api.get(`/api/Artwork/get-history-artwork-true`);
        setHistory(response.data.$values);
      } catch (error) {
        console.error('Error fetching history:', error);
      }
    }

    fetchHistory();
  }, []);

  return (
    <div className="history-page">
      <h1>History</h1>
      <div className="history-list">
        {history.map((item) => (
          <div key={item.artworkId} className="history-item">
            <div className="history-info">
              <div className="history-detail">
            <div className="history-nameArtwork">Artwork: {item.description}</div>
            <div className="history-status">Status: {item.statusProcessing}</div>
            <div className="history-time">Time: {item.timeProcessing}</div>
            </div>
              <img src={item.imageUrl} alt="Product" /> 
            </div>
            <div className="history-action">
              <button>View Details</button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default HistoryPage;
