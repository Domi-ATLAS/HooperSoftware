<%@ tag description="Global Layout" pageEncoding="UTF-8" %>
<%@ attribute name="title" required="true" rtexprvalue="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <%-- Cabecera compartida: carga estilos globales, JS de filtros y metadatos responsive. --%>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>${title}</title>

  <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
  <script src="<c:url value='/js/data_filters.js'/>" defer></script>
</head>

<!-- CSRF -->
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<script>
// Acción administrativa global: sincroniza datos NBA para la temporada seleccionada.
/**
 * Lanza la sincronización administrativa de datos NBA para la temporada seleccionada.
 * @returns {void}
 */
async function runNbaScraping() {

  const seasons = getSyncSeasons();
  const seasonText = seasons.length === 1 ? seasons[0] : seasons[0] + " - " + seasons[seasons.length - 1];

  if (!confirm('Actualizar datos NBA para ' + seasonText + '?')) return;

  const token = document.querySelector('meta[name="_csrf"]').content;
  const header = document.querySelector('meta[name="_csrf_header"]').content;

  const overlay = document.getElementById("nba-sync-overlay");
  const overlayText = document.querySelector("[data-sync-overlay-text]");
  const syncButton = document.querySelector("[data-nba-sync-button]");

  if (overlay) {
    overlay.hidden = false;
  }
  if (syncButton) {
    syncButton.disabled = true;
    syncButton.dataset.originalText = syncButton.textContent;
    syncButton.textContent = "Actualizando...";
  }

  const results = [];

  try {
    for (let index = 0; index < seasons.length; index++) {
      const season = seasons[index];

      if (overlayText) {
        overlayText.textContent = "Temporada " + season + " (" + (index + 1) + " de " + seasons.length + ")";
      }

      const response = await fetch('/admin/sync/all?season=' + season, {
        method: 'POST',
        headers: { [header]: token }
      });

      if (!response.ok) throw new Error("Error " + response.status + " en temporada " + season);

      results.push(parseSyncReport(await response.text()));
    }

    showSyncResultModal(results);
  } catch (err) {
    showSyncResultModal(results, err.message);
  } finally {
    if (overlay) {
      overlay.hidden = true;
    }
    if (overlayText) {
      overlayText.textContent = "Se estan descargando y adaptando datos de la temporada seleccionada.";
    }
    if (syncButton) {
      syncButton.disabled = false;
      syncButton.textContent = syncButton.dataset.originalText || "Actualizar NBA";
    }
  }
}

/**
 * Convierte el resumen textual del backend en datos listos para mostrar.
 * @param {string} reportText Respuesta generada por el servicio de sincronizacion.
 * @returns {{season:string, teams:string, players:string, games:string, status:string, warnings:string}}
 */
function parseSyncReport(reportText) {
  const report = {
    season: "-",
    teams: "0",
    players: "0",
    games: "0",
    status: "Completado",
    warnings: "-"
  };

  reportText.split("|").map(part => part.trim()).forEach(function(part) {
    if (part.startsWith("Temporada")) {
      report.season = part.replace("Temporada", "").trim();
    } else if (part.startsWith("Equipos:")) {
      report.teams = part.replace("Equipos:", "").trim();
    } else if (part.startsWith("Jugadores:")) {
      report.players = part.replace("Jugadores:", "").trim();
    } else if (part.startsWith("Partidos:")) {
      report.games = part.replace("Partidos:", "").trim();
    } else if (part.startsWith("Avisos:")) {
      report.warnings = part.replace("Avisos:", "").trim() || "-";
    } else if (part) {
      report.status = part;
    }
  });

  return report;
}

/**
 * Muestra el resumen final de sincronizacion en un modal con formato de tabla.
 * @param {Array<{season:string, teams:string, players:string, games:string, status:string, warnings:string}>} reports
 * @param {string=} errorMessage Mensaje de error si la sincronizacion se corta.
 * @returns {void}
 */
function showSyncResultModal(reports, errorMessage) {
  const modal = document.getElementById("sync-result-modal");
  const tbody = document.querySelector("[data-sync-result-body]");
  const summary = document.querySelector("[data-sync-result-summary]");
  const errorBox = document.querySelector("[data-sync-result-error]");

  if (!modal || !tbody || !summary || !errorBox) return;

  tbody.innerHTML = "";

  reports.forEach(function(report) {
    const row = document.createElement("tr");

    ["season", "teams", "players", "games", "status", "warnings"].forEach(function(field) {
      const cell = document.createElement("td");
      cell.textContent = report[field];
      row.appendChild(cell);
    });

    tbody.appendChild(row);
  });

  if (reports.length === 0) {
    const row = document.createElement("tr");
    const cell = document.createElement("td");
    cell.colSpan = 6;
    cell.textContent = "No se llego a completar ninguna temporada.";
    row.appendChild(cell);
    tbody.appendChild(row);
  }

  summary.textContent = reports.length === 1
    ? "Se ha procesado 1 temporada."
    : "Se han procesado " + reports.length + " temporadas.";

  errorBox.hidden = !errorMessage;
  errorBox.textContent = errorMessage ? "Sincronizacion interrumpida: " + errorMessage : "";

  modal.hidden = false;
}

