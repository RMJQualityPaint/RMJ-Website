// ============================================================
// RMJ Quality Painting — Google Apps Script
// Pega este código en: script.google.com → Nuevo proyecto
// ============================================================

const SHEET_NAME = 'Leads';

function doPost(e) {
  try {
    const sheet = getOrCreateSheet();
    const data = e.parameter;

    sheet.appendRow([
      new Date().toLocaleString('en-US', { timeZone: 'America/New_York' }),
      data.name    || '',
      data.phone   || '',
      data.email   || '',
      data.service || '',
      data.message || ''
    ]);

    return ContentService
      .createTextOutput(JSON.stringify({ status: 'success' }))
      .setMimeType(ContentService.MimeType.JSON);

  } catch (err) {
    return ContentService
      .createTextOutput(JSON.stringify({ status: 'error', message: err.toString() }))
      .setMimeType(ContentService.MimeType.JSON);
  }
}

function getOrCreateSheet() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  let sheet = ss.getSheetByName(SHEET_NAME);

  if (!sheet) {
    sheet = ss.insertSheet(SHEET_NAME);
  }

  if (sheet.getLastRow() === 0) {
    sheet.appendRow(['Fecha', 'Nombre', 'Teléfono', 'Email', 'Servicio', 'Mensaje']);
    sheet.getRange(1, 1, 1, 6).setFontWeight('bold').setBackground('#C41E3A').setFontColor('#FFFFFF');
    sheet.setFrozenRows(1);
    sheet.setColumnWidth(1, 160);
    sheet.setColumnWidth(6, 300);
  }

  return sheet;
}
