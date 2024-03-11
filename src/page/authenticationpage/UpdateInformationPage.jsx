import React, { useState } from 'react';
import './AuthenticationPage.css';
import api from '../../components/utils/requestAPI';
import useAuth from '../../hooks/useAuth';
import { useNavigate } from 'react-router-dom';

const UpdateInformationPage = () => {
    const { auth } = useAuth();
    const [fullname, setFullname] = useState('');
    const [gender, setGender] = useState('');
    const [phone, setPhone] = useState('');
    const [money, setMoney] = useState(0);
    const [imageFile, setImageFile] = useState(null); // Store the file object
    const [imageString, setImageString] = useState(''); // Store the base64 string representation of the image
    const navigate = useNavigate();

    const handleImageChange = (event) => {
        const file = event.target.files[0]; // Get the file from the onChange event

        // Create a FileReader object
        const reader = new FileReader();

        // Read the file as a data URL string
        reader.readAsDataURL(file);

        // Called when the file reading process is completed
        reader.onload = () => {
            const base64String = reader.result.split(',')[1]; // Get the base64 string representation
            setImageFile(file); // Update the imageFile state with the new file
            setImageString(base64String); // Update the imageString state with the base64 string
        };
    };

    const handleSubmit = async (event) => {
        event.preventDefault();
        
        const data = {
            imgURL: "string", // Base64 string representation of the image
            fullName: fullname,
            gender: gender,
            phone: phone,
            money: money,
            dateOfBirth: new Date().toISOString()
        };

        try {
            const response = await api.post(`https://localhost:7227/api/User/update?id=${auth.user.userId}`, data);
            if (response.data != null)
                navigate('/log-in');
            else
                alert('Failed to update user information. Please try again.');
        } catch (error) {
            console.error('Error:', error);
            // Handle errors here
        }
    };

    return (
        <div className='authentication-section'>
            <div className="authentication-container">
                <h2>Update User Information</h2>
                <form onSubmit={handleSubmit}>
                    <div className="authentication-input-container">
                        <label htmlFor="fullname" className='authentication-input-container-label'>Full Name</label>
                        <input type="text" id="fullname" name="fullname" className='authentication-input' required
                            value={fullname}
                            onChange={(event) => setFullname(event.target.value)} />
                    </div>
                    <div className="authentication-input-container">
<label htmlFor="gender" className='authentication-input-container-label'>Gender</label>
                        <input type="text" id="gender" name="gender" className='authentication-input' required
                            value={gender}
                            onChange={(event) => setGender(event.target.value)} />
                    </div>
                    <div className="authentication-input-container">
                        <label htmlFor="phone" className='authentication-input-container-label'>Phone</label>
                        <input type="text" id="phone" name="phone" className='authentication-input' required
                            value={phone}
                            onChange={(event) => setPhone(event.target.value)} />
                    </div>
                    <div className="authentication-input-container">
                        <label htmlFor="money" className='authentication-input-container-label'>Money</label>
                        <input type="number" id="money" name="money" className='authentication-input' required
                            value={money}
                            onChange={(event) => setMoney(event.target.value)} />
                    </div>
                    <div className="authentication-input-container">
                        <label htmlFor="image" className='authentication-input-container-label'>Image</label>
                        <input type="file" id="image" name="image" className='authentication-input' required
                            onChange={handleImageChange} />
                    </div>
                    <button type="submit" className='authentication-button'>Update</button>
                </form>
            </div>
        </div>
    );
}

export default UpdateInformationPage;