#cat tomcat-shell.sh
#!/bin/bash

# File to be modified
TOMCAT_USERS_FILE="/opt/tomcat/9_0/conf/tomcat-users.xml"

# User and password to be added
USERNAME="admin"
PASSWORD="admin"
ROLES="manager-gui,admin-gui"

# Check if the file exists, if not, create it with the provided XML structure
if [ ! -f "$TOMCAT_USERS_FILE" ]; then
    echo '<?xml version="1.0" encoding="UTF-8"?>' > "$TOMCAT_USERS_FILE"
    echo '<tomcat-users xmlns="http://tomcat.apache.org/xml"' >> "$TOMCAT_USERS_FILE"
    echo '              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' >> "$TOMCAT_USERS_FILE"
    echo '              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"' >> "$TOMCAT_USERS_FILE"
    echo '              version="1.0">' >> "$TOMCAT_USERS_FILE"
    echo '    <!-- Add user and roles below -->' >> "$TOMCAT_USERS_FILE"
    echo '    <role rolename="manager-gui"/>' >> "$TOMCAT_USERS_FILE"
    echo '    <role rolename="admin-gui"/>' >> "$TOMCAT_USERS_FILE"
    echo "    <user username=\"$USERNAME\" password=\"$PASSWORD\" roles=\"$ROLES\"/>" >> "$TOMCAT_USERS_FILE"
    echo '</tomcat-users>' >> "$TOMCAT_USERS_FILE"
    echo >> "$TOMCAT_USERS_FILE"
    echo "User '$USERNAME' added to tomcat-users.xml"
else
    # Check if the user already exists, if not, add the user and roles
    if ! grep -q "<user username=\"$USERNAME\"" "$TOMCAT_USERS_FILE"; then
        sed -i "/<\/tomcat-users>/i \    <user username=\"$USERNAME\" password=\"$PASSWORD\" roles=\"$ROLES\"/>" "$TOMCAT_USERS_FILE"
        echo "User '$USERNAME' added to tomcat-users.xml"
    else
        echo "User '$USERNAME' already exists in tomcat-users.xml"
    fi
fi
