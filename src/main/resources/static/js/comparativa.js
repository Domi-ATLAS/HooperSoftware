/**
 * Normalizes text for comparison controls.
 *
 * @param {string} value Text to normalize.
 * @returns {string} Normalized lowercase text.
 */
function normalizeComparisonText(value) {
  return (value || "")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .trim();
}

/**
 * Reads a numeric CSS custom property from a bar element.
 *
 * @param {HTMLElement|null} element Bar element.
 * @returns {number} Numeric value between 0 and 100.
 */
function readComparisonBarValue(element) {
  if (!element) {
    return 0;
  }

  const value = Number(element.style.getPropertyValue("--value").replace(",", "."));
  return Math.max(0, Math.min(100, Number.isFinite(value) ? value : 0));
}

/**
 * Checks whether a select option matches the active player search.
 *
 * @param {HTMLOptionElement} option Option to evaluate.
 * @param {string} query Search text.
 * @returns {boolean} True when the option should remain available.
 */
function matchesPlayerSearch(option, query) {
  return !query || normalizeComparisonText(option.textContent).includes(query);
}

/**
 * Returns the player select controlled by a search input.
 *
 * @param {HTMLInputElement} input Search input.
 * @returns {HTMLSelectElement|null} Controlled select.
 */
function getTradeSelectForSearch(input) {
  const form = input.closest("[data-trade-form]");

  if (!form) {
    return null;
  }

  return input.dataset.playerSearch === "sale"
    ? form.querySelector("[data-trade-sale]")
    : form.querySelector("[data-trade-arrive]");
}

/**
 * Renders matching options for a player select below its search input.
 *
 * @param {HTMLInputElement} input Search input.
 * @returns {void}
 */
function renderPlayerSearchSuggestions(input) {
  const select = getTradeSelectForSearch(input);
  const list = input.parentElement?.querySelector("[data-player-suggestions='" + input.dataset.playerSearch + "']");

  if (!select || !list) {
    return;
  }

  const query = normalizeComparisonText(input.value);
  list.innerHTML = "";

  if (!query) {
    list.hidden = true;
    return;
  }

  const matches = Array.from(select.options)
    .filter((option) => !option.hidden && matchesPlayerSearch(option, query))
    .slice(0, 8);

  if (!matches.length) {
    const empty = document.createElement("div");
    empty.className = "player-suggestion-empty";
    empty.textContent = "Sin coincidencias";
    list.appendChild(empty);
    list.hidden = false;
    return;
  }

  matches.forEach((option) => {
    const button = document.createElement("button");

    button.type = "button";
    button.className = "player-suggestion";
    button.textContent = option.textContent.trim().replace(/\s+/g, " ");
    button.addEventListener("click", () => {
      select.value = option.value;
      option.selected = true;
      input.value = button.textContent;
      select.dispatchEvent(new Event("change", { bubbles: true }));
      list.hidden = true;
    });

    list.appendChild(button);
  });

  list.hidden = false;
}

/**
 * Prepares autocomplete behavior for trade player selectors.
 *
 * @returns {void}
 */
function setupPlayerSearchInputs() {
  document.querySelectorAll("[data-player-search]").forEach((input) => {
    if (input.dataset.autocompleteReady === "true") {
      return;
    }

    const list = document.createElement("div");
    list.className = "player-suggestions";
    list.dataset.playerSuggestions = input.dataset.playerSearch;
    list.hidden = true;
    input.insertAdjacentElement("afterend", list);
    input.dataset.autocompleteReady = "true";

    input.addEventListener("input", () => {
      const select = getTradeSelectForSearch(input);
      if (select) {
        select.selectedIndex = -1;
      }
      updateTradePlayers();
      renderPlayerSearchSuggestions(input);
    });
    input.addEventListener("focus", () => renderPlayerSearchSuggestions(input));
  });
}

/**
 * Filters roster players by the selected season and updates the selected count.
 *
 * @returns {void}
 */
