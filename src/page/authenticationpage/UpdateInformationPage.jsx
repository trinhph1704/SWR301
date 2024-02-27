import React, { useState } from 'react';
import './AuthenticationPage.css';
import api from '../../components/utils/requestAPI';
import useAuth from '../../hooks/useAuth';
import { useNavigate } from 'react-router-dom';


const UpdateInformationPage = () => {
    const { auth } = useAuth();
    const [fullname, setFullname] = useState();
    const [sex, setSex] = useState();
    const [birthday, setBirthday] = useState('');
    const [address, setAddress] = useState();
    const [phonenumber, setPhonenumber] = useState();

    const navigate = useNavigate();
    const validateDateOfBirth = (event) => {
        const selectedDate = new Date(event.target.value);
        const today = new Date();
        if (selectedDate >= today) {
            alert("Please select a valid date of birth.");
            event.target.value = ""; // Clear the input field
        }
    }

    const handleSubmit = async (event) => {
        event.preventDefault();
        const url = '/api/User/update';
        const data = {
            userID: auth.user.userId,
            fullName: fullname,
            address: address,
            phone: phonenumber,
            gender: sex,
            dateOfBird: birthday,
        }
        console.log(auth.user.userId);
        console.log(sex);
        const response = await api.put(url, data);
        if (response.data != null)
            navigate('/user-page');
        else
            alert('Kiểm tra lại');
    }

    return (
        <div className='authentication-section'>
            <a href='/sign-up' className='homepage-link'> Về trang đăng kí</a>
            <div className="authentication-container">
                <h2>Điền thông tin</h2>
                <form onSubmit={handleSubmit}>
                    <div className="authentication-input-container">
                        <label htmlFor="name" className='authentication-input-container-label'>Họ và Tên</label>
                        <input type="text" id="name" name="name" className='authentication-input' required
                            onChange={(event) => setFullname(event.target.value)} />
                    </div>
                    <div className="authentication-check-container">
                        <div className="authentication-check-sex">
                            <label htmlFor="sex" className='authentication-input-container-label'>Giới tính</label>
                            <input type="radio" name="sex" value={true} className='authentication-check-sex-button'
                                onChange={(event) => setSex(event.target.value)} />
                            <span className='button-title'>
                                Nam
                            </span>
                            <input type="radio" name="sex" value={false} className='authentication-check-sex-button'
                                onChange={(event) => setSex(event.target.value)} />
                            <span className='button-title'>
                                Nữ
                            </span>
                        </div>
                        <div className="authentication-check-dob">
                            <label htmlFor="dob" className='authentication-input-container-label'>Ngày sinh</label>
                            <input type="date" name="dob" className='authentication-date' value={birthday}
                                onChange={(event) => setBirthday(event.target.value)} onBlur={validateDateOfBirth} required />
                        </div>
                    </div>
                    <div className="authentication-input-container">
                        <label htmlFor="address" className='authentication-input-container-label'>Địa chỉ</label>
                        <input type="text" id="address" name="address" className='authentication-input' required
                            onChange={(event) => setAddress(event.target.value)} />
                    </div>
                    <div className="authentication-input-container">
                        <label htmlFor="phone-number" className='authentication-input-container-label'>Số điện thoại</label>
                        <input type="number" id="phone-number" name="phone-number" className='authentication-input' required
                            onChange={(event) => setPhonenumber(event.target.value)} />
                    </div>
                    <button type="submit" className='authentication-button'>Xác nhận</button>
                </form>
            </div>
        </div>
    );
}

export default UpdateInformationPage;
