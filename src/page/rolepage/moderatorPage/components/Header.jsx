// src/components/Header.js

import "./Header.css";
import { Link } from "react-router-dom";

export default function Header(){
  return (
    <div className="header">
      <div className="top-section">
        ~MODERATOR  PAGE~
      </div>
      <div className="bottom-section">
        <div className="menu-item"><Link to ="/content">CONTENT</Link> </div>
        <div className="menu-item"><Link to ="/report">VIEW HISTORY</Link></div>
      </div>
      
    </div>
    
  );
}
// className="menu-item"