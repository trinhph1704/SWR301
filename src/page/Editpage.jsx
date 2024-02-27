import React, { useState } from 'react';
import "./Edit.css";
import th from "/th.jpg";
import useAuth from "../hooks/useAuth";

const Editpage = () => {
  const [formData, setFormData] = useState({
    fullName: '',
    primaryLocation: '',
    profession: '',
    otherPositions: '',
    about: '',
  });

  const [avatar, setAvatar] = useState('th.jpg');

  const handleSave = () => {
    // Handle saving profile information, can send to the server here
    console.log('Saving profile:', formData);
  };

  const handleChange = (field, value) => {
    setFormData({
      ...formData,
      [field]: value,
    });
  };

  const handleAvatarChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => {
        setAvatar(reader.result);
      };
      reader.readAsDataURL(file);
    }
  };

  return (
    <div className="edit-page">
      <h1>Edit Profile</h1>

      <div className="form-group">
      <label htmlFor="avatar" className="input-label1">Choose Avatar:</label>
        <input
          type="file"
          id="avatar"
          accept="image/*"
          onChange={handleAvatarChange}
        />
        
        {avatar && <img src={avatar} alt="Avatar" className="avatar-preview" />}
      </div>

      <div className="form-group">
        <input
          type="text"
          id="fullName"
          className="input-field"
          value={formData.fullName}
          onChange={(e) => handleChange('fullName', e.target.value)}
          required
        />
        <label htmlFor="fullName" className='input-label'>Full Name</label>
      </div>

      <div className="form-group">
        <input
          type="text"
          id="primaryLocation"
          className="input-field"
          value={formData.primaryLocation}
          onChange={(e) => handleChange('primaryLocation', e.target.value)}
          required
        />
        <label htmlFor="primaryLocation" className='input-label'>Primary Location:</label>
      </div>

      <div className="form-group">
        <input
          type="text"
          id="profession"
          className="input-field"
          value={formData.profession}
          onChange={(e) => handleChange('profession', e.target.value)}
          required
        />
        <label htmlFor="profession" className='input-label'>Profession:</label>
      </div>

      <div className="form-group">
        <input
          type="text"
          id="otherPositions"
          className="input-field"
          value={formData.otherPositions}
          onChange={(e) => handleChange('otherPositions', e.target.value)}
          required
        />
        <label htmlFor="otherPositions" className='input-label'>Other Relevant Positions:</label>
      </div>

      <div className="form-group">
        <textarea
          id="about"
          className="input-field"
          value={formData.about}
          onChange={(e) => handleChange('about', e.target.value)}
          required
        />
        <label htmlFor="about" className='input-label'>About:</label>
      </div>

      <button className="save-button" onClick={handleSave}>Save</button>
    </div>
  );
};

export default Editpage;
