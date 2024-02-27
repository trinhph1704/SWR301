import React, { useEffect, useState } from 'react';
import './AuthenticationPage.css';
import { FaEye, FaEyeSlash } from 'react-icons/fa';
import api from '../../components/utils/requestAPI';
import useAuth from '../../hooks/useAuth';
import { useNavigate } from 'react-router-dom';

const SignUpPage = () => {

  const { setAuth } = useAuth();

  const [user, setUser] = useState();
  const [username, setUsername] = useState();
  const [email, setEmail] = useState();
  const [password, setPassword] = useState();
  const [confirm, setConfirm] = useState();


  const navigate = useNavigate();

  const [showPassword, setShowPassword] = useState(false);

  const handleSubmit = async (event) => {
    event.preventDefault();
    const url = '/api/User/registration';
    const data = {
      userName: username,
      password: password,
      email: email
    };
    try {
      if (password === confirm) {
        const response = await api.post(url, data);
        setUser(response.data)
        console.log(response.data)
      }
    } catch (error) {
      console.error(error);
      // Xử lý lỗi ở đây
    }
  }

  useEffect(() => {
    async function fetchUserData() {
      try {
        const url = '/api/User/login';
        const data = {
          userName: username,
          password: password,
        }
        const response = await api.post(url, data);
        var authen = response.data;
        setAuth({ user, authen });
        console.log(authen);
        navigate('/update-info');
      } catch (error) {
        console.error(error);
      }
    }
    fetchUserData();
  }, [user])

  const togglePasswordVisibility = () => {
    setShowPassword(!showPassword);
  };

  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  const toggleConfirmPasswordVisibility = () => {
    setShowConfirmPassword(!showConfirmPassword);
  };
  return (
    <div className="authentication-section">
      <a href='/home' className='homepage-link'> Về trang chủ</a>
      <div className="authentication-container">
        <h2>Đăng ký</h2>
        <form>
          <div className="authentication-input-container">
            
            <input type="text" id="name" name="name" className='authentication-input' required onChange={(event) => setUsername(event.target.value)} />
            <label htmlFor="username" className='authentication-input-container-label' >Tên đăng nhập</label>
          </div>
          <div className="authentication-input-container">
            
            <input type="email" id="email" name="email" className='authentication-input' required onChange={(event) => setEmail(event.target.value)} />
            <label htmlFor="email" className='authentication-input-container-label'>Email</label>
          </div>
          <div className="authentication-input-container">
            
          <input type={showPassword ? "text" : "password"} id="password" name="password" className='authentication-input' required onChange={(event) => setPassword(event.target.value)} />
                        <label htmlFor="password" className='authentication-input-container-label'>Mật khẩu</label>
                        <button type="button" className="log-in-password-toggle-button" onClick={togglePasswordVisibility}>
                            {showPassword ? <FaEyeSlash /> : <FaEye />}
                        </button>
          </div>
          <div className="authentication-input-container">
           
            <input type={showConfirmPassword ? "text" : "password"} id="password-confirm" name="password-confirm" className='authentication-input' required onChange={(event) => setConfirm(event.target.value)} />
            <label htmlFor="password-confirm" className='authentication-input-container-label'>Xác nhận mật khẩu</label>
            <button type="button" className="confirm-password-toggle-button" onClick={toggleConfirmPasswordVisibility}>
              {showConfirmPassword ? <FaEyeSlash /> : <FaEye />}
            </button>
          </div>
          <button type="submit" className='authentication-button' onClick={handleSubmit}>Đăng ký</button>
        </form>
        <p>Bạn đã có tài khoản? <a href='/log-in'>Đăng nhập</a></p>
      </div>
    </div>
  );
}

export default SignUpPage;
