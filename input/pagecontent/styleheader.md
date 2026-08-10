<style>
.no-number {
    --heading-prefix: none;
}
.notification-table {
  width: 100%;
  overflow-x: auto;
  max-height: 600px;
  overflow-y: auto;
}

.notification-table th,
.notification-table td {
  padding: 10px;
  background: #f5f5f5; /* Cell color */
  box-shadow: 0 0 0 3px #fff;
  text-align: left;
}
.notification-table th {
  background: #e4e4e4;
}

.table-responsive {
display: block;
width: 100%;
overflow-x: auto;
max-height: 600px;
overflow-y: auto;
}
.table-responsive > table {
width: 100%;}
.table-responsive th,
.table-responsive td {
  padding: 15px;
  background: #f5f5f5;
}
.table-responsive table {
  border-collapse: separate;
  border-spacing: 3px;
}
/* Kopfzeile sticky */
.table-responsive th {
  position: sticky;
  top: 0;
  background: rgb(228, 228, 228);
  z-index: 2;
}
/* Erste Spalte sticky */
.table-responsive th:first-child,
.table-responsive td:first-child {
  position: sticky;
  left: 0;
  background: rgb(228, 228, 228);
  z-index: 3;
}

.table-responsive th:first-child {
  position: sticky;
  top: 0;
  left: 0;
  background: rgb(228, 228, 228);
  z-index: 4;
}

.hinweisbox {
  border: 1px solid #156082;
  background: #dae8f8;
  padding: 8px 12px;
  border-radius: 4px;
  margin: 8px 0;
}

.codebox {
  border: 1px solid #ccc;
  background: #f5f5f5;
  padding: 8px 12px;
  border-radius: 4px;
  margin: 8px 0;
  font-family: "Courier New", Courier, monospace;
  color: #2d2d2d;
}

.tabs {
  display: grid !important;
  grid-template-columns: repeat(auto-fit, minmax(90px, max-content));
  align-items: end;
  position: relative;

  width: 100%;
  min-height: 0;
  max-height: none;
  margin: 35px 0 25px;
  background: #ffffff;
}

/* Let label and content participate directly in the grid */
.tab {
  display: contents;
}

.tab input[id^="tab-"] {
  display: none;
}

.tab label {
  background: #eeeeee;
  padding: 10px;
  border: 1px solid #cccccc;
  margin-bottom: -1px;
  position: relative;
  left: 0;
  top: 0;
  cursor: pointer;
  grid-row: 1;
}

/* Hidden tabs must not take up space */
.content-in-tab {
  display: none;
  grid-column: 1 / -1;
  grid-row: 2;
  width: 100%;
  box-sizing: border-box;
  background: #ffffff;
  padding: 20px;
  border: 1px solid #cccccc;
  /* Maximum visible panel height */
  max-height: 700px;
  overflow: auto;
}

/* Only the active tab panel is displayed and determines height */
[type="radio"]:checked ~ label {
  background: #ffffff;
  border-bottom-color: #ffffff;
  z-index: 2;
}

[type="radio"]:checked ~ .content-in-tab {
  display: block;
}

.request-code {
  font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, monospace;
  background: #ffffff;
  padding: 1rem;
  border-radius: 4px;
  margin-bottom: 0.8rem;
  font-size: 0.95em;
  line-height: 1.5;
  overflow-x: auto;
}

.tabs:has(input[id^="tab-request-"]:checked) {
  min-height: 140px;
}

.content-in-tab:has(.request-panel) {
  padding: 8px 12px;
}

.content-in-tab:has(pre) {
  padding: 10px;
  overflow: auto;  
  max-height: calc(100vh - 120px); 
}

</style>