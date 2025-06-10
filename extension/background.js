// background.js
chrome.runtime.onInstalled.addListener(() => {
  chrome.contextMenus.create({
    id: "analyzeText",
    title: "Analyze with Critify",
    contexts: ["selection"]
  });
});

chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === "analyzeText") {
    chrome.storage.local.set({ 'selectedText': info.selectionText }, () => {
      chrome.action.openPopup();
    });
  }
});