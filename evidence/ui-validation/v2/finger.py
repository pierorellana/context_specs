# Simulates a fingerprint touch on the emulator via its console (port 5556).
import socket, time, os, sys
tok = open(os.path.expanduser('~/.emulator_console_auth_token')).read().strip()
times = int(sys.argv[1]) if len(sys.argv) > 1 else 1
s = socket.create_connection(('127.0.0.1', 5556)); s.settimeout(2)
def cmd(c):
    s.sendall((c + '\r\n').encode()); time.sleep(0.3)
    try: return s.recv(4096).decode(errors='ignore')
    except Exception: return ''
cmd(''); cmd('auth ' + tok)
for _ in range(times):
    cmd('finger touch 1'); time.sleep(0.6); cmd('finger remove 1'); time.sleep(0.5)
s.close()
