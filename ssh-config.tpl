add-content -path "C:/Users/Jose Diago/.ssh/config" -value @'

Host ${hostName}
    HostName ${hostName}
    User ${user}
    IdentityFile ${identityFile}
'@