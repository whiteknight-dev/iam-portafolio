<#
.SYNOPSIS
    Provisions test identities for the Entra ID JML lifecycle lab (Tech Solutions).
.DESCRIPTION
    Creates Carlos Ruiz (Sales) and Lucía Vega (HR) with the attributes required
    by the Dynamic Group rules and Lifecycle Workflows used later in the lab.
    Ana Torres is created manually via the portal (see README, Phase 2).
.NOTES
    Requires: Microsoft.Graph PowerShell SDK, User.ReadWrite.All scope.
#>

Connect-MgGraph -Scopes "User.ReadWrite.All"

$domain = "TechSolutionsGT.onmicrosoft.com"  # replace with your tenant domain

$users = @(
    @{
        DisplayName       = "Carlos Ruiz"
        MailNickname      = "carlos.ruiz"
        UserPrincipalName = "carlos.ruiz@$domain"
        Department        = "Sales"
        JobTitle          = "Sales Representative"
        UsageLocation     = "PE"
        EmployeeType      = "Employee"
    },
    @{
        DisplayName       = "Lucía Vega"
        MailNickname      = "lucia.vega"
        UserPrincipalName = "lucia.vega@$domain"
        Department        = "HR"
        JobTitle          = "HR Coordinator"
        UsageLocation     = "PE"
        EmployeeType      = "Employee"
    }
)

foreach ($u in $users) {
    $passwordProfile = @{
        Password                      = [System.Web.Security.Membership]::GeneratePassword(12, 2)
        ForceChangePasswordNextSignIn = $true
    }

    New-MgUser -DisplayName $u.DisplayName `
        -MailNickname $u.MailNickname `
        -UserPrincipalName $u.UserPrincipalName `
        -AccountEnabled `
        -PasswordProfile $passwordProfile `
        -Department $u.Department `
        -JobTitle $u.JobTitle `
        -UsageLocation $u.UsageLocation `
        -EmployeeType $u.EmployeeType

    Write-Host "Created: $($u.DisplayName) [$($u.Department)]"
}