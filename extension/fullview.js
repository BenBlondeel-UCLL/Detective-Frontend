document.addEventListener('DOMContentLoaded', function() {
  // Set up tab switching
  setupTabs();

  // Load the stored analysis data
  chrome.storage.local.get(['fullViewText', 'fullViewAnalysis'], function(result) {
    if (result.fullViewText && result.fullViewAnalysis) {
      displayResults(result.fullViewText, result.fullViewAnalysis);
    } else {
      document.body.innerHTML = '<div class="error">No analysis data found.</div>';
    }
  });

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

  // Copy the same functions from popup.js
  function createHighlightedText(text, result) {
    // Same implementation as popup.js
  }

  function populateSpellingTab(mistakes, text) {
    // Same implementation as popup.js
  }

  function populateGrammarTab(mistakes) {
    // Same implementation as popup.js
  }

  function populateClaimsTab(claims) {
    // Same implementation as popup.js
  }

  function populateAiTab(aiContent) {
    // Same implementation as popup.js
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