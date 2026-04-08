from pathlib import Path
root = Path(r'd:\identity_prototype')
for path in root.rglob('*.dart'):
    text = path.read_text(encoding='utf-8')
    new = text.replace('GoogleFonts.poppins(', "TextStyle(fontFamily: 'Roboto', ")
    new = new.replace('GoogleFonts.inter(', "TextStyle(fontFamily: 'Roboto', ")
    if new != text:
        path.write_text(new, encoding='utf-8')
        print(f'Updated {path}')