/**
 * Cierra el modal de resumen de sincronizacion.
 * @returns {void}
 */
function closeSyncResultModal() {
  const modal = document.getElementById("sync-result-modal");
  if (modal) {
    modal.hidden = true;
  }
}

/**
 * Muestra u oculta las graficas y la explicacion matematica de una simulacion.
 * @param {HTMLButtonElement} button Boton que activa el panel de detalle.
 * @returns {void}
 */
function toggleSimulationInsight(button) {
  const scope = button.closest(".sim-container, .sim-page, .sim-card-container, .lineup-page") || document;
  const panels = scope.querySelectorAll("[data-simulation-insight]");
  const shouldShow = Array.from(panels).some(function(panel) {
    return panel.hidden;
  });

  panels.forEach(function(panel) {
    panel.hidden = !shouldShow;
  });

  button.textContent = shouldShow ? "Ocultar gráficas y modelo" : "Ver gráficas y modelo";
}

/**
 * Crea botones de descarga para las graficas de simulacion ya renderizadas.
 * @returns {void}
 */
function setupSimulationDownloads() {
  document.querySelectorAll(".simulation-toggle").forEach(function(toggle) {
    if (toggle.nextElementSibling && toggle.nextElementSibling.classList.contains("simulation-download")) {
      return;
    }

    const downloadButton = document.createElement("button");
    downloadButton.type = "button";
    downloadButton.className = "search-btn simulation-download";
    downloadButton.textContent = "Descargar gráfica avanzada";
    downloadButton.disabled = toggle.disabled;
    downloadButton.addEventListener("click", function() {
      downloadAdvancedSimulationChart(downloadButton);
    });

    toggle.insertAdjacentElement("afterend", downloadButton);
  });
}

/**
 * Descarga una grafica SVG avanzada construida desde los datos visibles de una simulacion.
 * @param {HTMLButtonElement} button Boton de descarga pulsado por el usuario.
 * @returns {void}
 */
function downloadAdvancedSimulationChart(button) {
  const scope = button.closest(".sim-container, .sim-page, .sim-card-container, .lineup-page") || document;
  const insight = scope.querySelector("[data-simulation-insight]");
  const chart = insight ? insight.querySelector(".simulation-chart") : null;
  const data = chart ? collectSimulationChartData(chart) : [];

  if (data.length === 0) {
    alert("No hay datos numéricos suficientes para generar la gráfica avanzada.");
    return;
  }

  const titleNode = insight.querySelector("h2");
  const methodNode = insight.querySelector(".simulation-method-grid p");
  const title = titleNode ? titleNode.textContent.trim() : "Gráfica avanzada de simulación";
  const method = methodNode ? methodNode.textContent.trim() : "Modelo de simulacion basado en datos internos.";
  const svg = createAdvancedSimulationSvg(title, method, data);
  const blob = new Blob([svg], { type: "image/svg+xml;charset=utf-8" });
  const link = document.createElement("a");

  link.href = URL.createObjectURL(blob);
  link.download = slugifyFileName(title) + ".svg";
  document.body.appendChild(link);
  link.click();
  link.remove();
  URL.revokeObjectURL(link.href);
}

/**
 * Extrae etiquetas y valores normalizados de una grafica de simulacion.
 * @param {HTMLElement} chart Contenedor de la grafica.
 * @returns {Array<{label:string,value:number,display:string}>}
 */
function collectSimulationChartData(chart) {
  return Array.from(chart.querySelectorAll(".chart-row")).map(function(row) {
    const label = row.querySelector(".chart-label")?.textContent.trim() || "Dato";
    const fill = row.querySelector(".chart-fill");
    const display = row.querySelector(".chart-value")?.textContent.trim() || "0";
    const value = Number((fill?.style.getPropertyValue("--value") || "0").replace(",", "."));

    return {
      label: label,
      value: Math.max(0, Math.min(100, Number.isFinite(value) ? value : 0)),
      display: display
    };
  }).filter(function(item) {
    return item.label;
  });
}

