
---
# 📚 Book Recommendation System

A simple Flask app that shows top books and recommends similar ones based on user input.

## Features

- View top 50 popular books.
- Get 5 similar book recommendations.
- Autocomplete for book search.

## Run Locally

1. Install Flask:
   ```bash
   pip install flask numpy
   ```

2. Place model files in `models/`:
   - `popular.pkl`
   - `books.pkl`
   - `pivot.pkl`
   - `similarity.pkl`

3. Start the app:
   ```bash
   python app.py
   ```
