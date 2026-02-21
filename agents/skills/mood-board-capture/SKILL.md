# Mood Board Capture Skill

Capture text, images, or web links directly into the user's local Mood Board.

## Quick Start
To capture an item, run the capture script from the mood board directory using its virtual environment.

```bash
cd /Users/leecostello/Documents/lee/moodboard
./venv/bin/python3 capture.py "[content]"
```

## Input Types
- **Web links**: Provide a full URL (starting with http/https). The skill will automatically fetch metadata.
- **Local Images**: Provide an absolute path to an image file (.png, .jpg, .jpeg, .gif, .webp).
- **Text**: Provide any text string.

## Important Notes
- Always provide the `content` as a single quoted argument.
- The skill will automatically update the `index.md` after each capture.
- If you are capturing an image, ensure you have the correct absolute path to the file.
