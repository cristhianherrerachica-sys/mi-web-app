// Mock data from database
const DB = {
    equipos: [
        { id: 1, nombre: 'Real Madrid CF', ciudad: 'Madrid', estadio: 'Santiago Bernabéu', anio: 1902 },
        { id: 2, nombre: 'FC Barcelona', ciudad: 'Barcelona', estadio: 'Camp Nou', anio: 1899 },
        { id: 3, nombre: 'Atlético de Madrid', ciudad: 'Madrid', estadio: 'Cívitas Metropolitano', anio: 1903 },
        { id: 4, nombre: 'Real Betis Balompié', ciudad: 'Sevilla', estadio: 'Benito Villamarín', anio: 1907 }
    ],
    jugadores: [
        { id: 1, nombre: 'Vinícius', apellidos: 'Júnior', posicion: 'Delantero', dorsal: 7, equipo_id: 1 },
        { id: 2, nombre: 'Jude', apellidos: 'Bellingham', posicion: 'Centrocampista', dorsal: 5, equipo_id: 1 },
        { id: 3, nombre: 'Lamine', apellidos: 'Yamal', posicion: 'Delantero', dorsal: 27, equipo_id: 2 },
        { id: 4, nombre: 'Pedri', apellidos: 'González', posicion: 'Centrocampista', dorsal: 8, equipo_id: 2 },
        { id: 5, nombre: 'Antoine', apellidos: 'Griezmann', posicion: 'Delantero', dorsal: 7, equipo_id: 3 },
        { id: 6, nombre: 'Isco', apellidos: 'Alarcón', posicion: 'Centrocampista', dorsal: 22, equipo_id: 4 },
        { id: 7, nombre: 'Héctor', apellidos: 'Bellerín', posicion: 'Defensa', dorsal: 2, equipo_id: 4 },
        { id: 8, nombre: 'Pablo', apellidos: 'Fornals', posicion: 'Centrocampista', dorsal: 18, equipo_id: 4 }
    ]
};

// Selectors
const teamsGrid = document.getElementById('teams-grid');
const playersBody = document.getElementById('players-body');
const playerSearch = document.getElementById('playerSearch');

// Helper to get team name by ID
function getTeamName(teamId) {
    const team = DB.equipos.find(t => t.id === teamId);
    return team ? team.nombre : 'Sin equipo';
}

// Helper for position abbreviations and classes
function getPosMeta(posicion) {
    if (posicion.includes('Delantero')) return { short: 'FW', class: 'pos-FW' };
    if (posicion.includes('Centrocampista')) return { short: 'MF', class: 'pos-MF' };
    if (posicion.includes('Defensa')) return { short: 'DF', class: 'pos-DF' };
    if (posicion.includes('Portero')) return { short: 'GK', class: 'pos-GK' };
    return { short: '??', class: '' };
}

// Render Teams
function renderTeams() {
    teamsGrid.innerHTML = DB.equipos.map(team => `
        <div class="card animate-fade">
            <h3>${team.nombre}</h3>
            <div class="card-info">
                <span>📍 ${team.ciudad}</span>
                <span>🏟️ ${team.estadio}</span>
                <span>📅 Est. ${team.anio}</span>
            </div>
        </div>
    `).join('');
}

// Render Players
function renderPlayers(filterText = '') {
    const filtered = DB.jugadores.filter(p => {
        const fullSearch = `${p.nombre} ${p.apellidos} ${p.posicion} ${getTeamName(p.equipo_id)}`.toLowerCase();
        return fullSearch.includes(filterText.toLowerCase());
    });

    playersBody.innerHTML = filtered.map(p => {
        const posMeta = getPosMeta(p.posicion);
        return `
            <tr>
                <td><div class="dorsal-circle">${p.dorsal}</div></td>
                <td><strong>${p.nombre}</strong></td>
                <td>${p.apellidos}</td>
                <td><span class="pos-tag ${posMeta.class}">${posMeta.short}</span> ${p.posicion}</td>
                <td>${getTeamName(p.equipo_id)}</td>
            </tr>
        `;
    }).join('');

    if (filtered.length === 0) {
        playersBody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding: 2rem;">No se encontraron resultados</td></tr>';
    }
}

// Event Listeners
playerSearch.addEventListener('input', (e) => {
    renderPlayers(e.target.value);
});

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    renderTeams();
    renderPlayers();
});
