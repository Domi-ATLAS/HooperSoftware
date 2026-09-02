/**
 * Normalizes text so player and team filters behave consistently with accents.
 *
 * @param {string} value Text to normalize.
 * @returns {string} Lowercase text without diacritic marks.
 */
function normalizeLineupText(value) {
  return (value || "")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .trim();
}

/**
 * Builds a player object from an option in a player selector.
 *
 * @param {HTMLOptionElement} option Option that represents a player.
 * @returns {{id: string, name: string, team: string, logo: string, position: string, season: string, label: string}} Player data.
 */
function getLineupPlayerFromOption(option) {
  return {
    id: option.value,
    name: (option.dataset.name || option.textContent || "").trim(),
    team: (option.dataset.team || "Sin equipo").trim(),
    logo: (option.dataset.teamLogo || "HS").trim(),
    position: (option.dataset.position || "").trim(),
    season: (option.dataset.season || "Base").trim(),
    label: `${(option.dataset.name || option.textContent || "").trim()} (${(option.dataset.team || "Sin equipo").trim()}) - ${(option.dataset.season || "Base").trim()}`,
  };
}

/**
 * Applies the active player and team filters to one player selector.
 *
 * @param {HTMLSelectElement} select Player selector to update.
 * @param {string} playerQuery Normalized player name query.
 * @param {string} teamQuery Normalized team name query.
 */
function filterLineupSelect(select, playerQuery, teamQuery) {
  Array.from(select.options).forEach((option) => {
    if (!option.value) {
      option.hidden = false;
      return;
    }

    const optionName = normalizeLineupText(option.dataset.name || option.textContent);
    const optionTeam = normalizeLineupText(option.dataset.team);
    const optionSeason = normalizeLineupText(option.dataset.season);
    const matchesPlayer = !playerQuery
      || optionName.includes(playerQuery)
      || optionSeason.includes(playerQuery);
    const matchesTeam = !teamQuery || optionTeam === teamQuery;

    option.hidden = !(matchesPlayer && matchesTeam);
  });
}

/**
 * Updates the court identity using the selected main player's team.
 *
 * @param {HTMLSelectElement} mainSelect Selector that contains the main player.
 * @param {HTMLElement|null} court Court element to decorate.
 * @param {HTMLElement|null} label Court team label.
 * @returns {void}
 */
function updateLineupCourtTheme(mainSelect, court, label) {
  if (!court || !mainSelect) {
    return;
  }

  const selected = mainSelect.selectedOptions[0];
  const player = selected && selected.value ? getLineupPlayerFromOption(selected) : null;
  const logo = player ? player.logo : "HS";
  const team = player ? player.team : "NBA";

  court.style.setProperty("--lineup-logo", `url("/images/${logo}.png")`);
  court.dataset.teamName = team;

  if (label) {
    label.textContent = team;
  }
}

/**
 * Renders autocomplete matches below the main search input.
 *
 * @param {HTMLElement} box Container for suggestions.
 * @param {Array<{id: string, name: string, team: string, logo: string, position: string, season: string, label: string}>} players Matching players.
 * @param {(player: {id: string, name: string, team: string, logo: string, position: string, season: string, label: string}) => void} onPick Selection callback.
 * @returns {void}
 */
function renderLineupAutocomplete(box, players, onPick) {
  box.innerHTML = "";

  players.slice(0, 8).forEach((player) => {
    const item = document.createElement("button");
    item.type = "button";
    item.className = "autocomplete-item";
    item.innerHTML = `<strong>${player.name}</strong><span>${player.team} - ${player.season}</span>`;
    item.addEventListener("click", () => onPick(player));
    box.appendChild(item);
  });
}

/**
 * Moves the active state in the autocomplete list.
 *
 * @param {NodeListOf<Element>} items Suggestion elements.
 * @param {number} index Current active index.
 * @returns {number} New active index.
 */
