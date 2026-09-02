import html
import re
import sys
from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER, TA_LEFT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import cm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import (
    BaseDocTemplate,
    Frame,
    PageBreak,
    PageTemplate,
    Paragraph,
    Preformatted,
    Spacer,
    Table,
    TableStyle,
)


ROOT = Path(__file__).resolve().parents[1]
INPUT = ROOT / "docs" / "memoria_tfg_extendida.md"
OUTPUT = ROOT / "output" / "pdf" / "memoria_tfg_extendida.pdf"


def register_fonts():
    font_dir = Path("C:/Windows/Fonts")
    regular = font_dir / "arial.ttf"
    bold = font_dir / "arialbd.ttf"
    italic = font_dir / "ariali.ttf"
    bold_italic = font_dir / "arialbi.ttf"
    if regular.exists() and bold.exists():
        pdfmetrics.registerFont(TTFont("DocSans", str(regular)))
        pdfmetrics.registerFont(TTFont("DocSans-Bold", str(bold)))
        if italic.exists():
            pdfmetrics.registerFont(TTFont("DocSans-Italic", str(italic)))
        if bold_italic.exists():
            pdfmetrics.registerFont(TTFont("DocSans-BoldItalic", str(bold_italic)))
        return "DocSans", "DocSans-Bold"
    return "Helvetica", "Helvetica-Bold"


FONT, FONT_BOLD = register_fonts()


def clean_inline(text):
    text = html.escape(text.strip())
    text = re.sub(r"`([^`]+)`", r"<font name='Courier'>\1</font>", text)
    text = re.sub(r"\*\*([^*]+)\*\*", rf"<b>\1</b>", text)
    text = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", r"\1 (\2)", text)
    return text


def make_styles():
    base = getSampleStyleSheet()
    return {
        "title": ParagraphStyle(
            "title",
            parent=base["Title"],
            fontName=FONT_BOLD,
            fontSize=24,
            leading=30,
            alignment=TA_CENTER,
            textColor=colors.HexColor("#061a3a"),
            spaceAfter=24,
        ),
        "subtitle": ParagraphStyle(
            "subtitle",
            parent=base["Normal"],
            fontName=FONT,
            fontSize=12,
            leading=18,
            alignment=TA_CENTER,
            textColor=colors.HexColor("#334155"),
            spaceAfter=10,
        ),
        "h1": ParagraphStyle(
            "h1",
            parent=base["Heading1"],
            fontName=FONT_BOLD,
            fontSize=18,
            leading=23,
            textColor=colors.HexColor("#061a3a"),
            spaceBefore=16,
            spaceAfter=9,
        ),
        "h2": ParagraphStyle(
            "h2",
            parent=base["Heading2"],
            fontName=FONT_BOLD,
            fontSize=14,
            leading=18,
            textColor=colors.HexColor("#123d8f"),
            spaceBefore=12,
            spaceAfter=7,
        ),
        "h3": ParagraphStyle(
            "h3",
            parent=base["Heading3"],
            fontName=FONT_BOLD,
            fontSize=12,
            leading=15,
            textColor=colors.HexColor("#0f172a"),
            spaceBefore=8,
            spaceAfter=5,
        ),
        "body": ParagraphStyle(
            "body",
            parent=base["BodyText"],
            fontName=FONT,
            fontSize=10,
            leading=14,
            alignment=TA_LEFT,
            textColor=colors.HexColor("#111827"),
            spaceAfter=6,
        ),
        "bullet": ParagraphStyle(
            "bullet",
            parent=base["BodyText"],
            fontName=FONT,
            fontSize=10,
            leading=14,
            leftIndent=14,
            firstLineIndent=-8,
            spaceAfter=4,
        ),
        "code": ParagraphStyle(
            "code",
            parent=base["Code"],
            fontName="Courier",
            fontSize=7.4,
            leading=9.2,
            textColor=colors.HexColor("#111827"),
        ),
        "small": ParagraphStyle(
            "small",
            parent=base["BodyText"],
            fontName=FONT,
            fontSize=8,
            leading=10,
            textColor=colors.HexColor("#111827"),
        ),
    }


STYLES = make_styles()


def parse_table(lines, start):
    rows = []
    i = start
    while i < len(lines) and lines[i].strip().startswith("|"):
        raw = lines[i].strip().strip("|")
        cells = [clean_inline(cell) for cell in raw.split("|")]
        if not all(re.fullmatch(r"\s*:?-{3,}:?\s*", cell) for cell in raw.split("|")):
            rows.append(cells)
        i += 1
    return rows, i


