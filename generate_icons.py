#!/usr/bin/env python3
"""
Icon Generation Script
Generates app icons in all required sizes for Flutter
Run: python generate_icons.py
"""

from PIL import Image, ImageDraw
import os

def create_icon(size: int, filename: str):
    """Create a beautiful app icon with gradient background"""
    
    # Create image with gradient background
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Draw gradient (indigo to purple)
    for y in range(size):
        # Gradient from #6366F1 (indigo) to #8B5CF6 (purple)
        r = int(99 + (139 - 99) * y / size)
        g = int(102 + (92 - 102) * y / size)
        b = int(241 + (246 - 241) * y / size)
        draw.rectangle(
            [(0, y), (size, y + 1)],
            fill=(r, g, b, 255)
        )
    
    # Draw main circle (white semi-transparent)
    margin = int(size * 0.15)
    draw.ellipse(
        [(margin, margin), (size - margin, size - margin)],
        outline=(255, 255, 255, 80),
        width=int(size * 0.04)
    )
    
    # Draw shield shape
    shield_margin = int(size * 0.25)
    shield_top = int(size * 0.2)
    shield_bottom = int(size * 0.75)
    shield_width = size - 2 * shield_margin
    
    # Shield path (simplified)
    shield_points = [
        (size // 2, shield_top),  # top
        (size - shield_margin, shield_top + shield_width // 3),  # top right
        (size - shield_margin, shield_bottom - shield_width // 4),  # bottom right
        (size // 2, shield_bottom),  # bottom
        (shield_margin, shield_bottom - shield_width // 4),  # bottom left
        (shield_margin, shield_top + shield_width // 3),  # top left
    ]
    draw.polygon(shield_points, outline=(255, 255, 255, 200), width=int(size * 0.03))
    
    # Draw checkmark (security symbol)
    check_center_x = size // 2
    check_center_y = int(size * 0.62)
    check_radius = int(size * 0.18)
    
    # Checkmark circle background
    draw.ellipse(
        [(check_center_x - check_radius, check_center_y - check_radius),
         (check_center_x + check_radius, check_center_y + check_radius)],
        fill=(16, 185, 129, 80)
    )
    
    # Draw checkmark
    check_x1 = int(check_center_x - check_radius * 0.4)
    check_y1 = int(check_center_y - check_radius * 0.1)
    check_x2 = int(check_center_x - check_radius * 0.05)
    check_y2 = int(check_center_y + check_radius * 0.35)
    check_x3 = int(check_center_x + check_radius * 0.5)
    check_y3 = int(check_center_y - check_radius * 0.3)
    
    # Draw checkmark lines
    line_width = int(size * 0.05)
    draw.line([(check_x1, check_y1), (check_x2, check_y2)], 
              fill=(255, 255, 255, 255), width=line_width)
    draw.line([(check_x2, check_y2), (check_x3, check_y3)], 
              fill=(255, 255, 255, 255), width=line_width)
    
    # Save the image
    img.save(filename, 'PNG')
    print(f"✅ Created {filename} ({size}x{size})")


def main():
    # Android icon sizes
    android_sizes = {
        'android/app/src/main/res/mipmap-mdpi/ic_launcher.png': 48,
        'android/app/src/main/res/mipmap-hdpi/ic_launcher.png': 72,
        'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png': 96,
        'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png': 144,
        'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png': 192,
    }
    
    # iOS icon sizes
    ios_sizes = {
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png': 20,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png': 40,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png': 60,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png': 29,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png': 58,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png': 87,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png': 40,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png': 80,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png': 120,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png': 120,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png': 180,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png': 76,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png': 152,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png': 167,
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png': 1024,
    }
    
    all_sizes = {**android_sizes, **ios_sizes}
    
    print("🎨 Generating app icons...\n")
    
    for filepath, size in all_sizes.items():
        # Create directory if it doesn't exist
        directory = os.path.dirname(filepath)
        if directory:
            os.makedirs(directory, exist_ok=True)
        
        # Create the icon
        create_icon(size, filepath)
    
    print("\n✨ All icons generated successfully!")
    print("📱 Icons are ready for Android and iOS")


if __name__ == '__main__':
    main()
