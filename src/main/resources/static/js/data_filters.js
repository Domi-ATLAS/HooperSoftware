(function () {
  function normalize(value) {
    return (value || "")
      .toString()
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .trim();
  }

  function valueFor(item, field) {
    if (!field) {
      return item.textContent || "";
    }

    var dataValue = item.getAttribute("data-" + field);
    return dataValue !== null ? dataValue : item.textContent || "";
  }

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

  function resetScope(scope) {
    scope.querySelectorAll("[data-filter-control]").forEach(function (control) {
      control.value = "";
    });
    applyScope(scope);
  }

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

  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("[data-filter-scope]").forEach(initScope);
  });
})();