def table_flowable(rows):
    if not rows:
        return []
    max_cols = max(len(row) for row in rows)
    normalized = [row + [""] * (max_cols - len(row)) for row in rows]
    data = [[Paragraph(cell, STYLES["small"]) for cell in row] for row in normalized]
    width = A4[0] - 4 * cm
    col_widths = [width / max_cols] * max_cols
    tbl = Table(data, colWidths=col_widths, repeatRows=1, hAlign="LEFT")
    tbl.setStyle(
        TableStyle(
            [
                ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#061a3a")),
                ("TEXTCOLOR", (0, 0), (-1, 0), colors.white),
                ("FONTNAME", (0, 0), (-1, 0), FONT_BOLD),
                ("FONTNAME", (0, 1), (-1, -1), FONT),
                ("GRID", (0, 0), (-1, -1), 0.35, colors.HexColor("#cbd5e1")),
                ("ROWBACKGROUNDS", (0, 1), (-1, -1), [colors.white, colors.HexColor("#f8fafc")]),
                ("VALIGN", (0, 0), (-1, -1), "TOP"),
                ("LEFTPADDING", (0, 0), (-1, -1), 5),
                ("RIGHTPADDING", (0, 0), (-1, -1), 5),
                ("TOPPADDING", (0, 0), (-1, -1), 4),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 4),
            ]
        )
    )
    return [tbl, Spacer(1, 8)]


def build_story(markdown):
    story = [
        Spacer(1, 2.8 * cm),
        Paragraph("Desarrollo de aplicación en Spring de datos simulados de NBA", STYLES["title"]),
        Paragraph("Memoria extendida de Trabajo Fin de Grado", STYLES["subtitle"]),
        Paragraph("Universidad de Sevilla", STYLES["subtitle"]),
        Paragraph("Autor: Eduardo Pizarro López", STYLES["subtitle"]),
        Paragraph("Documento generado a partir del borrador técnico del proyecto", STYLES["subtitle"]),
        PageBreak(),
    ]
    lines = markdown.splitlines()
    i = 0
    in_code = False
    code_buffer = []
    para_buffer = []

    def flush_para():
        if para_buffer:
            text = " ".join(part.strip() for part in para_buffer if part.strip())
            if text:
                story.append(Paragraph(clean_inline(text), STYLES["body"]))
            para_buffer.clear()

    def flush_code():
        if code_buffer:
            code = "\n".join(code_buffer).strip("\n")
            if code:
                story.append(Preformatted(code, STYLES["code"], maxLineLength=104))
                story.append(Spacer(1, 6))
            code_buffer.clear()

    while i < len(lines):
        line = lines[i]
        stripped = line.strip()

        if stripped.startswith("```"):
            if in_code:
                flush_code()
                in_code = False
            else:
                flush_para()
                in_code = True
            i += 1
            continue

        if in_code:
            code_buffer.append(line)
            i += 1
            continue

        if not stripped:
            flush_para()
            i += 1
            continue

        if stripped == "---":
            flush_para()
            story.append(Spacer(1, 10))
            i += 1
            continue

        if stripped.startswith("|"):
            flush_para()
            rows, i = parse_table(lines, i)
            story.extend(table_flowable(rows))
            continue

        heading = re.match(r"^(#{1,3})\s+(.+)$", stripped)
        if heading:
            flush_para()
            level = len(heading.group(1))
            text = clean_inline(heading.group(2))
            if level == 1:
                if story and not isinstance(story[-1], PageBreak):
                    story.append(PageBreak())
                story.append(Paragraph(text, STYLES["h1"]))
            elif level == 2:
                story.append(Paragraph(text, STYLES["h2"]))
            else:
                story.append(Paragraph(text, STYLES["h3"]))
            i += 1
            continue

        if re.match(r"^[-*]\s+", stripped):
            flush_para()
            text = re.sub(r"^[-*]\s+", "", stripped)
            story.append(Paragraph("• " + clean_inline(text), STYLES["bullet"]))
            i += 1
            continue

        numbered = re.match(r"^\d+\.\s+(.+)$", stripped)
        if numbered:
            flush_para()
            story.append(Paragraph(clean_inline(stripped), STYLES["bullet"]))
            i += 1
            continue

        para_buffer.append(line)
        i += 1

    flush_para()
    flush_code()
    return story


class NumberedDoc(BaseDocTemplate):
    pass


def header_footer(canvas, doc):
    canvas.saveState()
    width, height = A4
    canvas.setStrokeColor(colors.HexColor("#cbd5e1"))
    canvas.setLineWidth(0.5)
    canvas.line(2 * cm, height - 1.55 * cm, width - 2 * cm, height - 1.55 * cm)
    canvas.setFont(FONT, 8)
    canvas.setFillColor(colors.HexColor("#475569"))
    canvas.drawString(2 * cm, height - 1.25 * cm, "Memoria TFG - Aplicación NBA")
    canvas.drawRightString(width - 2 * cm, 1.25 * cm, f"Página {doc.page}")
    canvas.restoreState()


def main():
    if not INPUT.exists():
        raise SystemExit(f"No existe el fichero de entrada: {INPUT}")
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    markdown = INPUT.read_text(encoding="utf-8")
    doc = NumberedDoc(
        str(OUTPUT),
        pagesize=A4,
        rightMargin=2 * cm,
        leftMargin=2 * cm,
        topMargin=2.1 * cm,
        bottomMargin=2 * cm,
    )
    frame = Frame(doc.leftMargin, doc.bottomMargin, doc.width, doc.height, id="normal")
    doc.addPageTemplates([PageTemplate(id="main", frames=[frame], onPage=header_footer)])
    doc.build(build_story(markdown))
    print(OUTPUT)


if __name__ == "__main__":
    sys.exit(main())