function updateRosterPlayers() {
  const form = document.querySelector("[data-roster-form]");
  if (!form) {
    return;
  }

  const season = form.querySelector("[data-roster-season]")?.value || "";
  const select = form.querySelector("[data-roster-player-select]");
  const count = form.querySelector("[data-roster-count]");
  const search = normalizeComparisonText(form.querySelector("[data-roster-player-search]")?.value || "");

  if (!select) {
    return;
  }

  Array.from(select.options).forEach((option) => {
    const matchesSeason = !season || option.dataset.season === season;
    const matchesSearch = matchesPlayerSearch(option, search);
    option.hidden = !matchesSeason || !matchesSearch;
    if (!matchesSeason) {
      option.selected = false;
    }
  });

  const selected = Array.from(select.selectedOptions);
  if (selected.length > 12) {
    selected.slice(12).forEach((option) => {
      option.selected = false;
    });
  }

  const total = select.selectedOptions.length;
  if (count) {
    count.textContent = total + " jugadores seleccionados";
  }

  refreshRosterCheckboxes(select);
}

/**
 * Filters the outgoing trade player by season and team, and incoming player by season.
 *
 * @returns {void}
 */
function updateTradePlayers() {
  const form = document.querySelector("[data-trade-form]");
  if (!form) {
    return;
  }

  const season = form.querySelector("[data-trade-season]")?.value || "";
  const teamId = form.querySelector("[data-trade-team]")?.value || "";
  const sale = form.querySelector("[data-trade-sale]");
  const arrive = form.querySelector("[data-trade-arrive]");
  const saleSearch = normalizeComparisonText(form.querySelector("[data-player-search='sale']")?.value || "");
  const arriveSearch = normalizeComparisonText(form.querySelector("[data-player-search='arrive']")?.value || "");

  if (sale) {
    Array.from(sale.options).forEach((option) => {
      const matches = option.dataset.season === season
        && option.dataset.teamId === teamId;
      option.hidden = !matches;
      if (!matches) {
        option.selected = false;
      }
    });
    if (!sale.value) {
      const first = Array.from(sale.options).find((option) => !option.hidden);
      if (first && !saleSearch) {
        first.selected = true;
      }
    }
  }

  if (arrive) {
    Array.from(arrive.options).forEach((option) => {
      const matches = option.dataset.season === season;
      option.hidden = !matches;
      if (!matches) {
        option.selected = false;
      }
    });
    if (!arrive.value) {
      const first = Array.from(arrive.options).find((option) => !option.hidden);
      if (first && !arriveSearch) {
        first.selected = true;
      }
    }
  }

  document.querySelectorAll("[data-player-search]").forEach(renderPlayerSearchSuggestions);
}

/**
 * Builds the checkbox selector used by the new roster simulation.
 *
 * @param {HTMLSelectElement} select Native multiple select kept for form submission.
 * @returns {void}
 */
function setupRosterCheckboxPicker(select) {
  if (!select || select.dataset.checkboxPickerReady === "true") {
    return;
  }

  const picker = document.createElement("div");
  const search = document.createElement("input");
  const list = document.createElement("div");

  picker.className = "player-checkbox-picker";
  picker.dataset.rosterCheckboxPicker = "true";
  search.type = "search";
  search.className = "player-select-search";
  search.placeholder = "Buscar jugador por nombre o equipo...";
  search.dataset.rosterPlayerSearch = "true";
  list.className = "player-checkbox-list";
  list.dataset.rosterCheckboxList = "true";

  picker.append(search, list);
  select.insertAdjacentElement("afterend", picker);
  select.dataset.checkboxPickerReady = "true";

  search.addEventListener("input", updateRosterPlayers);
  refreshRosterCheckboxes(select);
}

/**
 * Synchronizes the visible checkbox list with the hidden multiple select.
 *
 * @param {HTMLSelectElement} select Native multiple select.
 * @returns {void}
 */
function refreshRosterCheckboxes(select) {
  const picker = select?.parentElement?.querySelector("[data-roster-checkbox-picker]");
  const list = picker?.querySelector("[data-roster-checkbox-list]");

  if (!select || !list) {
    return;
  }

  list.innerHTML = "";

  Array.from(select.options)
    .filter((option) => !option.hidden)
    .forEach((option) => {
      const label = document.createElement("label");
      const checkbox = document.createElement("input");
      const text = document.createElement("span");

      label.className = "player-checkbox-option";
      checkbox.type = "checkbox";
      checkbox.value = option.value;
      checkbox.checked = option.selected;
      text.textContent = option.textContent.trim().replace(/\s+/g, " ");

      checkbox.addEventListener("change", () => {
        if (checkbox.checked && select.selectedOptions.length >= 12) {
          checkbox.checked = false;
          alert("Puedes seleccionar como máximo 12 jugadores.");
          return;
        }

        option.selected = checkbox.checked;
        updateRosterPlayers();
      });

      label.append(checkbox, text);
      list.appendChild(label);
    });

  if (!list.children.length) {
    const empty = document.createElement("p");
    empty.className = "filter-status";
    empty.textContent = "No hay jugadores que coincidan con la búsqueda.";
    list.appendChild(empty);
  }
}

