# Users and Locate
if (get-localuser -name Administrator)
  {rename-localuser Administrator Ex-Administrator}
if (get-localuser -name Guest)
  {rename-localuser Guest Ex-Guest}


# Import Audit Policy 
auditpol /restore /file:.\audit.csv
# .\ is the current directory


# Import Password Policies/Lockout
secedit /import /cfg:.\PasswordPolicies.inf


# hello
