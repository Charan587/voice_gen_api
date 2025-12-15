let currentRequestId = null;

function generateVoice() {
  const text = document.getElementById("textInput").value;
  if (!text.trim()) {
    alert("Please enter text");
    return;
  }

  document.getElementById("status").innerText = "⏳ Creating voice request...";
  document.getElementById("audioContainer").innerHTML = "";

  fetch("/generate_voice", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ text })
  })
    .then(res => res.json())
    .then(data => {
      currentRequestId = data.id;
      document.getElementById("status").innerText = "🔄 Processing...";
      pollStatus();
    })
    .catch(err => {
      console.error(err);
      document.getElementById("status").innerText = "❌ Error creating request";
    });
}

function pollStatus() {
  if (!currentRequestId) return;

  fetch(`/voice_requests/${currentRequestId}`)
    .then(res => res.json())
    .then(data => {
      if (data.status === "completed") {
        document.getElementById("status").innerText = "✅ Done";

        document.getElementById("audioContainer").innerHTML = `
          <audio controls src="${data.audio_url}"></audio>
        `;

        addToHistory(data);
      } 
      else if (data.status === "failed") {
        document.getElementById("status").innerText = "❌ Failed";
      } 
      else {
        setTimeout(pollStatus, 2000);
      }
    });
}

function addToHistory(data) {
  const li = document.createElement("li");
  li.innerHTML = `
    ${data.text}
    <br />
    <audio controls src="${data.audio_url}"></audio>
  `;
  document.getElementById("historyList").prepend(li);
}
