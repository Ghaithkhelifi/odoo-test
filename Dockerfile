# Start with the ready-made Odoo Enterprise image you chose.
FROM ofleet/odoo:18-20250701-enterprise

# Switch to the 'root' user to get permissions to install things.
USER root

# Install 'wget' (to download) and 'unzip' (to extract).
# The cleanup commands keep the final image smaller.
RUN apt-get update && apt-get install -y wget unzip --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Download your addon files from the public links into a temporary folder.
RUN wget -O /tmp/addons-18e.zip https://lowendspace.com/addons-18e.zip
RUN wget -O /tmp/odoo18_unlimited.zip https://lowendspace.com/odoo18_unlimited.zip

# Unzip your files to their required destination folders.
RUN unzip -o /tmp/addons-18e.zip -d /usr/lib/python3/dist-packages/odoo/
RUN unzip -o /tmp/odoo18_unlimited.zip -d /usr/lib/python3/dist-packages/odoo/addons/

# Remove the temporary zip files to keep the image clean.
RUN rm /tmp/*.zip

# IMPORTANT: Switch back to the less-privileged 'odoo' user for security.
USER odoo
