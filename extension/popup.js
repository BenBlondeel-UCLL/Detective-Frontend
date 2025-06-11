document.addEventListener('DOMContentLoaded', async function() {
  const apiService = new ApiService();
  let currentAnalysis = null;
  let originalText = '';

  document.addEventListener('keydown', function(e) {
      if (e.key === 'Enter' && !document.getElementById('loginContainer').classList.contains('hidden')) {
        document.getElementById('loginBtn').click();
      }
    });

  document.addEventListener('keydown', function(e) {
     if (e.key === 'Enter' && !document.getElementById('selectionContainer').classList.contains('hidden')) {
        document.getElementById('analyzeBtn').click();
     }
  });

  const {access_token, username} = await chrome.storage.session.get(['access_token', 'username']);
  if (!access_token && !username) {
      document.getElementById('loginContainer').classList.remove('hidden');
      document.getElementById('selectionContainer').classList.add('hidden');
      document.getElementById('headerUsername').classList.add('hidden');
    } else {
      document.getElementById('loginContainer').classList.add('hidden');
      document.getElementById('selectionContainer').classList.remove('hidden');
      document.getElementById('headerUsername').textContent = `Hallo, ${username}`;
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
        document.getElementById('loginContainer').classList.add('hidden');
        document.getElementById('selectionContainer').classList.remove('hidden');

        chrome.storage.session.set({ 'access_token': response.access_token, 'username': response.username }, function() {
          document.getElementById('headerUsername').textContent = `Hallo, ${response.username}`;
          document.getElementById('headerUsername').classList.remove('hidden');
        });
      } else {
          alert('Er is iets misgegaan, probeer opnieuw');
      }
    } catch (error) {
      alert('Aanmelden mislukt: ' + error.message);
    }
  });

  document.getElementById('analyzeBtn').addEventListener('click', async function() {
    chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
      chrome.scripting.executeScript({
        target: {tabId: tabs[0].id},
        function: getSelectedText,
      }, (results) => {
        console.log(results);
        if (results && results[0] && results[0].result) {
          analyzeText(results[0].result);
        } else {
          alert('Selecteer eerst een tekst op de pagina');
        }
      });
    });
  });

  function getSelectedText() {
    return window.getSelection().toString();
  }

  async function analyzeText(text) {
    if (!text || text.trim() === '') {
      alert('Selecteer een tekst om te analyseren');
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
      console.log(result);
      console.log(result.extraContent);
      console.log(text);
      displayResults(text, result);
    } catch (error) {
      document.getElementById('loadingContainer').classList.add('hidden');
      document.getElementById('selectionContainer').classList.remove('hidden');
      alert('Een error tijdens het analyseren van de tekst: ' + error.message);
    }
  }

  document.getElementById('openFullViewBtn').addEventListener('click', async function() {
    const {access_token, username} = await chrome.storage.session.get(['access_token', 'username']);
    const enc_access_token = btoa(access_token);
    const enc_username = btoa(username);
    chrome.tabs.create({ url: `http://localhost:5234/redirect?access_token=${enc_access_token}&username=${enc_username}` });
  });

  function displayResults(text, result) {
    // Update counters
    document.getElementById('spellingCount').textContent = result.spellingMistakes.length;
    document.getElementById('grammarCount').textContent = result.grammarMistakes.length;
    document.getElementById('claimsCount').textContent = result.claims.length;
    // document.getElementById('extra').textContent = result.aiContent;

    // Display the text with highlights
    document.getElementById('analyzedText').innerHTML = createHighlightedText(text, result);

    // Populate tabs
    populateSpellingTab(result.spellingMistakes, text);
    populateGrammarTab(result.grammarMistakes);
    populateClaimsTab(result.claims);
    populateExtraTab(result);
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
      container.innerHTML = '<p>Geen spelling fouten gevonden.</p>';
      return;
    }

    mistakes.forEach(mistake => {
      const mistakeText = text.substring(mistake.index, mistake.index + mistake.length);
      const card = document.createElement('div');
      card.className = 'mistake-card';
      card.innerHTML = `
        <p><strong>Fout:</strong> <span class="spelling-mistake">${mistakeText}</span></p>
        <p>${mistake.message}</p>
        `;
      container.appendChild(card);
    });
  }

  function populateGrammarTab(mistakes) {
    const container = document.getElementById('grammarTab');
    container.innerHTML = '';

    if (mistakes.length === 0) {
      container.innerHTML = '<p>Geen gramatica fouten gevonden.</p>';
      return;
    }

    mistakes.forEach(mistake => {
      const card = document.createElement('div');
      card.className = 'mistake-card';
      card.innerHTML = `
        <p><strong>Fout:</strong> <span class="grammar-mistake">${mistake.target}</span></p>
        <p><strong>Suggestie:</strong> ${mistake.message}</p>
      `;
      container.appendChild(card);
    });
  }

  function populateClaimsTab(claims) {
    const container = document.getElementById('claimsTab');
    container.innerHTML = '';

    if (claims.length === 0) {
      container.innerHTML = '<p>Geen stellingen gedetecteerd voor verificatie.</p>';
      return;
    }

    claims.forEach(claim => {
      const card = document.createElement('div');
      card.className = 'claim-card';
      card.innerHTML = `
        <p><strong>Stelling:</strong> <span>${claim.target}</span></p>
        <p><strong>Uitleg:</strong> ${claim.explanation}</p>
        <div><strong>Bronnen:</strong>
          <ul style="margin: 8px 0 0 16px; padding: 0;">
        ${
          Array.isArray(claim.url)
            ? claim.url.map(url => `
            <li style="margin-bottom:4px;">
              <a href="${url}" target="_blank" style="color:#1976d2;text-decoration:underline;word-break:break-all;">${url}</a>
            </li>
          `).join('')
            : claim.url
          ? `<li><a href="${claim.url}" target="_blank" style="color:#1976d2;text-decoration:underline;word-break:break-all;">${claim.url}</a></li>`
          : '<li>Geen bronnen gegeven.</li>'
        }
          </ul>
        </div>
      `;
      container.appendChild(card);
    });
  }

  function populateExtraTab(result) {
    const container = document.getElementById('extraTab');
    container.innerHTML = '';

    // AI Content
    const aiMessage = result.aiContent
      ? `<span>Deze tekst is waarschijnlijk AI gegenereerd.</span>`
      : `<span>Deze tekst is waarschijnlijk door een mens geschreven.</span>`;

    // Arousal Score
    const arousalScore = typeof result.arousal_score !== 'undefined' ? result.arousal_score : 'N/A';

    // News Site Info
    const newsSite = result.newsSite || {};
    const newsSiteHtml = newsSite.name ? `
      <div style="margin-top:16px;">
        <div style="font-weight:bold;">Waarschijnlijke Bron:</div>
        <div style="margin-left:16px;">
          <div><strong>Naam:</strong> ${newsSite.name}</div>
          <div><strong>URL:</strong> <a href="https://${newsSite.url}" target="_blank" style="color:#1976d2;text-decoration:underline;">${newsSite.url}</a></div>
          <div><strong>Partijdigheid:</strong> ${getTranslatedBias(newsSite.bias)}</div>
          <div><strong>Feitelijkheid:</strong> ${getTranslatedFactual(newsSite.factual)}</div>
          <div><strong>Betrouwbaarheid:</strong> ${getTranslatedCredibility(newsSite.credibility)}</div>
        </div>
      </div>
    ` : '';

    container.innerHTML = `
      <div style="margin-bottom:16px;">
        <div style="font-weight:bold;">AI Check:</div>
        <div style="margin-left:16px; margin-bottom:8px;">${aiMessage}</div>
      </div>
      <div style="margin-bottom:16px;">
        <div style="font-weight:bold;">Sensatiewaarde: ${arousalScore}</div>
        <div style="margin-left:16px; color:#666;">
          Een waare van 0 tot 1. Deze waarde duidt op de opwekking van emoties in the tekst. Een hogere waarde suggereert dat de tekst meer emoties opwekt.
        </div>
      </div>
      ${newsSiteHtml}
      <div style="margin-top:16px; color:#666; font-style:italic;">
        Deze informatie komt van:
        <a href="https://mediabiasfactcheck.com/mbfcs-data-api/" target="_blank" style="color:#1976d2;text-decoration:underline;">Media Bias/Fact Check API</a>
      </div>
    `;
  }

  const biasTranslations = {
    'extreme-right': 'extreem-rechts',
    'right': 'rechts',
    'right-center': 'centrum-rechts',
    'center': 'centrum',
    'left-center': 'centrum-links',
    'left': 'links',
    'extreme-left': 'extreem-links',
    'conspiracy': 'complot',
    'satire': 'satire',
    'pro-science': 'pro-wetenschap',
  };

const factualTranslations = {
  'very high': 'zeer hoog',
  'high': 'hoog',
  'mostly_factual': 'meestal feitelijk',
  'mostly': 'meestal feitelijk',
  'mixed': 'gemengd',
  'low': 'laag',
  'VeryLow': 'zeer laag',
};

const credibilityTranslations ={
  'high credibility': 'hoge betrouwbaarheid',
  'medium credibility': 'gemiddelde betrouwbaarheid',
  'low credibility': 'lage betrouwbaarheid',
};

function getTranslatedBias(bias) {
  return biasTranslations[bias] || bias;
}

function getTranslatedFactual(bias) {
  return factualTranslations[bias] || bias;
}

function getTranslatedCredibility(bias) {
  return credibilityTranslations[bias] || bias;
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