(function () {
  /**
   * Normaliza un valor para comparar textos de forma flexible en los filtros.
   *
   * @param {*} value Valor original procedente de un control o elemento HTML.
   * @returns {string} Texto en minúsculas, sin acentos y sin espacios sobrantes.
   */
  function normalize(value) {
    return (value || "")
      .toString()
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .trim();
  }

  /**
   * Obtiene el valor de un elemento que se usará para filtrar.
   *
   * @param {Element} item Elemento marcado con data-filter-item.
   * @param {string|null} field Nombre del campo data-* a consultar.
   * @returns {string} Valor filtrable del atributo data-* o del texto visible.
   */
  function valueFor(item, field) {
    if (!field) {
      return item.textContent || "";
    }

    var dataValue = item.getAttribute("data-" + field);
    return dataValue !== null ? dataValue : item.textContent || "";
  }

  /**
   * Comprueba si un elemento cumple el filtro definido por un control.
   *
   * @param {Element} item Elemento del listado que puede mostrarse u ocultarse.
   * @param {HTMLInputElement|HTMLSelectElement} control Control con data-filter-control.
   * @returns {boolean} true si el elemento debe mantenerse visible.
   */
  function matchesControl(item, control) {
    var rawValue = control.value || "";
    if (!rawValue) {
      return true;
    }

    var type = control.getAttribute("data-filter-type") || "text";
    var field = control.getAttribute("data-filter-field");
    var itemValue = valueFor(item, field);

    if (type === "exact") {
      return normalize(itemValue) === normalize(rawValue);
    }

    if (type === "date-min") {
      return itemValue && itemValue >= rawValue;
    }

    if (type === "date-max") {
      return itemValue && itemValue <= rawValue;
    }

    return normalize(itemValue).indexOf(normalize(rawValue)) !== -1;
  }

  /**
   * Aplica todos los controles de una zona filtrable.
   *
   * @param {Element} scope Contenedor marcado con data-filter-scope.
   * @returns {void}
   */
  function applyScope(scope) {
    var controls = Array.prototype.slice.call(
      scope.querySelectorAll("[data-filter-control]")
    );
    var items = Array.prototype.slice.call(
      scope.querySelectorAll("[data-filter-item]")
    );
    var empty = scope.querySelector("[data-filter-empty]");
    var count = scope.querySelector("[data-filter-count]");
    var visible = 0;

    items.forEach(function (item) {
      var show = controls.every(function (control) {
        return matchesControl(item, control);
      });

      item.classList.toggle("is-hidden-by-filter", !show);
      if (show) {
        visible += 1;
      }
    });

    if (empty) {
      empty.hidden = visible !== 0;
    }

    if (count) {
      count.textContent = visible + " de " + items.length;
    }
  }

  /**
   * Reinicia los controles de una zona y vuelve a mostrar sus resultados.
   *
   * @param {Element} scope Contenedor marcado con data-filter-scope.
   * @returns {void}
   */
  function resetScope(scope) {
    scope.querySelectorAll("[data-filter-control]").forEach(function (control) {
      control.value = "";
    });
    applyScope(scope);
  }

  /**
   * Inicializa eventos de búsqueda, cambio y limpieza para una zona filtrable.
   *
   * @param {Element} scope Contenedor marcado con data-filter-scope.
   * @returns {void}
   */
  function initScope(scope) {
    scope.querySelectorAll("[data-filter-control]").forEach(function (control) {
      control.addEventListener("input", function () {
        applyScope(scope);
      });
      control.addEventListener("change", function () {
        applyScope(scope);
      });
    });

    scope.querySelectorAll("[data-filter-reset]").forEach(function (button) {
      button.addEventListener("click", function () {
        resetScope(scope);
      });
    });

    applyScope(scope);
  }

  /**
   * Punto de entrada del módulo: activa todos los filtros declarativos al cargar.
   */
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("[data-filter-scope]").forEach(initScope);
  });
})();
