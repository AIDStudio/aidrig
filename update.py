import subprocess
import os
from datetime import datetime

PROJECT_DIR = "/storage/2489-151F/aidrig"

def run_cmd(cmd, cwd=None):
    result = subprocess.run(cmd, shell=True, cwd=cwd,
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            text=True)
    return result.stdout.strip(), result.stderr.strip(), result.returncode

def main():
    if not os.path.isdir(PROJECT_DIR):
        print(f"Nem található a könyvtár: {PROJECT_DIR}")
        return

    # git pull
    out, err, code = run_cmd("git pull origin main", cwd=PROJECT_DIR)
    print(out)
    if code != 0:
        print(f"Hiba a git pull során: {err}")
        return

    # git add
    out, err, code = run_cmd("git add .", cwd=PROJECT_DIR)
    if code != 0:
        print(f"Hiba a git add során: {err}")
        return

    # Ellenőrizzük, van-e változás commitoláshoz
    _, _, code = run_cmd("git diff-index --quiet HEAD --", cwd=PROJECT_DIR)
    if code == 0:
        # nincs változás
        print("Nincs új változás commitoláshoz.")
        return

    # commit
    commit_msg = f"Automatikus commit {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    out, err, code = run_cmd(f'git commit -m "{commit_msg}"', cwd=PROJECT_DIR)
    if code != 0:
        print(f"Hiba a commit során: {err}")
        return
    print(out)

    # push
    out, err, code = run_cmd("git push origin main", cwd=PROJECT_DIR)
    if code != 0:
        print(f"Hiba a push során: {err}")
        return
    print(out)

if __name__ == "__main__":
    main()