/**
 * Collects the visible dual-bar chart rows.
 *
 * @param {HTMLElement} chart Chart wrapper.
 * @returns {Array<{label:string,valueA:number,valueB:number,displayA:string,displayB:string}>}
 */
function collectComparisonChart(chart) {
  return Array.from(chart.querySelectorAll(".comparison-chart-row")).map((row) => ({
    label: row.dataset.label || row.querySelector(".chart-label")?.textContent.trim() || "Dato",
    valueA: readComparisonBarValue(row.querySelector(".dual-bar.is-a")),
    valueB: readComparisonBarValue(row.querySelector(".dual-bar.is-b")),
    displayA: row.dataset.a || "",
    displayB: row.dataset.b || ""
  }));
}

/**
 * Creates a downloadable SVG with grouped bars and a trend line.
 *
 * @param {string} title Chart title.
 * @param {Array<{label:string,valueA:number,valueB:number,displayA:string,displayB:string}>} data Chart rows.
 * @param {string} seriesA Label for the first compared series.
 * @param {string} seriesB Label for the second compared series.
 * @returns {string} SVG source.
 */
function createComparisonSvg(title, data, seriesA, seriesB) {
  const width = 1180;
  const height = 640;
  const plotX = 104;
  const plotY = 126;
  const plotW = 860;
  const plotH = 430;
  const groupW = Math.max(58, Math.min(104, plotW / Math.max(1, data.length)));
  const barW = Math.max(18, groupW * 0.28);
  const grid = [0, 20, 40, 60, 80, 100].map((tick) => {
    const y = plotY + plotH - (tick / 100) * plotH;
    return '<line x1="' + plotX + '" y1="' + y + '" x2="' + (plotX + plotW) + '" y2="' + y + '" stroke="#d9e4f2" stroke-width="1"/>' +
      '<text x="' + (plotX - 18) + '" y="' + (y + 5) + '" text-anchor="end" font-size="13" fill="#334155">' + tick + '</text>';
  }).join("");

  const bars = data.map((item, index) => {
    const groupX = plotX + index * groupW + 14;
    const hA = (item.valueA / 100) * plotH;
    const hB = (item.valueB / 100) * plotH;
    const yA = plotY + plotH - hA;
    const yB = plotY + plotH - hB;
    const label = item.label.length > 14 ? item.label.substring(0, 13) + "." : item.label;

    return '<rect x="' + groupX + '" y="' + yA + '" width="' + barW + '" height="' + hA + '" rx="5" fill="#1d428a"/>' +
      '<rect x="' + (groupX + barW + 8) + '" y="' + yB + '" width="' + barW + '" height="' + hB + '" rx="5" fill="#69a7ff"/>' +
      '<text x="' + (groupX + barW) + '" y="' + (plotY + plotH + 30) + '" text-anchor="middle" font-size="12" font-weight="700" fill="#061a3a">' + escapeComparisonXml(label) + '</text>';
  }).join("");

  const pointsA = data.map((item, index) => {
    const x = plotX + index * groupW + 14 + barW / 2;
    const y = plotY + plotH - (item.valueA / 100) * plotH;
    return x + "," + y;
  }).join(" ");

  const pointsB = data.map((item, index) => {
    const x = plotX + index * groupW + 14 + barW + 8 + barW / 2;
    const y = plotY + plotH - (item.valueB / 100) * plotH;
    return x + "," + y;
  }).join(" ");

  return '<svg xmlns="http://www.w3.org/2000/svg" width="' + width + '" height="' + height + '" viewBox="0 0 ' + width + ' ' + height + '">' +
    '<rect width="100%" height="100%" fill="#ffffff"/>' +
    '<text x="64" y="76" font-size="30" font-weight="900" fill="#061a3a">' + escapeComparisonXml(title) + '</text>' +
    '<text x="64" y="104" font-size="15" font-weight="700" fill="#334155">Diagrama mixto: barras agrupadas y tendencia por temporada</text>' +
    grid +
    '<line x1="' + plotX + '" y1="' + plotY + '" x2="' + plotX + '" y2="' + (plotY + plotH) + '" stroke="#061a3a" stroke-width="4"/>' +
    '<line x1="' + plotX + '" y1="' + (plotY + plotH) + '" x2="' + (plotX + plotW) + '" y2="' + (plotY + plotH) + '" stroke="#061a3a" stroke-width="4"/>' +
    '<text x="' + (plotX - 62) + '" y="' + (plotY + plotH / 2) + '" transform="rotate(-90 ' + (plotX - 62) + ' ' + (plotY + plotH / 2) + ')" text-anchor="middle" font-size="14" font-weight="900" fill="#061a3a">Eje Y: valor normalizado (%)</text>' +
    '<text x="' + (plotX + plotW / 2) + '" y="' + (plotY + plotH + 66) + '" text-anchor="middle" font-size="14" font-weight="900" fill="#061a3a">Eje X: métricas comparadas</text>' +
    bars +
    '<polyline points="' + pointsA + '" fill="none" stroke="#1d428a" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>' +
    '<polyline points="' + pointsB + '" fill="none" stroke="#69a7ff" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>' +
    '<rect x="1000" y="150" width="18" height="18" rx="4" fill="#1d428a"/><text x="1028" y="164" font-size="14" font-weight="800" fill="#061a3a">' + escapeComparisonXml(seriesA) + '</text>' +
    '<rect x="1000" y="186" width="18" height="18" rx="4" fill="#69a7ff"/><text x="1028" y="200" font-size="14" font-weight="800" fill="#061a3a">' + escapeComparisonXml(seriesB) + '</text>' +
    '</svg>';
}

