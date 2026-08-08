
from openpyxl import Workbook


def export_report_to_excel(
    report_title,
    academic_year,
    headers,
    rows,
    totals
):
    """
    Generic Excel Export Function
    This function will be used by all reports.
    """

from openpyxl import Workbook

from openpyxl.styles import (
        Font,
        PatternFill,
        Border,
        Side,
        Alignment
    )

from openpyxl.utils import get_column_letter


# ===========================================================
# Common Excel Styles
# ===========================================================

HEADER_FILL = PatternFill(
    fill_type="solid",
    start_color="1F4E78",
    end_color="1F4E78"
    )

COLUMN_FILL = PatternFill(
    fill_type="solid",
    start_color="4472C4",
    end_color="4472C4"
    )

WHITE_FONT = Font(
    bold=True,
    color="FFFFFF"
    )

TITLE_FONT = Font(
    bold=True,
    size=16
    )

SUBTITLE_FONT = Font(
    bold=True,
    size=12
    )

THIN_BORDER = Border(

    left=Side(style="thin"),

    right=Side(style="thin"),

    top=Side(style="thin"),

    bottom=Side(style="thin")

    )

CENTER_ALIGN = Alignment(
    horizontal="center",
    vertical="center"
    )

RIGHT_ALIGN = Alignment(
    horizontal="right"
    )

LEFT_ALIGN = Alignment(
    horizontal="left"
    )


def export_report_to_excel(
    report_title,
    academic_year,
    headers,
    rows,
    totals
):

    wb = Workbook()

    ws = wb.active

    ws.title = "Report"

    # -------------------------------------------------
# Report Header
# -------------------------------------------------

    ws.merge_cells("A1:F1")
    ws.merge_cells("A2:F2")
    ws.merge_cells("A4:F4")
    ws.merge_cells("A5:F5")

    ws["A1"] = "EKALAVYA FOUNDATION"
    ws["A2"] = "Ekalavya Education Management System"

    ws["A4"] = report_title
    ws["A5"] = f"Academic Year : {academic_year}"

    for cell in ["A1", "A2", "A4", "A5"]:

        ws[cell].fill = HEADER_FILL

        ws[cell].font = WHITE_FONT

        ws[cell].alignment = CENTER_ALIGN

    # -------------------------------------------------
    # Column Headings
    # -------------------------------------------------

    row_no = 7

    for col, header in enumerate(headers, start=1):

        cell = ws.cell(
        row=row_no,
        column=col,
        value=header
        )

    cell.font = WHITE_FONT

    cell.fill = COLUMN_FILL

    cell.border = THIN_BORDER

    cell.alignment = CENTER_ALIGN
    # -------------------------------------------------
    # Data
    # -------------------------------------------------

    row_no += 1

    for record in rows:

        for col, value in enumerate(record.values(), start=1):

            ws.cell(
                row=row_no,
                column=col,
                value=value
            )

        row_no += 1

    # -------------------------------------------------
    # Totals
    # -------------------------------------------------

    row_no += 2

    ws.cell(row=row_no, column=1).value = "Report Summary"

    ws.cell(row=row_no + 1, column=1).value = totals

    # ---------------------------------------------------------
# Auto-fit Column Widths
# ---------------------------------------------------------

    for column_cells in ws.columns:

        length = 0
        column = get_column_letter(column_cells[0].column)

    for cell in column_cells:

        try:
            if cell.value:
                length = max(length, len(str(cell.value)))
        except:
            pass

    ws.column_dimensions[column].width = length + 3

    return wb