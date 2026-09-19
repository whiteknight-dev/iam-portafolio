<#
.SYNOPSIS
    Provisions test identities for the Entra ID JML lifecycle lab (Contoso Logistics).
.DESCRIPTION
    Creates Carlos Ruiz (Sales) and Lucía Vega (HR) with the attributes required
    by the Dynamic Group rules and Lifecycle Workflows used later in the lab.
    Ana Torres is created manually via the portal (see README, Phase 2).
.NOTES
    Requires: Microsoft.Graph PowerShell SDK, User.ReadWrite.All scope.
#>

Connect-MgGraph -Scopes "User.ReadWrite.All"

function New-RandomPassword {
    # Cross-platform replacement for System.Web.Security.Membership.GeneratePassword,
    # which only exists on Windows/.NET Framework.
    $upper   = 'ABCDEFGHJKLMNPQRSTUVWXYZ'
    $lower   = 'abcdefghijkmnpqrstuvwxyz'
    $digits  = '23456789'
    $symbols = '!@#$%^&*'
    $all     = $upper + $lower + $digits + $symbols

    $password  = @(
        $upper[(Get-Random -Maximum $upper.Length)]
        $lower[(Get-Random -Maximum $lower.Length)]
        $digits[(Get-Random -Maximum $digits.Length)]
        $symbols[(Get-Random -Maximum $symbols.Length)]
    )
    $password += 1..8 | ForEach-Object { $all[(Get-Random -Maximum $all.Length)] }

    -join ($password | Get-Random -Count $password.Count)
}

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
        DisplayName       = "Lucia Vega"
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
        Password                      = New-RandomPassword
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