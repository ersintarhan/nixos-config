#!/usr/bin/env python3
import argparse
import json
import os
import random
import subprocess
import sys
import time
from glob import glob
from urllib import request

# --- Configuration ---
KEYWORDS = [
    "nature", "sports", "animals", "wild", "quote", "technology", "city",
    "space", "abstract", "car", "landscape", "minimalism", "digital art"
]
WALLPAPER_DIR = os.path.expanduser("~/.cache/wallpapers")
USER_AGENT = "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0"
RESOLUTION = "2560x1440" # Set your desired resolution here

def get_api_key(key_file_path):
    """Reads the API key from the given file path."""
    if not os.path.exists(key_file_path):
        print(f"Error: API key file not found at {key_file_path}", file=sys.stderr)
        sys.exit(1)
    try:
        with open(key_file_path, 'r') as f:
            api_key = f.read().strip()
        if not api_key:
            print(f"Error: API key file at {key_file_path} is empty.", file=sys.stderr)
            sys.exit(1)
        return api_key
    except Exception as e:
        print(f"Error reading API key file: {e}", file=sys.stderr)
        sys.exit(1)

def get_wallpaper_url(api_key):
    """Fetches a random wallpaper URL from Wallhaven."""
    random_keyword = random.choice(KEYWORDS)
    print(f"Selected keyword: {random_keyword}")
    
    api_url = (
        f"https://wallhaven.cc/api/v1/search?apikey={api_key}"
        f"&q={random_keyword}"
        "&categories=100"  # General
        "&purity=100"      # SFW
        f"&atleast={RESOLUTION}"
        "&sorting=random"
        "&ratios=16x9"
    )
    
    headers = {'User-Agent': USER_AGENT}
    req = request.Request(api_url, headers=headers)
    
    try:
        with request.urlopen(req) as response:
            if response.status != 200:
                print(f"Error: API returned status code {response.status}", file=sys.stderr)
                return None
            data = json.load(response)
            if not data.get('data'):
                print("API returned no results for this query.", file=sys.stderr)
                return None
            return data['data'][0]['path']
    except Exception as e:
        print(f"Error during API call: {e}", file=sys.stderr)
        return None

def download_wallpaper(url):
    """Downloads the wallpaper from the given URL."""
    os.makedirs(WALLPAPER_DIR, exist_ok=True)
    timestamp = int(time.time())
    wallpaper_path = os.path.join(WALLPAPER_DIR, f"wallpaper-{timestamp}.jpg")
    
    headers = {'User-Agent': USER_AGENT}
    req = request.Request(url, headers=headers)
    
    try:
        with request.urlopen(req) as response, open(wallpaper_path, 'wb') as out_file:
            if response.status != 200:
                print(f"Error: Failed to download image, status code {response.status}", file=sys.stderr)
                return None
            out_file.write(response.read())
        print(f"Successfully downloaded wallpaper to {wallpaper_path}")
        return wallpaper_path
    except Exception as e:
        print(f"Error downloading wallpaper: {e}", file=sys.stderr)
        return None

def set_wallpaper(path):
    """Sets the wallpaper using swww."""
    try:
        # Wait for swww-daemon if not ready
        for _ in range(5):
            status_proc = subprocess.run(['swww', 'query'], capture_output=True, text=True)
            if status_proc.returncode == 0:
                break
            print("Waiting for swww-daemon...")
            time.sleep(1)
            
        proc = subprocess.run(
            ['swww', 'img', path, '--transition-type', 'any', '--transition-pos', 'bottom-right'],
            check=True,
            capture_output=True,
            text=True
        )
        print("Successfully set wallpaper.")
    except (subprocess.CalledProcessError, FileNotFoundError) as e:
        print(f"Error setting wallpaper with swww: {e}", file=sys.stderr)
        if isinstance(e, subprocess.CalledProcessError):
            print(f"swww stderr: {e.stderr}", file=sys.stderr)

def cleanup_old_wallpapers():
    """Keeps the 10 most recent wallpapers and deletes the rest."""
    try:
        files = sorted(glob(os.path.join(WALLPAPER_DIR, "wallpaper-*.jpg")), key=os.path.getmtime, reverse=True)
        if len(files) > 10:
            for f in files[10:]:
                os.remove(f)
                print(f"Removed old wallpaper: {f}")
    except Exception as e:
        print(f"Error during wallpaper cleanup: {e}", file=sys.stderr)

def main():
    parser = argparse.ArgumentParser(description="Fetch and set a random wallpaper from Wallhaven.")
    parser.add_argument(
        "key_file",
        nargs='?', # Makes the argument optional
        default=os.path.expanduser("~/.config/wallhaven-api-key"),
        help="Path to the Wallhaven API key file."
    )
    args = parser.parse_args()

    api_key = get_api_key(args.key_file)
    wallpaper_url = get_wallpaper_url(api_key)
    
    if wallpaper_url:
        wallpaper_path = download_wallpaper(wallpaper_url)
        if wallpaper_path:
            set_wallpaper(wallpaper_path)
            cleanup_old_wallpapers()

if __name__ == "__main__":
    main()