/**
 * Genera un SVG con barras, linea comparativa, ejes, cuadricula y resumen estadistico.
 * @param {string} title Titulo de la grafica.
 * @param {string} method Explicacion breve del modelo usado.
 * @param {Array<{label:string,value:number,display:string}>} data Datos normalizados.
 * @returns {string}
 */
function createAdvancedSimulationSvg(title, method, data) {
  const width = 1120;
  const height = 700;
  const plotX = 104;
  const plotY = 118;
  const plotW = 760;
  const plotH = 430;
  const barGap = 22;
  const barW = Math.max(34, Math.min(72, (plotW - barGap * (data.length + 1)) / data.length));
  const avg = data.reduce(function(sum, item) { return sum + item.value; }, 0) / data.length;
  const max = Math.max.apply(null, data.map(function(item) { return item.value; }));
  const min = Math.min.apply(null, data.map(function(item) { return item.value; }));
  const points = data.map(function(item, index) {
    const x = plotX + barGap + index * (barW + barGap) + barW / 2;
    const y = plotY + plotH - (item.value / 100) * plotH;
    return x + "," + y;
  }).join(" ");

  const grid = [0, 20, 40, 60, 80, 100].map(function(tick) {
    const y = plotY + plotH - (tick / 100) * plotH;
    return '<line x1="' + plotX + '" y1="' + y + '" x2="' + (plotX + plotW) + '" y2="' + y + '" stroke="#d9e4f2" stroke-width="1"/>' +
           '<text x="' + (plotX - 18) + '" y="' + (y + 5) + '" text-anchor="end" font-size="13" fill="#5f6368">' + tick + '</text>';
  }).join("");

  const bars = data.map(function(item, index) {
    const x = plotX + barGap + index * (barW + barGap);
    const h = (item.value / 100) * plotH;
    const y = plotY + plotH - h;
    const color = index % 2 === 0 ? "#1d428a" : "#69a7ff";
    const label = item.label.length > 14 ? item.label.substring(0, 13) + "." : item.label;

    return '<rect x="' + x + '" y="' + y + '" width="' + barW + '" height="' + h + '" rx="6" fill="' + color + '"/>' +
           '<text x="' + (x + barW / 2) + '" y="' + (y - 10) + '" text-anchor="middle" font-size="13" font-weight="700" fill="#061a3a">' + escapeXml(item.display) + '</text>' +
           '<text x="' + (x + barW / 2) + '" y="' + (plotY + plotH + 30) + '" text-anchor="middle" font-size="12" font-weight="700" fill="#061a3a">' + escapeXml(label) + '</text>';
  }).join("");

  const avgY = plotY + plotH - (avg / 100) * plotH;
  const summaryX = 890;

  return '<svg xmlns="http://www.w3.org/2000/svg" width="' + width + '" height="' + height + '" viewBox="0 0 ' + width + ' ' + height + '">' +
    '<rect width="100%" height="100%" fill="#ffffff"/>' +
    '<text x="64" y="74" font-size="30" font-weight="900" fill="#061a3a">' + escapeXml(title) + '</text>' +
    '<text x="64" y="100" font-size="15" font-weight="700" fill="#334155">Diagrama mixto: barras normalizadas, tendencia, media y dispersión básica</text>' +
    grid +
    '<line x1="' + plotX + '" y1="' + plotY + '" x2="' + plotX + '" y2="' + (plotY + plotH) + '" stroke="#061a3a" stroke-width="4"/>' +
    '<line x1="' + plotX + '" y1="' + (plotY + plotH) + '" x2="' + (plotX + plotW) + '" y2="' + (plotY + plotH) + '" stroke="#061a3a" stroke-width="4"/>' +
    '<text x="' + (plotX - 62) + '" y="' + (plotY + plotH / 2) + '" transform="rotate(-90 ' + (plotX - 62) + ' ' + (plotY + plotH / 2) + ')" text-anchor="middle" font-size="14" font-weight="900" fill="#061a3a">Eje Y: valor normalizado (%)</text>' +
    '<text x="' + (plotX + plotW / 2) + '" y="' + (plotY + plotH + 66) + '" text-anchor="middle" font-size="14" font-weight="900" fill="#061a3a">Eje X: métricas simuladas</text>' +
    bars +
    '<polyline points="' + points + '" fill="none" stroke="#69a7ff" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>' +
    '<line x1="' + plotX + '" y1="' + avgY + '" x2="' + (plotX + plotW) + '" y2="' + avgY + '" stroke="#1d428a" stroke-width="3" stroke-dasharray="10 8"/>' +
    '<text x="' + (plotX + plotW - 8) + '" y="' + (avgY - 8) + '" text-anchor="end" font-size="13" font-weight="800" fill="#1d428a">Media ' + avg.toFixed(1) + '</text>' +
    '<text x="' + (summaryX + 18) + '" y="158" font-size="17" font-weight="900" fill="#061a3a">Resumen</text>' +
    '<text x="' + (summaryX + 18) + '" y="196" font-size="14" font-weight="700" fill="#334155">Media: ' + avg.toFixed(1) + '</text>' +
    '<text x="' + (summaryX + 18) + '" y="226" font-size="14" font-weight="700" fill="#334155">Máximo: ' + max.toFixed(1) + '</text>' +
    '<text x="' + (summaryX + 18) + '" y="256" font-size="14" font-weight="700" fill="#334155">Mínimo: ' + min.toFixed(1) + '</text>' +
    '<text x="' + (summaryX + 18) + '" y="286" font-size="14" font-weight="700" fill="#334155">Rango: ' + (max - min).toFixed(1) + '</text>' +
    '<circle cx="' + (summaryX + 24) + '" cy="326" r="6" fill="#1d428a"/><text x="' + (summaryX + 40) + '" y="331" font-size="13" fill="#334155">Barras</text>' +
    '<circle cx="' + (summaryX + 24) + '" cy="350" r="6" fill="#69a7ff"/><text x="' + (summaryX + 40) + '" y="355" font-size="13" fill="#334155">Tendencia</text>' +
    '<text x="64" y="646" font-size="15" font-weight="900" fill="#061a3a">Modelo utilizado</text>' +
    '<foreignObject x="64" y="662" width="990" height="34"><div xmlns="http://www.w3.org/1999/xhtml" style="font: 13px Arial, sans-serif; color:#475569; line-height:1.35;">' + escapeXml(method) + '</div></foreignObject>' +
    '</svg>';
}

