// api-service.js
class ApiService {
  constructor() {
    this.baseUrl = 'http://localhost:8000';
  }

  async postAnalysis(text) {
    try {
      const response = await fetch(`${this.baseUrl}/analyse`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
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
}

const apiService = new ApiService();