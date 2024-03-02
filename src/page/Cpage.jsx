// MyCollection.js
import React from 'react';
import Na from "./Napage";



const Cpage = () => {
  // Giả sử bạn có một danh sách các bức tranh đã lưu
  const savedPaintings = [
    { id: 1, title: 'Bức tranh 1', artist: 'Nghệ sĩ 1' },
    { id: 2, title: 'Bức tranh 2', artist: 'Nghệ sĩ 2' },
    // Thêm các bức tranh khác nếu cần
  ];

  return (
    

    
    <div>
        
        <Na className="Navuser" />
      <h2>My Collection</h2>
      <ul>
        {savedPaintings.map((painting) => (
          <li key={painting.id}>
            <strong>{painting.title}</strong> by {painting.artist}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Cpage;
