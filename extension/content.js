// content.js
// This can be expanded to add in-page functionality if needed
console.log("Critify extension loaded");
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message && message.type === "FROM_EXTENSION") {
    window.postMessage(message, "*");
  }
});