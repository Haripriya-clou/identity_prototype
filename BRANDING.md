# 🏢 Identity Prototype - Branding Guidelines

## Brand Identity

### Brand Name
**Identity Prototype** - Digital Identity Verification System

### Brand Tagline
"Secure. Fast. Reliable."

---

## Logo

### Design Concept
- **Shield Symbol**: Represents security and protection
- **Checkmark**: Represents verification and trust
- **Gradient Colors**: Modern and trustworthy feel

### Logo Colors
- **Primary**: Indigo (#6366F1) - Trust & Security
- **Secondary**: Purple (#8B5CF6) - Innovation & Modern
- **Accent**: Emerald Green (#10B981) - Verification & Success

### Usage
- Place logo on app headers
- Use as app icon on home screen (192x192px)
- Scale: Never smaller than 48x48px
- Spacing: Clear space around logo (1/4 of logo width)

### Files
- Logo SVG: `assets/app_icon.svg`
- Icon Sizes: Generated in all required Android and iOS formats
  - Android: 48x48, 72x72, 96x96, 144x144, 192x192
  - iOS: 20x20, 40x40, 60x60, 29x29, 58x58, 87x87, 76x76, 152x152, 167x167, 1024x1024

---

## Color Palette

### Primary Colors
| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Indigo | #6366F1 | 99, 102, 241 | Primary actions, buttons, headers |
| Purple | #8B5CF6 | 139, 92, 246 | Gradients, accents |
| Emerald | #10B981 | 16, 185, 129 | Success, verification, positive actions |

### Secondary Colors
| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Amber | #F59E0B | 245, 158, 11 | Warnings, alerts |
| Red | #EF4444 | 239, 68, 68 | Errors, dangerous actions |

### Neutral Colors
| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| White | #FFFFFF | 255, 255, 255 | Backgrounds, surfaces |
| Light Gray | #FAFAFA | 250, 250, 250 | Page backgrounds |
| Gray | #6B7280 | 107, 178, 128 | Secondary text |
| Dark Gray | #111827 | 17, 24, 39 | Primary text |

---

## Typography

### Fonts
- **Poppins** - Headings, bold text (Modern & Geometric)
- **Inter** - Body text, paragraphs (Clean & Readable)

### Font Sizes

#### Display & Headlines
- Display Large: 32px, Bold
- Display Medium: 28px, Bold
- Headline Large: 24px, Semi-bold (Screen titles)
- Headline Medium: 20px, Semi-bold

#### Body Text
- Body Large: 16px, Medium (Main content)
- Body Medium: 14px, Medium (Secondary content)
- Body Small: 12px, Regular (Helper text)

#### Labels & Buttons
- Label Large: 14px, Semi-bold (Button text)
- Label Medium: 12px, Semi-bold (Tags, badges)

### Line Height
- Headlines: 1.2x
- Body: 1.5x
- Labels: 1x

---

## UI Components

### Buttons

#### Filled Button (Primary)
- Background: Indigo (#6366F1)
- Text: White
- Padding: 12px vertical × 24px horizontal
- Border Radius: 12px
- Font: Poppins, 16px, Semi-bold

#### Outlined Button (Secondary)
- Border: 2px Indigo
- Text: Indigo
- Padding: 12px vertical × 24px horizontal
- Border Radius: 12px
- Background: Transparent

#### Text Button
- Text: Indigo
- No background or border
- 16px, Semi-bold

### Cards
- Background: White
- Border Radius: 16px
- Shadow: Soft shadow with opacity 0.1
- Padding: 16-20px
- Border: Optional thin border (1px Gray)

### Input Fields
- Background: Light Gray
- Border: 1px Gray, no fill
- Border Radius: 12px
- Padding: 14px horizontal × 12px vertical
- Focus State: 2px Indigo border

### Badges
- Border Radius: 20px
- Padding: 6px horizontal × 12px vertical
- Font: 12px, Semi-bold
- Background: Color with 20% opacity
- Border: Color with 40% opacity

---

## Icons

### Icon Library
- **Material Icons**: Primary icon set
- **Font Awesome**: For extended options
- **Size**: 24px (standard), 32px (large), 18px (small)

### Icon Color Guidelines
- Primary Actions: Indigo
- Success/Positive: Emerald
- Warnings: Amber
- Errors: Red
- Neutral: Gray

### Commonly Used Icons
- User/Profile: `person`, `account_circle`
- Verification: `verified_user`, `verified`
- QR Code: `qr_code`, `qr_code_scanner`
- Settings: `settings`, `tune`
- Logout: `logout`, `exit_to_app`
- Edit: `edit`, `mode_edit`
- Delete: `delete`, `delete_outline`
- Add: `add`, `add_circle`

---

## Spacing System

### Base Unit: 4px
- 4px (xs)
- 8px (sm)
- 12px (md)
- 16px (lg) - **Most common**
- 20px (xl)
- 24px (2xl)
- 32px (3xl)

### Application
- Padding inside cards: 16-20px
- Margin between cards: 16px
- Padding in AppBar: 16px (horizontal)
- Button internal padding: 12px (vertical) × 24px (horizontal)

---

## Shadows & Depth

### Shadow Levels
```
Light Shadow:
  color: rgba(0, 0, 0, 0.05)
  offset: 0, 4
  blur: 8

Medium Shadow:
  color: rgba(0, 0, 0, 0.1)
  offset: 0, 8
  blur: 12

Heavy Shadow:
  color: rgba(99, 102, 241, 0.3)
  offset: 0, 8
  blur: 16
```

---

## Gradients

### Primary Gradient (Left-Top to Right-Bottom)
```
Start: #6366F1 (Indigo)
End: #8B5CF6 (Purple)
```
Usage: Main cards, headers, CTAs

### Success Gradient (Left-Top to Right-Bottom)
```
Start: #10B981 (Emerald)
End: #059669 (Emerald Dark)
```
Usage: Success states, confirmations

### Sunset Gradient (Left-Top to Right-Bottom)
```
Start: #F97316 (Orange)
End: #EC4899 (Pink)
```
Usage: Featured actions, special highlights

---

## Animation Guidelines

### Duration
- Quick interactions: 200ms
- Standard transitions: 300ms
- Longer sequences: 500ms+

### Easing Curves
- `easeInOut` - Default smooth transitions
- `easeOut` - Exit animations
- `easeIn` - Entry animations

### Common Animations
- Button tap: Slight scale (0.95x)
- Card hover: Slight shadow increase
- Page transition: Slide from right
- Loading: 360° rotation

---

## Responsive Design

### Breakpoints
- Mobile: < 600px
- Tablet: 600px - 992px
- Desktop: > 992px

### Padding Adjustments
- Mobile: 12-16px
- Tablet: 16-20px
- Desktop: 24-32px

### Touch Targets
- Minimum size: 48x48px
- Recommended size: 56-64px
- Spacing: 8px minimum between targets

---

## Accessibility

### Color Contrast
- Normal text: Minimum 4.5:1 ratio
- Large text: Minimum 3:1 ratio
- WCAG AA compliant

### Text Alternatives
- All icons have labels or tooltips
- Images have descriptive alt-text
- Form fields have clear labels

### Focus States
- Clear visual focus indicator
- 2px border or outline
- Color: Primary or secondary

### Motion Sensitivity
- No auto-playing animations
- Disable animations for reduced-motion users
- Provide alternative interactions

---

## Sound Design

### Notification Sounds
- Success: Positive chime
- Error: Alert tone
- Warning: Medium tone

### File Location:
`assets/sounds/`

---

## Dark Mode (Future)

### Planned Dark Colors
- Background: #0F172A
- Surface: #1E3A8A
- Text: #F3F4F6
- Text Secondary: #D1D5DB

---

## Implementation Checklist

- [ ] Update app icon in Android launcher
- [ ] Update app icon in iOS launcher  
- [ ] Set app name in native configs
- [ ] Configure splash screen with brand colors
- [ ] Add brand colors to theme
- [ ] Implement all custom components
- [ ] Apply typography to all screens
- [ ] Test on multiple device sizes
- [ ] Verify accessibility standards
- [ ] Get design approval

---

*Branding Guidelines v1.0*  
*Last Updated: April 8, 2026*