/**
 * Escapa texto para insertarlo de forma segura dentro de SVG.
 * @param {string} value Texto original.
 * @returns {string}
 */
function escapeXml(value) {
  return String(value).replace(/[<>&"']/g, function(char) {
    return ({ "<": "&lt;", ">": "&gt;", "&": "&amp;", "\"": "&quot;", "'": "&#39;" })[char];
  });
}

/**
 * Normaliza un texto para usarlo como nombre de fichero.
 * @param {string} value Texto original.
 * @returns {string}
 */
function slugifyFileName(value) {
  return String(value).toLowerCase()
    .normalize("NFD").replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "") || "grafica-simulacion";
}

/**
 * Abre o cierra el panel visual de temporadas del header.
 * @returns {void}
 */
function toggleSeasonPicker() {
  const picker = document.getElementById("seasonPicker");
  const button = document.querySelector("[data-season-picker-toggle]");

  if (!picker || !button) return;

  const shouldOpen = picker.hidden;
  picker.hidden = !shouldOpen;
  button.setAttribute("aria-expanded", String(shouldOpen));
}

/**
 * Selecciona la temporada administrativa usada por el boton de actualizacion.
 * @param {string} season Temporada final NBA, por ejemplo 2024 para 2023-2024.
 * @returns {void}
 */
function selectSyncSeason(season) {
  const input = document.getElementById("seasonSelect");
  const startInput = document.getElementById("seasonRangeStart");
  const endInput = document.getElementById("seasonRangeEnd");
  const rangeToggle = document.getElementById("seasonRangeEnabled");
  const label = document.querySelector("[data-season-picker-label]");
  const picker = document.getElementById("seasonPicker");
  const button = document.querySelector("[data-season-picker-toggle]");

  if (rangeToggle && rangeToggle.checked && startInput && endInput) {
    const nextStep = rangeToggle.dataset.rangeStep || "start";

    if (nextStep === "start") {
      startInput.value = season;
      endInput.value = season;
      rangeToggle.dataset.rangeStep = "end";
    } else {
      endInput.value = season;
      rangeToggle.dataset.rangeStep = "start";
    }

    updateSeasonPickerLabel();
    return;
  }

  if (input) {
    input.value = season;
  }
  if (label) label.textContent = season;
  if (picker) {
    picker.hidden = true;
  }
  if (button) {
    button.setAttribute("aria-expanded", "false");
  }

  updateSeasonPickerLabel();
}

/**
 * Activa o desactiva la seleccion de un intervalo de temporadas.
 * @returns {void}
 */
