
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

/* Tabellencontainer mit horizontalem und vertikalem Scrollen */
.table-responsive {
  display: block;
  width: 100%;
  max-height: 600px;
  overflow-x: auto;
  overflow-y: auto;
  box-sizing: border-box;
}

.table-responsive > table {
  width: 100%;
  margin-bottom: 0;
  border: 1px solid #e8eef0;
  border-collapse: separate;
  border-spacing: 0;
  border-radius: 4px;
}

/* Tabellenzellen */
.table-responsive th,
.table-responsive td {
  padding: 15px;
  color: #202c33;
  background: #ffffff;
  text-align: left;
}

/* Sticky Tabellenkopf */
.table-responsive thead th {
  position: sticky;
  top: 0;
  z-index: 10;
  background: #cbd6d9;
  color: #102d46;
}

/* Erste Spalte horizontal fixieren */
.table-responsive th:first-child,
.table-responsive td:first-child {
  position: sticky;
  left: 0;
  z-index: 3;
}

/* Linke obere Ecke über allen anderen Sticky-Zellen */
.table-responsive thead th:first-child {
  position: sticky;
  top: 0;
  left: 0;
  z-index: 20;
  background: #cbd6d9;
  color: #102d46;
}

/* Alternierende Zeilenfarben */
.table-responsive tbody tr:nth-child(odd) td {
  background: #ffffff;
}

.table-responsive tbody tr:nth-child(even) td {
  background: #e9edef;
}

/* Erste Spalte passend zur jeweiligen Zeilenfarbe */
.table-responsive tbody tr:nth-child(odd) td:first-child {
  background: #ffffff;
}

.table-responsive tbody tr:nth-child(even) td:first-child {
  background: #e9edef;
}

/* Use-Case-Zellen wie Überschriften formatieren */
.table-responsive table tbody td.use-case-heading {
  background: #e8eef0 !important;
  color: #294b56;
  font-weight: bold;
}

/* Hinweisbox */
.hinweisbox {
  font-size: 12px;
  border: 1px solid #246783;
  background: #e0e7e9;
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
  grid-template-columns: repeat(auto-fit, minmax(100px, max-content));
  align-items: end;
  position: relative;
  width: 100%;
  min-height: 0;
  max-height: none;
  margin: 5px 0 5px;
  background: #ffffff;
  overflow-x: auto;
}

.tabs .tab label {
  white-space: nowrap;
  box-sizing: border-box;
  line-height: 1.2;
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

.tabs .tab label {
  font-size: 11px;
  padding: 4px 8px;
}

/* Hidden tabs must not take up space */
.content-in-tab {
  display: none;
  grid-column: 1 / -1;
  grid-row: 2;
  width: 100%;
  box-sizing: border-box;
  background: #ffffff;
  padding: 8px 8px;  /*10px;*/
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

.request-panel {
  background: #f8f9fa;
  padding: 1.2rem;
  margin: 0.5rem 0;
  border-radius: 0 4px 4px 0;
  border-left: 4px solid #007bff;
}

.request-panel--success {
  border-left-color: #28a745;
}

.request-meta {
  font-size: 0.9em;
  color: #666666;
  margin-top: 0.5rem;
}

.request-code {
  font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, monospace;
  background: #ffffff;
  padding: 1rem;
  border-radius: 4px;
  margin-bottom: 0.8rem;
  font-size: 0.8em;
  line-height: 1;
  overflow-x: auto;
}

.request-method-post {
  color: #d63384;
  font-weight: bold;
}

.request-method-get {
  color: #007bff;
  font-weight: bold;
}

.request-url {
  background: #e7f3ff;
  padding: 0.2em 0.4em;
  border-radius: 3px;
  color: #0066cc;
}

.request-header {
  background: #f1f3f4;
  padding: 0.1em 0.3em;
  border-radius: 2px;
}

.tabs:has(input[id^="tab-request-"]:checked) {
  min-height: 140px;
}

.content-in-tab:has(.request-panel) {
  padding: 10px;
}

.content-in-tab:has(pre) {
  padding: 10px;
  overflow: auto;  
  max-height: calc(100vh - 120px); 
}

/* .tab label.request-tab {
  --tab-height: 120px;
} */

.tabs:has(input[id^="tab-body-"]:checked) {
  min-height: 520px;
}


.tab label.body-tab {
  --tab-height: 500px; 
}

/* Abstand zwischen Überschriften und Tabs verleinern */
h4 + .tabs {  
  margin-top: 5px;
}


</style>