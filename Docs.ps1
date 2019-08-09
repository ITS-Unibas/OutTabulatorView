break

Install-Module -Name platyPS -Scope CurrentUser -Force
Import-Module platyPS -Force

$Module = 'OutTabulatorView'

# you should have module imported in the session
Import-Module -Name .\$Module -Force
Get-Command -Module $Module

New-MarkdownHelp -Module $Module -OutputFolder .\docs -WithModulePage -NoMetadata -Force
