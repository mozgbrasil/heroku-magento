from http.server import BaseHTTPRequestHandler
#from cowpy import cow

class handler(BaseHTTPRequestHandler):

    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/plain')
        self.end_headers()
        #message = cow.Cowacter().milk('Hello from Python on Now Lambda!1111111')
        message = str('Hello from Python on Now 2.0!')
        self.wfile.write(message.encode())
        return
