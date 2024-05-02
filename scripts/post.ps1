$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCmd) {
  # fallback to python3 if python not found
  $pythonCmd = Get-Command python3 -ErrorAction SilentlyContinue
}

Start-Process -FilePath ($pythonCmd).Source -ArgumentList "./scripts/banner.py" -Wait -NoNewWindow