function activateLineupAutocompleteItem(items, index) {
  if (!items.length) {
    return -1;
  }

  const normalizedIndex = ((index % items.length) + items.length) % items.length;
  items.forEach((item) => item.classList.remove("autocomplete-active"));
  items[normalizedIndex].classList.add("autocomplete-active");
  return normalizedIndex;
}

/**
 * Maps the visible court slot label to its form field name.
 *
 * @param {string} slot Slot label rendered by the server.
 * @returns {string|null} Matching select name.
 */
function getLineupSlotInputName(slot) {
  const slots = {
    Base: "baseId",
    Escolta: "escoltaId",
    Alero: "aleroId",
    "Ala-pivot": "alaPivotId",
    Pivot: "pivotId",
  };

  return slots[slot] || null;
}

/**
 * Finds the most natural court slot for a player's position.
 *
 * @param {string} position Player position.
 * @returns {string|null} Preferred select name.
 */
function getLineupInputNameByPosition(position) {
  const normalized = normalizeLineupText(position);

  if (normalized.includes("base") || normalized === "pg") {
    return "baseId";
  }
  if (normalized.includes("escolta") || normalized === "sg") {
    return "escoltaId";
  }
  if (normalized.includes("alero") && !normalized.includes("ala")) {
    return "aleroId";
  }
  if (normalized.includes("ala") || normalized === "pf") {
    return "alaPivotId";
  }
  if (normalized.includes("pivot") || normalized.includes("center") || normalized === "c") {
    return "pivotId";
  }

  return null;
}

/**
 * Places the main player on the court, preferring his natural position.
 *
 * @param {HTMLFormElement} board Lineup form.
 * @param {HTMLSelectElement} mainSelect Main player selector.
 * @returns {boolean} True when the player was placed.
 */
function placeMainPlayerOnCourt(board, mainSelect) {
  const selected = mainSelect.selectedOptions[0];

  if (!selected || !selected.value) {
    return false;
  }

  const slotSelects = Array.from(board.querySelectorAll(".lineup-slot select"));
  const alreadyPlaced = slotSelects.some((select) => select.value === selected.value);

  if (alreadyPlaced) {
    return false;
  }

  const player = getLineupPlayerFromOption(selected);
  const preferredName = getLineupInputNameByPosition(player.position);
  const preferredSelect = preferredName ? board.querySelector(`select[name="${preferredName}"]`) : null;
  const target = preferredSelect && !preferredSelect.value
    ? preferredSelect
    : slotSelects.find((select) => !select.value);

  if (!target) {
    return false;
  }

  target.value = selected.value;
  target.dispatchEvent(new Event("change", { bubbles: true }));
  return true;
}

/**
 * Applies one suggested player to its slot select.
 *
 * @param {HTMLFormElement} board Lineup form.
 * @param {HTMLElement} trigger Button with suggestion data attributes.
 * @returns {boolean} True when a player was applied.
 */
function applyLineupSuggestion(board, trigger) {
  const inputName = getLineupSlotInputName(trigger.dataset.slot);
  const playerId = trigger.dataset.playerId;

  if (!inputName || !playerId) {
    return false;
  }

  const select = board.querySelector(`select[name="${inputName}"]`);

  if (!select) {
    return false;
  }

  select.value = playerId;
  select.dispatchEvent(new Event("change", { bubbles: true }));
  return true;
}

/**
 * Initializes the lineup board controls when the page is present.
 *
 * @returns {void}
 */
