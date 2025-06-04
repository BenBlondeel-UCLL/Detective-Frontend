document.addEventListener('DOMContentLoaded', async function() {
  const apiService = new ApiService();
  let currentAnalysis = null;
  let originalText = '';

  const {access_token, username} = await chrome.storage.session.get(['access_token', 'username']);
  if (!access_token && !username) {
      document.getElementById('loginContainer').classList.remove('hidden');
      document.getElementById('selectionContainer').classList.add('hidden');
      document.getElementById('headerUsername').classList.add('hidden');
    } else {
      document.getElementById('loginContainer').classList.add('hidden');
      document.getElementById('selectionContainer').classList.remove('hidden');
      document.getElementById('headerUsername').textContent = `Hello, ${username}`;
    }


  setupTabs();

  chrome.storage.local.get(['selectedText'], function(result) {
    if (result.selectedText) {
      analyzeText(result.selectedText);
      chrome.storage.local.remove('selectedText');
    }
  });

  document.getElementById('loginBtn').addEventListener('click', async function() {
      const username = document.getElementById('username').value;
      const password = document.getElementById('password').value;

    try {
      const response = await apiService.postLogin(username, password);
      if (response.access_token) {
        console.log('Login successful:', response);
        document.getElementById('loginContainer').classList.add('hidden');
        document.getElementById('selectionContainer').classList.remove('hidden');

        chrome.storage.session.set({ 'access_token': response.access_token, 'username': response.username }, function() {
          document.getElementById('headerUsername').textContent = `Hello, ${response.username}`;
          document.getElementById('headerUsername').classList.remove('hidden');
        });
      } else {
          alert('something went wrong, please try again');
      }
    } catch (error) {
      alert('Login failed: ' + error.message);
    }
  });

  document.getElementById('analyzeBtn').addEventListener('click', async function() {
    chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
      chrome.scripting.executeScript({
        target: {tabId: tabs[0].id},
        function: getSelectedText,
      }, (results) => {
        if (results && results[0] && results[0].result) {
          analyzeText(results[0].result);
        } else {
          alert('Please select text on the page first');
        }
      });
    });
  });

  function getSelectedText() {
    return window.getSelection().toString();
  }

  document.getElementById('openFullViewBtn').addEventListener('click', async function() {
    const {access_token, username} = await chrome.storage.session.get(['access_token', 'username']);
    const enc_access_token = encodeURIComponent(access_token);
    const enc_username = encodeURIComponent(username);
    chrome.tabs.create({ url: `http://localhost:5234/redirect?access_token=${enc_access_token}&username=${enc_username}` });
  });

  async function analyzeText(text) {
    if (!text || text.trim() === '') {
      alert('Please select text to analyze');
      return;
    }

    originalText = text;

    // Show loading
    document.getElementById('selectionContainer').classList.add('hidden');
    document.getElementById('loadingContainer').classList.remove('hidden');

    try {
      const result = await apiService.postAnalysis(text);
      currentAnalysis = result;

      // Hide loading, show results
      document.getElementById('loadingContainer').classList.add('hidden');
      document.getElementById('resultContainer').classList.remove('hidden');

      // Update the UI with results
      displayResults(text, result);
    } catch (error) {
      document.getElementById('loadingContainer').classList.add('hidden');
      document.getElementById('selectionContainer').classList.remove('hidden');
      alert('Error analyzing text: ' + error.message);
    }
  }

  function displayResults(text, result) {
    // Update counters
    document.getElementById('spellingCount').textContent = result.spellingMistakes.length;
    document.getElementById('grammarCount').textContent = result.grammarMistakes.length;
    document.getElementById('claimsCount').textContent = result.claims.length;
    document.getElementById('aiCount').textContent = result.aiContent ? '1' : '0';

    // Display the text with highlights
    document.getElementById('analyzedText').innerHTML = createHighlightedText(text, result);

    // Populate tabs
    populateSpellingTab(result.spellingMistakes, text);
    populateGrammarTab(result.grammarMistakes);
    populateClaimsTab(result.claims);
    populateAiTab(result.aiContent);
  }

  function createHighlightedText(text, result) {
    let htmlText = text;

    // Replace spelling mistakes
    result.spellingMistakes.forEach(mistake => {
      const mistakeText = text.substring(mistake.index, mistake.index + mistake.length);
      htmlText = htmlText.replace(
        mistakeText,
        `<span class="spelling-mistake">${mistakeText}</span>`
      );
    });

    // Replace grammar mistakes
    result.grammarMistakes.forEach(mistake => {
      htmlText = htmlText.replace(
        mistake.target,
        `<span class="grammar-mistake">${mistake.target}</span>`
      );
    });

    // Replace claims
    result.claims.forEach(claim => {
      let claimClass = '';
      switch(claim.verificationResult) {
        case 'TRUE':
          claimClass = 'claim-true';
          break;
        case 'FALSE':
          claimClass = 'claim-false';
          break;
        case 'UNCERTAIN':
          claimClass = 'claim-uncertain';
          break;
      }

      htmlText = htmlText.replace(
        claim.target,
        `<span class="${claimClass}">${claim.target}</span>`
      );
    });

    return htmlText;
  }

  function populateSpellingTab(mistakes, text) {
    const container = document.getElementById('spellingTab');
    container.innerHTML = '';

    if (mistakes.length === 0) {
      container.innerHTML = '<p>No spelling mistakes found.</p>';
      return;
    }

    mistakes.forEach(mistake => {
      const mistakeText = text.substring(mistake.index, mistake.index + mistake.length);
      const card = document.createElement('div');
      card.className = 'mistake-card';
      card.innerHTML = `
        <p><strong>Mistake:</strong> <span class="spelling-mistake">${mistakeText}</span></p>
        <p><strong>Suggestions:</strong> ${mistake.suggestions.join(', ')}</p>
      `;
      container.appendChild(card);
    });
  }

  function populateGrammarTab(mistakes) {
    const container = document.getElementById('grammarTab');
    container.innerHTML = '';

    if (mistakes.length === 0) {
      container.innerHTML = '<p>No grammar issues found.</p>';
      return;
    }

    mistakes.forEach(mistake => {
      const card = document.createElement('div');
      card.className = 'mistake-card';
      card.innerHTML = `
        <p><strong>Issue:</strong> <span class="grammar-mistake">${mistake.target}</span></p>
        <p><strong>Description:</strong> ${mistake.description}</p>
        <p><strong>Suggestion:</strong> ${mistake.suggestion || 'No suggestion available'}</p>
      `;
      container.appendChild(card);
    });
  }

  function populateClaimsTab(claims) {
    const container = document.getElementById('claimsTab');
    container.innerHTML = '';

    if (claims.length === 0) {
      container.innerHTML = '<p>No claims detected for verification.</p>';
      return;
    }

    claims.forEach(claim => {
      let statusClass = '';
      let statusText = '';

      switch(claim.verificationResult) {
        case 'TRUE':
          statusClass = 'claim-true';
          statusText = 'True';
          break;
        case 'FALSE':
          statusClass = 'claim-false';
          statusText = 'False';
          break;
        case 'UNCERTAIN':
          statusClass = 'claim-uncertain';
          statusText = 'Uncertain';
          break;
      }

      const card = document.createElement('div');
      card.className = 'claim-card';
      card.innerHTML = `
        <p><strong>Claim:</strong> <span class="${statusClass}">${claim.target}</span></p>
        <p><strong>Status:</strong> ${statusText}</p>
        <p><strong>Explanation:</strong> ${claim.explanation || 'No explanation available'}</p>
      `;
      container.appendChild(card);
    });
  }

  function populateAiTab(aiContent) {
    const container = document.getElementById('aiTab');
    container.innerHTML = '';

    const message = aiContent
      ? "This content is likely AI-generated."
      : "This content is likely human-written.";

    container.innerHTML = `<p>${message}</p>`;
  }

  function setupTabs() {
    const tabs = document.querySelectorAll('.tab');
    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        // Remove active class from all tabs
        tabs.forEach(t => t.classList.remove('active'));

        // Add active class to clicked tab
        tab.classList.add('active');

        // Hide all tab panels
        const panels = document.querySelectorAll('.tab-panel');
        panels.forEach(panel => panel.classList.remove('active'));

        // Show the corresponding panel
        const tabName = tab.getAttribute('data-tab');
        document.getElementById(`${tabName}Tab`).classList.add('active');
      });
    });
  }
});