function toggleSeasonRangeMode() {
  const rangeToggle = document.getElementById("seasonRangeEnabled");
  const picker = document.querySelector("[data-season-picker]");

  if (!rangeToggle || !picker) return;

  picker.classList.toggle("is-range-mode", rangeToggle.checked);
  rangeToggle.dataset.rangeStep = "start";
  updateSeasonPickerLabel();
}

/**
 * Devuelve las temporadas que se deben sincronizar, ya sea una sola o un rango.
 * @returns {string[]} Lista ordenada de temporadas finales NBA.
 */
function getSyncSeasons() {
  const rangeToggle = document.getElementById("seasonRangeEnabled");

  if (!rangeToggle || !rangeToggle.checked) {
    return [document.getElementById("seasonSelect").value];
  }

  const start = Number(document.getElementById("seasonRangeStart").value);
  const end = Number(document.getElementById("seasonRangeEnd").value);
  const min = Math.min(start, end);
  const max = Math.max(start, end);
  const seasons = [];

  for (let season = min; season <= max; season++) {
    seasons.push(String(season));
  }

  return seasons;
}

/**
 * Actualiza el texto visible del boton y los estados activos de las temporadas.
 * @returns {void}
 */
function updateSeasonPickerLabel() {
  const rangeToggle = document.getElementById("seasonRangeEnabled");
  const label = document.querySelector("[data-season-picker-label]");
  const startInput = document.getElementById("seasonRangeStart");
  const endInput = document.getElementById("seasonRangeEnd");
  const singleInput = document.getElementById("seasonSelect");
  const rangeText = document.querySelector("[data-season-range-label]");

  if (!label) return;

  if (rangeToggle && rangeToggle.checked && startInput && endInput) {
    const start = Number(startInput.value);
    const end = Number(endInput.value);
    const min = Math.min(start, end);
    const max = Math.max(start, end);
    label.textContent = min === max ? String(min) : min + "-" + max;
    if (rangeText) rangeText.textContent = "Desde " + min + " hasta " + max;
  } else if (singleInput) {
    label.textContent = singleInput.value;
    if (rangeText) rangeText.textContent = "Selección simple";
  }

  updateSeasonButtonStates();
}

/**
 * Marca visualmente los años activos dentro del selector.
 * @returns {void}
 */
function updateSeasonButtonStates() {
  const rangeToggle = document.getElementById("seasonRangeEnabled");
  const singleInput = document.getElementById("seasonSelect");
  const startInput = document.getElementById("seasonRangeStart");
  const endInput = document.getElementById("seasonRangeEnd");

  document.querySelectorAll(".season-grid button").forEach(function(button) {
    const season = Number(button.textContent.trim());
    let active = false;

    if (rangeToggle && rangeToggle.checked && startInput && endInput) {
      const min = Math.min(Number(startInput.value), Number(endInput.value));
      const max = Math.max(Number(startInput.value), Number(endInput.value));
      active = season >= min && season <= max;
    } else if (singleInput) {
      active = button.textContent.trim() === singleInput.value;
    }

    button.classList.toggle("is-selected", active);
  });
}

document.addEventListener("click", function(event) {
  const pickerWrap = document.querySelector("[data-season-picker]");
  const picker = document.getElementById("seasonPicker");
  const button = document.querySelector("[data-season-picker-toggle]");

  if (!pickerWrap || !picker || picker.hidden || pickerWrap.contains(event.target)) {
    return;
  }

  picker.hidden = true;
  if (button) {
    button.setAttribute("aria-expanded", "false");
  }
});

document.addEventListener("DOMContentLoaded", function() {
  updateSeasonPickerLabel();
  setupSimulationDownloads();
});
</script>