function initLineupBoard() {
  const board = document.querySelector("[data-lineup-board]");
  const page = document.querySelector(".lineup-page");

  if (!board) {
    return;
  }

  const playerSearch = board.querySelector("[data-lineup-search]");
  const autocompleteBox = board.querySelector("#lineup-autocomplete-results");
  const teamFilter = board.querySelector("[data-lineup-team]");
  const playerSelects = board.querySelectorAll("[data-player-select]");
  const mainSelect = board.querySelector("#jugadorBaseId");
  const court = board.querySelector("[data-lineup-court]");
  const courtTeam = board.querySelector("[data-lineup-court-team]");
  const players = Array.from(mainSelect.options)
    .filter((option) => option.value)
    .map(getLineupPlayerFromOption);
  let currentFocus = -1;

  const applyFilters = () => {
    const playerQuery = normalizeLineupText(playerSearch.value);
    const teamQuery = normalizeLineupText(teamFilter.value);

    playerSelects.forEach((select) => {
      filterLineupSelect(select, playerQuery, teamQuery);
    });
  };

  const pickPlayer = (player) => {
    mainSelect.value = player.id;
    playerSearch.value = player.name;
    autocompleteBox.innerHTML = "";
    currentFocus = -1;
    updateLineupCourtTheme(mainSelect, court, courtTeam);
    applyFilters();
  };

  const updateAutocomplete = () => {
    const playerQuery = normalizeLineupText(playerSearch.value);
    const teamQuery = normalizeLineupText(teamFilter.value);

    if (playerQuery.length < 2) {
      autocompleteBox.innerHTML = "";
      currentFocus = -1;
      applyFilters();
      return;
    }

    const matches = players.filter((player) => {
      const matchesName = normalizeLineupText(player.name).includes(playerQuery);
      const matchesSeason = normalizeLineupText(player.season).includes(playerQuery);
      const matchesTeam = !teamQuery || normalizeLineupText(player.team) === teamQuery;
      return (matchesName || matchesSeason) && matchesTeam;
    });

    renderLineupAutocomplete(autocompleteBox, matches, pickPlayer);
    currentFocus = -1;
    applyFilters();
  };

  playerSearch.addEventListener("input", updateAutocomplete);
  playerSearch.addEventListener("keydown", (event) => {
    const items = autocompleteBox.querySelectorAll(".autocomplete-item");

    if (event.key === "ArrowDown") {
      event.preventDefault();
      currentFocus = activateLineupAutocompleteItem(items, currentFocus + 1);
    }

    if (event.key === "ArrowUp") {
      event.preventDefault();
      currentFocus = activateLineupAutocompleteItem(items, currentFocus - 1);
    }

    if (event.key === "Enter" && currentFocus > -1 && items[currentFocus]) {
      event.preventDefault();
      items[currentFocus].click();
    }
  });

  teamFilter.addEventListener("change", applyFilters);
  mainSelect.addEventListener("change", () => {
    updateLineupCourtTheme(mainSelect, court, courtTeam);
  });

  const placeMainButton = board.querySelector("[data-lineup-place-main]");
  if (placeMainButton) {
    placeMainButton.addEventListener("click", () => {
      placeMainPlayerOnCourt(board, mainSelect);
      applyFilters();
    });
  }

  const resetButton = board.querySelector("[data-lineup-reset]");
  if (resetButton) {
    resetButton.addEventListener("click", () => {
      window.location.href = "/simulaciones/tablero";
    });
  }

  page.querySelectorAll("[data-lineup-suggestion]").forEach((button) => {
    button.addEventListener("click", () => {
      if (applyLineupSuggestion(board, button)) {
        board.submit();
      } else {
        applyFilters();
      }
    });
  });

  const fillAllButton = page.querySelector("[data-lineup-fill-all]");
  if (fillAllButton) {
    fillAllButton.addEventListener("click", () => {
      let changed = false;

      page.querySelectorAll("[data-lineup-suggestion]").forEach((button) => {
        changed = applyLineupSuggestion(board, button) || changed;
      });

      if (changed) {
        board.submit();
      }
    });
  }

  document.addEventListener("click", (event) => {
    if (!board.contains(event.target) || event.target !== playerSearch) {
      autocompleteBox.innerHTML = "";
    }
  });

  updateLineupCourtTheme(mainSelect, court, courtTeam);
  applyFilters();
}

document.addEventListener("DOMContentLoaded", initLineupBoard);
