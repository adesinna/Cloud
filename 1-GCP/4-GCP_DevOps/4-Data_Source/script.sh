#!/bin/bash

# Install necessary packages
sudo apt install -y telnet
sudo apt install -y nginx

# Enable nginx to start on boot
sudo systemctl enable nginx

# Set appropriate permissions for the web directory
sudo chmod -R 755 /var/www/html

# Create a directory for your web application
sudo mkdir -p /var/www/html/app1

# Get the hostname and IP address of the VM
HOSTNAME=$(hostname)

# Create a custom HTML page
sudo echo "
<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>I Love You BMT</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #FFDEE9, #B5FFFC);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            text-align: center;
            padding: 50px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            border-radius: 10px;
        }
        h1 {
            color: #FF1493;
            font-size: 3em;
            margin-bottom: 0;
        }
        p {
            font-size: 1.2em;
            color: #333;
        }
        .info {
            margin-top: 20px;
            font-size: 1em;
            color: #555;
        }
        footer {
            margin-top: 30px;
            font-size: 0.9em;
            color: #888;
        }
    </style>
</head>
<body>
    <div class='container'>
        <h1>I Love You BMT</h1>
        <p>You're my everything, and I just wanted the world to know.</p>
        <div class='info'>
            <p><strong>VM Hostname:</strong> $HOSTNAME</p>
            <p><strong>VM IP Address:</strong> $(hostname -I)</p>
            <p><strong>Application Version:</strong> V1</p>
        </div>
        <footer>
            <p>Powered by Google Cloud Platform - Demos</p>
        </footer>
    </div>
</body>
</html>
" | sudo tee /var/www/html/app1/index.html

# Create the main index page as well
sudo echo "
<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>I Love You BMT</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #FFDEE9, #B5FFFC);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            text-align: center;
            padding: 50px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            border-radius: 10px;
        }
        h1 {
            color: #FF1493;
            font-size: 3em;
            margin-bottom: 0;
        }
        p {
            font-size: 1.2em;
            color: #333;
        }
        .info {
            margin-top: 20px;
            font-size: 1em;
            color: #555;
        }
        footer {
            margin-top: 30px;
            font-size: 0.9em;
            color: #888;
        }
    </style>
</head>
<body>
    <div class='container'>
        <h1>I Love You BMT</h1>
        <p>You're my everything, and I just wanted the world to know.</p>
        <div class='info'>
            <p><strong>VM Hostname:</strong> $HOSTNAME</p>
            <p><strong>VM IP Address:</strong> $(hostname -I)</p>
            <p><strong>Application Version:</strong> V1</p>
        </div>
        <footer>
            <p>Powered by Google Cloud Platform - Demos</p>
        </footer>
    </div>
</body>
</html>
" | sudo tee /var/www/html/index.html

# Restart nginx to apply changes
sudo systemctl restart nginx

echo "Web page deployed with 'I Love You BMT' message."