<body>
<header class="site-header">
  <%-- Navegación principal: accesos de la aplicación y botones condicionados por seguridad. --%>
  <nav class="nav">
    <div class="nav-brand">
      <a class="logo-btn"  onclick="location.href='/welcome'"><img src="/images/HS.png" alt="HS"></a>
    </div>

    <div class="nav-menu">
      <button class="btn" onclick="location.href='/noticias'">Noticias</button>
      <button class="btn" onclick="location.href='/allTranferences'">Transferencias</button>
      <button class="btn" onclick="location.href='/allGames'">Partidos</button>
      <button class="btn" onclick="location.href='/allPlayOffs'">Play Offs</button>
      <button class="btn" onclick="location.href='/allVotes'">Votaciones</button>

      <sec:authorize access="isAuthenticated()">
        <button class="btn" onclick="location.href='/profile'">Perfil</button>
      </sec:authorize>

      <button class="btn" onclick="location.href='/buscador'">Buscador</button>
      <button class="btn" onclick="location.href='/allPlayers'">Jugadores | Entrenadores</button>
      <button class="btn" onclick="location.href='/about'">Proyecto</button>

      <sec:authorize access="hasAuthority('admin')">
        <button class="btn" onclick="location.href='/simulaciones'">
          Simulaciones
        </button>
      </sec:authorize>

    </div>

    <sec:authorize access="hasAuthority('admin')">
      <!-- Zona administrativa de temporada: separada de la navegación general y de la sesión. -->
      <div class="nav-sync" aria-label="Actualización de datos NBA">
        <span class="nav-sync-label">Datos NBA</span>
        <div class="season-picker" data-season-picker>
          <input type="hidden" id="seasonSelect" value="2024">
          <input type="hidden" id="seasonRangeStart" value="2024">
          <input type="hidden" id="seasonRangeEnd" value="2024">
          <button class="season-picker-button"
                  type="button"
                  data-season-picker-toggle
                  aria-expanded="false"
                  aria-controls="seasonPicker"
                  onclick="toggleSeasonPicker()">
            Temporada <strong data-season-picker-label>2024</strong>
          </button>
          <div id="seasonPicker" class="season-picker-popover" hidden>
            <div class="season-picker-head">
              <strong>Elegir temporada</strong>
              <span>Datos por año final</span>
            </div>
            <label class="season-range-toggle" for="seasonRangeEnabled">
              <input id="seasonRangeEnabled"
                     type="checkbox"
                     onchange="toggleSeasonRangeMode()">
              Seleccionar rango
            </label>
            <p class="season-range-help" data-season-range-label>Selección simple</p>
            <div class="season-grid" role="listbox" aria-label="Temporadas NBA">
              <button type="button" onclick="selectSyncSeason('2024')">2024</button>
              <button type="button" onclick="selectSyncSeason('2023')">2023</button>
              <button type="button" onclick="selectSyncSeason('2022')">2022</button>
              <button type="button" onclick="selectSyncSeason('2021')">2021</button>
              <button type="button" onclick="selectSyncSeason('2020')">2020</button>
              <button type="button" onclick="selectSyncSeason('2019')">2019</button>
              <button type="button" onclick="selectSyncSeason('2018')">2018</button>
              <button type="button" onclick="selectSyncSeason('2017')">2017</button>
              <button type="button" onclick="selectSyncSeason('2016')">2016</button>
              <button type="button" onclick="selectSyncSeason('2015')">2015</button>
              <button type="button" onclick="selectSyncSeason('2014')">2014</button>
              <button type="button" onclick="selectSyncSeason('2013')">2013</button>
              <button type="button" onclick="selectSyncSeason('2012')">2012</button>
              <button type="button" onclick="selectSyncSeason('2011')">2011</button>
              <button type="button" onclick="selectSyncSeason('2010')">2010</button>
              <button type="button" onclick="selectSyncSeason('2009')">2009</button>
              <button type="button" onclick="selectSyncSeason('2008')">2008</button>
              <button type="button" onclick="selectSyncSeason('2007')">2007</button>
              <button type="button" onclick="selectSyncSeason('2006')">2006</button>
              <button type="button" onclick="selectSyncSeason('2005')">2005</button>
              <button type="button" onclick="selectSyncSeason('2004')">2004</button>
              <button type="button" onclick="selectSyncSeason('2003')">2003</button>
              <button type="button" onclick="selectSyncSeason('2002')">2002</button>
              <button type="button" onclick="selectSyncSeason('2001')">2001</button>
              <button type="button" onclick="selectSyncSeason('2000')">2000</button>
              <button type="button" onclick="selectSyncSeason('1999')">1999</button>
              <button type="button" onclick="selectSyncSeason('1998')">1998</button>
            </div>
          </div>
        </div>
        <button class="btn btn-admin"
                data-nba-sync-button
                onclick="runNbaScraping()"
                title="Actualizar datos NBA">
           Actualizar NBA
        </button>
      </div>
    </sec:authorize>

    <div class="nav-session">
      <sec:authorize access="!isAuthenticated()">
        <button class="btn" onclick="location.href='/login'">Iniciar sesión</button>
        <button class="btn" onclick="location.href='/new'">Registrarse</button>
      </sec:authorize>

      <sec:authorize access="isAuthenticated()">
        <a class="btn" href="/logout">Cerrar sesión</a>
      </sec:authorize>
    </div>
  </nav>

   <%-- Carrusel horizontal de equipos: acceso rápido desde cualquier vista. --%>
   <div class="teams-strip">
      <button class="icon-btn" onclick="location.href='/equipos/ChicagoBulls'"><img src="/images/CHI.png" alt="ChicagoBulls"></button>
      <button class="icon-btn" onclick="location.href='/equipos/BostonCeltics'"><img src="/images/BOS.png" alt="BostonCeltics"></button>
      <button class="icon-btn" onclick="location.href='/equipos/IndianaPacers'"><img src="/images/IND.png" alt="IndianaPacers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MilwaukeeBucks'"><img src="/images/MIL.png" alt="MilwaukeeBucks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/DetroitPistons'"><img src="/images/DET.png" alt="DetroitPistons"></button>
      <button class="icon-btn" onclick="location.href='/equipos/ClevelandCavaliers'"><img src="/images/CLE.png" alt="ClevelandCavaliers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/TorontoRaptors'"><img src="/images/TOR.png" alt="TorontoRaptors"></button>
      <button class="icon-btn" onclick="location.href='/equipos/BrooklynNets'"><img src="/images/BKN.png" alt="BrooklynNets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/NewYorkKnicks'"><img src="/images/NYK.png" alt="NewYorkKnicks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/Philadelphia76ers'"><img src="/images/PHI.png" alt="Philadelphia76ers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/WashingtonWizards'"><img src="/images/WAS.png" alt="WashingtonWizards"></button>
      <button class="icon-btn" onclick="location.href='/equipos/CharlotteHornets'"><img src="/images/CHA.png" alt="CharlotteHornets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/AtlantaHawks'"><img src="/images/ATL.png" alt="AtlantaHawks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/OrlandoMagic'"><img src="/images/ORL.png" alt="OrlandoMagic"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MiamiHeat'"><img src="/images/MIA.png" alt="MiamiHeat"></button>
      <button class="icon-btn" onclick="location.href='/equipos/SacramentoKings'"><img src="/images/SAC.png" alt="SacramentoKings"></button>
      <button class="icon-btn" onclick="location.href='/equipos/GoldenStateWarriors'"><img src="/images/GSW.png" alt="GoldenStateWarriors"></button>
      <button class="icon-btn" onclick="location.href='/equipos/LosAngelesClippers'"><img src="/images/LAC.png" alt="LosAngelesClippers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/LosAngelesLakers'"><img src="/images/LAL.png" alt="LosAngelesLakers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/SanAntonioSpurs'"><img src="/images/SAS.png" alt="SanAntonioSpurs"></button>
      <button class="icon-btn" onclick="location.href='/equipos/DallasMavericks'"><img src="/images/DAL.png" alt="DallasMavericks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/NewOrleansPelicans'"><img src="/images/NOP.png" alt="NewOrleansPelicans"></button>
      <button class="icon-btn" onclick="location.href='/equipos/OklahomaCityThunder'"><img src="/images/OKC.png" alt="OklahomaCityThunder"></button>
      <button class="icon-btn" onclick="location.href='/equipos/PhoenixSuns'"><img src="/images/PHX.png" alt="PhoenixSuns"></button>
      <button class="icon-btn" onclick="location.href='/equipos/UtahJazz'"><img src="/images/UTA.png" alt="UtahJazz"></button>
      <button class="icon-btn" onclick="location.href='/equipos/DenverNuggets'"><img src="/images/DEN.png" alt="DenverNuggets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/PortlandTrailBlazers'"><img src="/images/POR.png" alt="PortlandTrailBlazers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MinnesotaTimberwolves'"><img src="/images/MIN.png" alt="MinnesotaTimberwolves"></button>
      <button class="icon-btn" onclick="location.href='/equipos/HoustonRockets'"><img src="/images/HOU.png" alt="HoustonRockets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MemphisGrizzlies'"><img src="/images/MEM.png" alt="MemphisGrizzlies"></button>
    </div>
