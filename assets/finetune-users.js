const count = document.querySelector('[data-finetune-users]');

// Read the scheduled update directly so data changes need no Pages rebuild.
async function refreshCount() {
  try {
    const response = await fetch('https://raw.githubusercontent.com/jaredando/portfolio/main/assets/finetune-users.json', {
      signal: AbortSignal.timeout(5000),
    });
    if (!response.ok) return;
    const data = await response.json();
    if (typeof data.count === 'string' && /^[0-9][0-9,]*\+?$/.test(data.count)) {
      count.textContent = data.count;
    }
  } catch {
    // The published page already contains a verified count.
  }
}

if (count) refreshCount();
