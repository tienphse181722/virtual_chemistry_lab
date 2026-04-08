#!/usr/bin/env python3
"""
Convert ChemLearn Markdown reports to HTML with KHANH LINH.docx formatting
"""

import re

def read_file(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        return f.read()

def convert_markdown_to_html(md_content):
    """Convert markdown to HTML with proper formatting"""
    html = md_content
    
    # Convert headers
    html = re.sub(r'^# (.+)$', r'<h1>\1</h1>', html, flags=re.MULTILINE)
    html = re.sub(r'^## (.+)$', r'<h2>\1</h2>', html, flags=re.MULTILINE)
    html = re.sub(r'^### (.+)$', r'<h3>\1</h3>', html, flags=re.MULTILINE)
    html = re.sub(r'^#### (.+)$', r'<h4>\1</h4>', html, flags=re.MULTILINE)
    
    # Convert bold
    html = re.sub(r'\*\*(.+?)\*\*', r'<strong>\1</strong>', html)
    
    # Convert italic
    html = re.sub(r'\*(.+?)\*', r'<em>\1</em>', html)
    
    # Convert code blocks
    html = re.sub(r'```(\w+)?\n(.*?)```', r'<pre><code>\2</code></pre>', html, flags=re.DOTALL)
    
    # Convert inline code
    html = re.sub(r'`([^`]+)`', r'<code>\1</code>', html)
    
    # Convert tables
    lines = html.split('\n')
    in_table = False
    new_lines = []
    
    for i, line in enumerate(lines):
        if '|' in line and not in_table:
            in_table = True
            new_lines.append('<table>')
            # Header row
            cells = [c.strip() for c in line.split('|')[1:-1]]
            new_lines.append('<tr>')
            for cell in cells:
                new_lines.append(f'<th>{cell}</th>')
            new_lines.append('</tr>')
        elif '|' in line and in_table:
            # Check if it's separator line
            if re.match(r'\|[\s\-:]+\|', line):
                continue
            # Data row
            cells = [c.strip() for c in line.split('|')[1:-1]]
            new_lines.append('<tr>')
            for cell in cells:
                new_lines.append(f'<td>{cell}</td>')
            new_lines.append('</tr>')
        elif in_table and '|' not in line:
            in_table = False
            new_lines.append('</table>')
            new_lines.append(line)
        else:
            new_lines.append(line)
    
    html = '\n'.join(new_lines)
    
    # Convert paragraphs
    paragraphs = html.split('\n\n')
    formatted_paragraphs = []
    
    for para in paragraphs:
        para = para.strip()
        if para and not para.startswith('<') and not para.startswith('|'):
            formatted_paragraphs.append(f'<p>{para}</p>')
        else:
            formatted_paragraphs.append(para)
    
    return '\n\n'.join(formatted_paragraphs)

# Read markdown files
print("Reading markdown files...")
complete_md = read_file('ChemLearn_Report_Complete.md')
remaining_md = read_file('ChemLearn_Report_Remaining.md')

# Combine content
full_content = complete_md + '\n\n' + remaining_md

# Convert to HTML
print("Converting to HTML...")
html_content = convert_markdown_to_html(full_content)

# Create full HTML document
html_template = f'''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ChemLearn - Final Year Project Report</title>
    <style>
        @page {{
            size: A4;
            margin: 2.5cm 2cm 2cm 2.5cm;
        }}
        
        body {{
            font-family: 'Times New Roman', Times, serif;
            font-size: 12pt;
            line-height: 1.5;
            color: #000;
            background: #fff;
            max-width: 21cm;
            margin: 0 auto;
            padding: 2.5cm 2cm 2cm 2.5cm;
        }}
        
        h1 {{
            font-size: 14pt;
            font-weight: bold;
            text-align: center;
            margin: 1cm 0 0.5cm 0;
            text-transform: uppercase;
            page-break-after: avoid;
        }}
        
        h2 {{
            font-size: 13pt;
            font-weight: bold;
            margin: 0.8cm 0 0.4cm 0;
            page-break-after: avoid;
        }}
        
        h3 {{
            font-size: 12pt;
            font-weight: bold;
            margin: 0.6cm 0 0.3cm 0;
            page-break-after: avoid;
        }}
        
        h4 {{
            font-size: 12pt;
            font-weight: bold;
            font-style: italic;
            margin: 0.4cm 0 0.2cm 0;
        }}
        
        p {{
            text-align: justify;
            margin-bottom: 0.5cm;
            text-indent: 1cm;
        }}
        
        table {{
            width: 100%;
            border-collapse: collapse;
            margin: 0.5cm 0 1cm 0;
            font-size: 11pt;
        }}
        
        th, td {{
            border: 1px solid #000;
            padding: 0.3cm;
            text-align: left;
        }}
        
        th {{
            background-color: #f0f0f0;
            font-weight: bold;
        }}
        
        pre {{
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            padding: 0.5cm;
            overflow-x: auto;
            font-family: 'Courier New', monospace;
            font-size: 10pt;
            line-height: 1.4;
            margin: 0.5cm 0;
        }}
        
        code {{
            font-family: 'Courier New', monospace;
            background-color: #f5f5f5;
            padding: 0.1cm 0.2cm;
            font-size: 10pt;
        }}
        
        ul, ol {{
            margin-left: 1.5cm;
            margin-bottom: 0.5cm;
        }}
        
        li {{
            margin-bottom: 0.2cm;
        }}
        
        strong {{
            font-weight: bold;
        }}
        
        em {{
            font-style: italic;
        }}
        
        @media print {{
            body {{
                margin: 0;
                padding: 0;
            }}
            
            h1, h2, h3 {{
                page-break-after: avoid;
            }}
            
            table, pre {{
                page-break-inside: avoid;
            }}
        }}
    </style>
</head>
<body>

{html_content}

</body>
</html>'''

# Write output
print("Writing HTML file...")
with open('ChemLearn_Complete_Report.html', 'w', encoding='utf-8') as f:
    f.write(html_template)

print("✅ Done! File created: ChemLearn_Complete_Report.html")
print("📝 Open this file in your browser, then copy all content (Ctrl+A, Ctrl+C)")
print("📄 Paste into Microsoft Word to preserve formatting")
