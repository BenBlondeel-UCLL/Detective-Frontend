// api-service.js
class ApiService {
  constructor() {
    this.baseUrl = 'http://localhost:8000';
  }

  async postAnalysis(text) {

    const token = await chrome.storage.session.get('access_token');

    console.log('Token:', token.access_token);

    try {
      const response = await fetch(`${this.baseUrl}/analyse`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token.access_token}`
          },
        body: JSON.stringify({ text })
      });

      if (!response.ok) {
        throw new Error(`Error: ${response.status}`);
      }

      return await response.json();
    } catch (error) {
      console.error('Error analyzing text:', error);
      throw error;
    }
  }

  async postLogin(username, password) {
    const formData = new FormData();
    formData.append('username', username);
    formData.append('password', password);
    try{
      const response = await fetch(`${this.baseUrl}/auth/login`, {
          method: 'POST',
          body: formData
      });

      if (!response.ok) {
        throw new Error(`Login failed: ${response.status}`);
      }

      return await response.json();
    } catch (error) {
      console.error('Error during login:', error);
      throw error;
    }
  }
}

const apiService = new ApiService();