/**
 * Downloads the closest comparison chart.
 *
 * @param {HTMLElement} button Button that triggered the download.
 * @returns {void}
 */
function downloadComparisonChart(button) {
  const scope = button.closest(".comparison-section") || document;
  const chart = scope.querySelector("[data-comparison-chart], [data-scenario-chart]");
  const chartBox = chart?.querySelector(".comparison-chart") || chart;

  if (!chartBox) {
    alert("Primero genera una comparativa para poder descargar la gráfica.");
    return;
  }

  const title = chart.dataset.chartTitle || "Comparativa NBA";
  const data = collectComparisonChart(chartBox);
  const seriesA = shortComparisonLegend(chart.dataset.seriesA || chartBox.dataset.seriesA || "Serie A");
  const seriesB = shortComparisonLegend(chart.dataset.seriesB || chartBox.dataset.seriesB || "Serie B");
  const svg = createComparisonSvg(title, data, seriesA, seriesB);
  const blob = new Blob([svg], { type: "image/svg+xml;charset=utf-8" });
  const link = document.createElement("a");

  link.href = URL.createObjectURL(blob);
  link.download = slugComparisonFileName(title) + ".svg";
  document.body.appendChild(link);
  link.click();
  link.remove();
  URL.revokeObjectURL(link.href);
}

/**
 * Escapes text for SVG output.
 *
 * @param {string} value Raw text.
 * @returns {string}
 */
function escapeComparisonXml(value) {
  return String(value).replace(/[<>&"']/g, (char) => ({
    "<": "&lt;",
    ">": "&gt;",
    "&": "&amp;",
    "\"": "&quot;",
    "'": "&#39;"
  })[char]);
}

/**
 * Creates a safe file name for exported charts.
 *
 * @param {string} value Raw title.
 * @returns {string}
 */
function slugComparisonFileName(value) {
  return normalizeComparisonText(value)
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "") || "comparativa-nba";
}

/**
 * Keeps legend labels readable inside exported SVG charts.
 *
 * @param {string} value Original legend label.
 * @returns {string} Shortened label.
 */
function shortComparisonLegend(value) {
  const label = String(value || "").trim() || "Serie";
  return label.length > 18 ? label.substring(0, 17) + "." : label;
}

/**
 * Extracts the final NBA year from a season label.
 *
 * @param {string} season Season in yyyy-yyyy format.
 * @returns {string} Final year used by the synchronization endpoint.
 */
function getComparisonSyncYear(season) {
  const parts = String(season || "").split("-");
  return parts.length > 1 ? parts[1].trim() : String(season || "").trim();
}

/**
 * Reads the seasons selected in the comparison form and converts them to sync years.
 *
 * @param {HTMLFormElement} form Comparison form.
 * @returns {string[]} Unique final years to synchronize.
 */
