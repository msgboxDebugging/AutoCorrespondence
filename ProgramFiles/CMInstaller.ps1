$TOOLINFO = @"
#############################################
#           Correspondence Maker            #
#                                           #
#         - Command Setup Script -          #
#                                           #
# Version: 1.0.0              POC:CTN2 Hall #
#############################################
"@


# Prompt for the command name
$commandNamePrompt = "[x] Please Enter The Command Name"
$commandName = Read-Host $commandNamePrompt
$commandName = $commandName.toUpper()

# Prompt for the command root directory path, loop until valid path is given
$rootDirectoryprompt = "[x] Please Enter The Commands Root Directory"
while($true){
    $rootDirectory = Read-Host $rootDirectoryprompt
    if(test-path -PathType Container $rootDirectory){break}

    write-host "Error: Directory is not Valid."
}

# Directory Has not been Created
if (test-path -PathType Container "$rootDirectory\CorrespondenceMaker")
{
    ## go to config
}
# Directory has been created
else
{   
   CMInitialize($rootDirectory) 
}

function CMInitialize()
{
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$true)] [String] $rootDirectory
    )

    # Initialize Directory
    mkdir "$rootDirectory\CorrespondenceMaker"
    mkdir "$rootDirectory\CorrespondenceMaker\Templates"
    mkdir "$rootDirectory\CorrespondenceMaker\Templates\RouteSheets"
    mkdir "$rootDirectory\CorrespondenceMaker\Templates\CheckLists"

    # Create Root File
    $rootFileName = "{0:s}_ROOT_DIRECTORY" -f $commandName
    echo "" > "$rootDirectory\CorrespondenceMaker\$rootFileName"
    (Get-Item $rootFileName -force).attributes += 'Hidden'

    # Create Organization Database
    echo "" > "$rootDirectory\CorrespondenceMaker\OrganizationalChart.json"

    # Create Package Database
    echo "" > "$rootDirectory\CorrespondenceMaker\CorrespondenceDatabase.json"
}