</header>

<main class="site-main">
  <%-- Punto de inserción del contenido propio de cada JSP. --%>
  <div class="container">
    <jsp:doBody/>
  </div>
</main>

<div id="nba-sync-overlay" class="sync-overlay" hidden>
  <div class="sync-dialog">
    <div class="sync-spinner"></div>
    <strong>Actualizando datos NBA</strong>
    <p data-sync-overlay-text>Se estan descargando y adaptando datos de la temporada seleccionada.</p>
  </div>
</div>

<div id="sync-result-modal" class="sync-result-modal" hidden>
  <div class="sync-result-card" role="dialog" aria-modal="true" aria-labelledby="sync-result-title">
    <div class="sync-result-header">
      <div>
        <p class="eyebrow">Resumen de descarga</p>
        <h2 id="sync-result-title">Datos recogidos</h2>
        <p data-sync-result-summary>Se han procesado las temporadas seleccionadas.</p>
      </div>
      <button class="sync-result-close" type="button" onclick="closeSyncResultModal()" aria-label="Cerrar resumen">X</button>
    </div>
    <p class="error-box sync-result-error" data-sync-result-error hidden></p>
    <div class="sync-result-table-wrap">
      <table class="sync-result-table">
        <thead>
          <tr>
            <th>Temporada</th>
            <th>Equipos</th>
            <th>Jugadores</th>
            <th>Partidos</th>
            <th>Estado</th>
            <th>Avisos</th>
          </tr>
        </thead>
        <tbody data-sync-result-body></tbody>
      </table>
    </div>
    <div class="sync-result-actions">
      <button class="btn" type="button" onclick="location.href='/allPlayers'">Ver jugadores</button>
      <button class="btn btn-secondary" type="button" onclick="location.href='/allGames'">Ver partidos</button>
      <button class="btn btn-secondary" type="button" onclick="closeSyncResultModal()">Cerrar</button>
    </div>
  </div>