function getComparisonSyncYears(form) {
  const seasons = [
    form.querySelector("[name='temporadaA']")?.value,
    form.querySelector("[name='temporadaB']")?.value
  ];

  return Array.from(new Set(
    seasons
      .map(getComparisonSyncYear)
      .filter((year) => year)
  ));
}

/**
 * Synchronizes the selected seasons before allowing the comparison form to submit.
 *
 * @param {SubmitEvent} event Submit event from the comparison form.
 * @returns {Promise<void>}
 */
async function syncBeforeComparisonSubmit(event) {
  const form = event.currentTarget;

  if (form.dataset.syncReady === "true") {
    delete form.dataset.syncReady;
    return;
  }

  event.preventDefault();

  const token = document.querySelector('meta[name="_csrf"]')?.content;
  const header = document.querySelector('meta[name="_csrf_header"]')?.content;
  const overlay = document.getElementById("nba-sync-overlay");
  const overlayText = document.querySelector("[data-sync-overlay-text]");
  const submitButton = form.querySelector("button[type='submit']");
  const seasons = getComparisonSyncYears(form);
  const reports = [];

  if (!token || !header || seasons.length === 0) {
    form.dataset.syncReady = "true";
    form.requestSubmit();
    return;
  }

  if (overlay) {
    overlay.hidden = false;
  }
  if (submitButton) {
    submitButton.disabled = true;
    submitButton.dataset.originalText = submitButton.textContent;
    submitButton.textContent = "Cargando datos...";
  }

  try {
    for (let index = 0; index < seasons.length; index++) {
      const season = seasons[index];

      if (overlayText) {
        overlayText.textContent = "Cargando temporada " + season + " para la comparativa (" + (index + 1) + " de " + seasons.length + ")";
      }

      const response = await fetch("/admin/sync/all?season=" + encodeURIComponent(season), {
        method: "POST",
        headers: { [header]: token }
      });

      if (response.redirected && response.url.includes("/login")) {
        throw new Error("La sesión no tiene permisos activos para actualizar datos NBA.");
      }

      if (!response.ok) {
        throw new Error("Error " + response.status + " al cargar la temporada " + season);
      }

      if (typeof parseSyncReport === "function") {
        reports.push(parseSyncReport(await response.text()));
      } else {
        await response.text();
      }
    }

    form.dataset.syncReady = "true";
    form.requestSubmit();
  } catch (error) {
    if (typeof showSyncResultModal === "function") {
      showSyncResultModal(reports, error.message);
    } else {
      alert("No se pudieron cargar los datos antes de comparar: " + error.message);
    }
  } finally {
    if (overlay) {
      overlay.hidden = true;
    }
    if (overlayText) {
      overlayText.textContent = "Se están descargando y adaptando datos de la temporada seleccionada.";
    }
    if (submitButton) {
      submitButton.disabled = false;
      submitButton.textContent = submitButton.dataset.originalText || "Cargar y comparar temporadas";
    }
  }
}

document.addEventListener("DOMContentLoaded", () => {
  document.querySelector("[data-comparison-form]")
    ?.addEventListener("submit", syncBeforeComparisonSubmit);

  document.querySelectorAll("[data-download-comparison-chart], [data-download-scenario-chart]")
    .forEach((button) => {
      const scope = button.closest(".comparison-section") || document;
      const chart = scope.querySelector("[data-comparison-chart], [data-scenario-chart]");
      button.disabled = !chart;
    });

  const rosterSelect = document.querySelector("[data-roster-player-select]");

  setupRosterCheckboxPicker(rosterSelect);
  setupPlayerSearchInputs();
  document.querySelector("[data-roster-season]")?.addEventListener("change", updateRosterPlayers);
  rosterSelect?.addEventListener("change", updateRosterPlayers);
  document.querySelector("[data-trade-season]")?.addEventListener("change", updateTradePlayers);
  document.querySelector("[data-trade-team]")?.addEventListener("change", updateTradePlayers);
  document.querySelectorAll("[data-download-comparison-chart], [data-download-scenario-chart]")
    .forEach((button) => {
      button.addEventListener("click", () => downloadComparisonChart(button));
    });

  updateRosterPlayers();
  updateTradePlayers();
});

document.addEventListener("click", (event) => {
  if (event.target.closest("[data-player-search]") || event.target.closest(".player-suggestions")) {
    return;
  }

  document.querySelectorAll(".player-suggestions").forEach((list) => {
    list.hidden = true;
  });
});
