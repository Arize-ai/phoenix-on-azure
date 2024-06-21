import random
import string
import subprocess

try:
    import bcrypt
except ImportError:
    # Install bcrypt if not already installed
    subprocess.run("pip install bcrypt", shell=True)
    import bcrypt

def update_azd_env(name, val):
    subprocess.run(["azd", "env", "set", name, val])

def encrypt_password(username, password):
     bcrypted = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt(rounds=12)).decode("utf-8")
     return f"{username}:{bcrypted}"

data = subprocess.run(f"azd env get-values", shell=True, capture_output=True, text=True)
values = {}
for line in data.stdout.split('\n'):
    if line:
        key, value = line.split('=', 1)
        values[key] = value[1:-1]

if not 'SECRET' in values:
    secret = ''.join(random.choices(string.ascii_letters + string.digits, k=64))
    update_azd_env('SECRET', secret)
    values['SECRET'] = secret
    update_azd_env('HTACCESS', encrypt_password(values['SECRET'][0:32], values['SECRET'][32:]))
    update_azd_env('DB_PASSWORD', values['SECRET'][16:48])