</div>

<footer class="site-footer">
  <p>Correo: hooperSoftware@gmail.com · Tlf: 623 126 742</p>
</footer>

<sec:authorize access="isAuthenticated()">

<%-- Chat global flotante: solo se renderiza para usuarios autenticados. --%>
<div id="chat-toggle">

    Chat NBA

</div>

<div id="chat-window">

    <div class="chat-header">

        Chat Global NBA

        <span id="chat-close" style="cursor:pointer;">X</span>

    </div>

    <div id="chat-messages">

        Cargando...

    </div>

    <form id="chat-form">

        <input
            type="text"
            id="chat-input"
            placeholder="Escribe un mensaje..."
            maxlength="300">

        <button type="submit">
            Enviar
        </button>

    </form>

</div>

<script>

// Abre el panel y carga los mensajes iniciales.
document
.getElementById("chat-toggle")
.addEventListener("click", () => {

    document
        .getElementById("chat-window")
        .style.display = "flex";

    cargarMensajes();

});

// Cierra el panel sin perder el estado del resto de la vista.
document
.getElementById("chat-close")
.addEventListener("click", () => {

    document
        .getElementById("chat-window")
        .style.display = "none";

});

// Recupera mensajes del backend y los pinta en orden cronológico visual.
/**
 * Carga los mensajes del chat global y actualiza el panel visible.
 * @returns {Promise<void>}
 */
async function cargarMensajes() {

    const response = await fetch("/chat/messages");

    const mensajes = await response.json();

    const container =
        document.getElementById("chat-messages");

    container.innerHTML = "";

    mensajes.reverse().forEach(m => {

        const div = document.createElement("div");

        div.style.padding = "10px";
        div.style.marginBottom = "10px";
        div.style.borderBottom = "1px solid #ddd";
        div.style.display = "flex";
        div.style.alignItems = "flex-start";
        div.style.gap = "10px";

        div.innerHTML =
            "<div class='chat-message-content'>" +

            "<b>" + m.username + "</b><br>" +

            m.mensaje +

            "</div>";

        container.appendChild(div);

    });

    container.scrollTop =
        container.scrollHeight;

}

// Envía un mensaje usando el token CSRF de la página.
/**
 * Envía un mensaje al chat global usando el token CSRF de la página.
 * @param {string} texto Texto escrito por el usuario.
 * @returns {Promise<void>}
 */
async function enviarMensaje(texto){

    const token =
        document
            .querySelector('meta[name="_csrf"]')
            .content;

    const header =
        document
            .querySelector('meta[name="_csrf_header"]')
            .content;

    const params =
        new URLSearchParams();

    params.append("mensaje", texto);

    await fetch("/chat/send",{

        method:"POST",

        headers:{
            [header]:token,
            "Content-Type":
            "application/x-www-form-urlencoded"
        },

        body:params

    });

    cargarMensajes();

}

// Refresco periódico solo mientras el chat está abierto.
setInterval(() => {

    const abierto =
        document
            .getElementById("chat-window")
            .style.display === "flex";

    if(abierto){

        cargarMensajes();

    }

},5000);

// Valida el formulario del chat y evita enviar mensajes vacíos.
document
.getElementById("chat-form")
.addEventListener("submit",
async function(e){

    e.preventDefault();

    const input =
        document.getElementById("chat-input");

    const texto =
        input.value.trim();

    if(texto===""){

        return;

    }

    await enviarMensaje(texto);

    input.value="";

});

</script>

</sec:authorize>
</body>
</html>
