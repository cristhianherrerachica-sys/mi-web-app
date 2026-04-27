// Selectors
const playerSearch = document.getElementById('playerSearch');
const playersTableBody = document.getElementById('players-body');
const playerRows = playersTableBody.getElementsByTagName('tr');

// Search Filter Logic
function filterPlayers() {
    const filter = playerSearch.value.toLowerCase();
    
    Array.from(playerRows).forEach(row => {
        // Use textContent of the row to match the search query
        const text = row.textContent.toLowerCase();
        if (text.includes(filter)) {
            row.style.display = "";
            row.classList.add('animate-fade');
        } else {
            row.style.display = "none";
        }
    });
}

// Event Listeners
if (playerSearch) {
    playerSearch.addEventListener('input', filterPlayers);
}

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    console.log('Football Central PHP Loaded');
});
