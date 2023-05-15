# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

$sailor = @{}
$sailor.add('Rank',"CTN2")
$Sailor.add('FirstName', 'Justus')
$sailor.add('LastName',"Hall")
$sailor.add('SID',"Hall")
$sailor.add("LocalPackageStorage", "C:\Users\Justu\Desktop\research\powershell\correspondenceMaker\Documents")

# RESOURCES
$PackageDirectory       = "C:\Users\Justu\Desktop\research\powershell\correspondenceMaker\COMMAND_ROOT\CMROOT\Packages"
$Resources              = "C:\Users\Justu\Desktop\research\powershell\correspondenceMaker\ProgramFiles"
$StatusImagePath        = "$Resources\Images\Checked.png"
$TrackingImagePath      = "$Resources\Images\Tracking.png"
$CreateImagePath        = "$Resources\Images\Create.png"


# SIZING CONSTANTS
$BORDER_PADDING_Y = 850 / 75
$BORDER_PADDING_X = 850 / 85
$ELEMENT_PADDING_X = 850 / 70
$ELEMENT_PADDING_Y = 850 / 70

$IMAGE_RATIO = 850/22
$ImageSize = [System.Drawing.Size]::new($IMAGE_RATIO,$IMAGE_RATIO)

$STATUS_HEIGHT                      = 850/12
$NAVIGATION_PANEL_WIDTH             = 850/3.3
$NAVIGATION_PANEL_HEIGHT            = 850/2
$NAVIGATION_LOCATION_Y              = $BORDER_PADDING_Y + $StatusPanel.Size.Height + $ELEMENT_PADDING_Y
$BUTTON_LOCATION                    = ($STATUS_HEIGHT-$ImageSize.Width)/2
$BUTTON_SPACING_Y                   = ($NAVIGATION_PANEL_HEIGHT+$BUTTON_LOCATION) / 4
$MAIN_PANEL_START_X = $BORDER_PADDING_X + $NAVIGATION_PANEL_WIDTH + $ELEMENT_PADDING_X
$MAIN_PANEL_HEIGHT = $STATUS_HEIGHT + $ELEMENT_PADDING_Y + $NAVIGATION_PANEL_HEIGHT
$MAIN_PANEL_WIDTH = 850 - ($MAIN_PANEL_START_X + $BORDER_PADDING_X)

# FONTS
$ButtonFont= 'Arial Black,21'
$PreviousButtonFont= 'Arial Black,16'
$CheckListHeaderFont = "Segoe UI Semilight,14"
$CheckListItemFont = "Segoe UI Semibold,16"
$CheckListFont = "Courier New Bold,14"

# COLORS
$BLACK                  = "#000000"
$LIGHTBLACK             = "#121212"
$LIGHTBLACK_HIGHLIGHTED = "#1A1A1A"
$WHITE                  = "#FFFFFF"
$GREEN                  = "#3AA895"

# Define the main Window
$MainWindow                    = [System.Windows.Forms.Form]::new()
$MainWindow.SizeGripStyle      = [System.Windows.Forms.SizeGripStyle]::Hide
$MainWindow.FormBorderStyle    = [System.Windows.Forms.FormBorderStyle]::Fixed3D
$MainWindow.MinimumSize        = [System.Drawing.Size]::new(850,550)
$MainWindow.ClientSize         = $MainWindow.MinimumSize 
$MainWindow.BackColor          = $BLACK
$MainWindow.AllowDrop          = $true
$MainWindow.Opacity            = .97
$MainWindow.Text               = "{0:s} {1:s}'s Correspondence Dashboard" -f $sailor.rank, $sailor.LastName

# Define Panels
$StatusPanel                = [System.Windows.Forms.Panel]::new()
$StatusPanel.Name           = "STATUS"
$StatusPanel.Location       = [System.Drawing.Point]::new($BORDER_PADDING_X,$BORDER_PADDING_Y)
$StatusPanel.Size           = [System.Drawing.Size]::new($NAVIGATION_PANEL_WIDTH,$STATUS_HEIGHT)
$StatusPanel.BackColor      = $LIGHTBLACK

$NavigationPanel            = [System.Windows.Forms.Panel]::new()
$NavigationPanel.Name       = "NAVIGATION"
$NavigationPanel.Location   = [System.Drawing.Point]::new($BORDER_PADDING_X,$NAVIGATION_LOCATION_Y)
$NavigationPanel.Size       = [System.Drawing.Size]::new($NAVIGATION_PANEL_WIDTH,$NAVIGATION_PANEL_HEIGHT)
$NavigationPanel.BackColor  = $LIGHTBLACK

$MainPanel                  = [System.Windows.Forms.Panel]::new()
$MainPanel.Name             = "MAIN"
$MainPanel.Location         = [System.Drawing.Point]::new($MAIN_PANEL_START_X,$BORDER_PADDING_Y)
$MainPanel.Size             = [System.Drawing.Size]::new($MAIN_PANEL_WIDTH,$MAIN_PANEL_HEIGHT)
$MainPanel.BackColor        = $LIGHTBLACK
$MainPanel.AutoScroll       = $true

$MainWindow.Controls.Add($StatusPanel)
$MainWindow.Controls.Add($NavigationPanel)
$MainWindow.Controls.Add($MainPanel)

$LAYOUTS = @{}
function CLEAR_LAYOUT {
    $StatusPanel.Controls.Clear()
    $NavigationPanel.Controls.Clear()
    $MainPanel.Controls.Clear()
}
# Set Panels
function SET_LAYOUT{
    CLEAR_LAYOUT
    $StatusPanel.Controls.AddRange($LAYOUTS[$args[0]]['STATUS'])
    $NavigationPanel.Controls.AddRange($LAYOUTS[$args[0]]['NAVIGATION'])
    $MainPanel.Controls.AddRange($LAYOUTS[$args[0]]['MAIN']) 
}

# HOME_LAYOUT
function BUILD_HOMEPAGE(){
    # STATUS
        $StatusBtn                    = [System.Windows.Forms.PictureBox]::new()
        $StatusBtn.Location           = [System.Drawing.Point]::new(($STATUS_HEIGHT-$ImageSize.Width)/2,($STATUS_HEIGHT-$ImageSize.Width)/2)
        $StatusBtn.size               = $ImageSize
        $StatusBtn.SizeMode           = 4
        $StatusBtn.Image              = [System.Drawing.Image]::Fromfile($StatusImagePath)

        $StatusLabel                    = [System.Windows.Forms.Label]::new()
        $StatusLabel.Location           = [System.Drawing.Point]::new($ImageSize.Width + $ELEMENT_PADDING_X*2,$BUTTON_LOCATION)
        $StatusLabel.AutoSize           = $true
        $StatusLabel.Font               = $ButtonFont
        $StatusLabel.ForeColor          = $WHITE
        $StatusLabel.text               = "STATUS"

    # SIDE BAR
        #CREATE BUTTON
        $NewPackageBtn                      = [System.Windows.Forms.PictureBox]::new()
        $NewPackageBtn.Location             = [System.Drawing.Point]::new($BUTTON_LOCATION,$BUTTON_LOCATION)
        $NewPackageBtn.size                 = $ImageSize
        $NewPackageBtn.SizeMode             = 4
        $NewPackageBtn.Image                = [System.Drawing.Image]::Fromfile($CreateImagePath)

        $NewPackageLabel                    = [System.Windows.Forms.Label]::new()
        $NewPackageLabel.Location           = [System.Drawing.Point]::new($ImageSize.Width + $ELEMENT_PADDING_X*2,$BUTTON_LOCATION)
        $NewPackageLabel.AutoSize           = $true
        $NewPackageLabel.Font               = $ButtonFont
        $NewPackageLabel.ForeColor          = $WHITE
        $NewPackageLabel.text               = "CREATE"
        $NewPackageLabel.Add_Click({SET_LAYOUT "CREATE"})

        # TRACK BUTTON
        $TrackPackageBtn                     = [System.Windows.Forms.PictureBox]::new()
        $TrackPackageBtn.Location            = [System.Drawing.Size]::new($BUTTON_LOCATION,$BUTTON_LOCATION + $BUTTON_SPACING_Y)
        $TrackPackageBtn.size                = $ImageSize
        $TrackPackageBtn.SizeMode            = 4
        $TrackPackageBtn.Image               = [System.Drawing.Image]::Fromfile($CreateImagePath)

        $TrackPackageLabel                   = [System.Windows.Forms.Label]::new()
        $TrackPackageLabel.Location          = [System.Drawing.Point]::new($ImageSize.Width + $ELEMENT_PADDING_X*2,$BUTTON_LOCATION + $BUTTON_SPACING_Y)
        $TrackPackageLabel.AutoSize          = $true
        $TrackPackageLabel.Font              = $ButtonFont
        $TrackPackageLabel.ForeColor         = $WHITE
        $TrackPackageLabel.text              = "TRACK"

        # UNDECIDED
        $BUTTONB                            = [System.Windows.Forms.PictureBox]::new()
        $BUTTONB.Location                   = [System.Drawing.Size]::new($BUTTON_LOCATION,$BUTTON_LOCATION + $BUTTON_SPACING_Y*2)
        $BUTTONB.size                       = $ImageSize
        $BUTTONB.SizeMode                   = 4
        $BUTTONB.Image                      = [System.Drawing.Image]::Fromfile($CreateImagePath)

        $LABELB                             = [System.Windows.Forms.Label]::new()
        $LABELB.Location                    = [System.Drawing.Point]::new($ImageSize.Width + $ELEMENT_PADDING_X*2,$BUTTON_LOCATION+$BUTTON_SPACING_Y*2)
        $LABELB.AutoSize                    = $true
        $LABELB.Font                        = $ButtonFont
        $LABELB.ForeColor                   = $WHITE
        $LABELB.text                        = "BUTTON3"

        # UNDECIDED
        $BUTTONC                            = [System.Windows.Forms.PictureBox]::new()
        $BUTTONC.Location                   = [System.Drawing.Size]::new($BUTTON_LOCATION,$BUTTON_LOCATION + $BUTTON_SPACING_Y*3)
        $BUTTONC.size                       = $ImageSize
        $BUTTONC.SizeMode                   = 4
        $BUTTONC.Image                      = [System.Drawing.Image]::Fromfile($CreateImagePath)

        $LABELC                             = [System.Windows.Forms.Label]::new()
        $LABELC.Location                    = [System.Drawing.Point]::new($ImageSize.Width + $ELEMENT_PADDING_X*2,$BUTTON_LOCATION+$BUTTON_SPACING_Y*3)
        $LABELC.AutoSize                    = $true
        $LABELC.Font                        = $ButtonFont
        $LABELC.ForeColor                   = $WHITE
        $LABELC.text                        = "BUTTON4"

        $panels = @{}
        $panels.add('STATUS',@($StatusBtn,$StatusLabel))
        $panels.add("NAVIGATION", @($NewPackageBtn,$NewPackageLabel,$TrackPackageBtn,$TrackPackageLabel,$BUTTONB,$LABELB,$BUTTONC,$LABELC))
        $panels.add("MAIN", @())
        return $panels
}

############################################
# Create Page
############################################
function CreatePage_ResetMain{
    $MainPanel.Controls["TITLE"].Text = "Select Package"
    $MainPanel.Controls["Route Sheet"].Controls.Clear()
    $oldChecklistItems = $MainPanel.Controls | where name -like "CheckList:*"
    foreach($item in $oldChecklistItems){$MainPanel.Controls.Remove($item)}
} 

function CreatePage_OnPackageSelect{
    $PackageName = $NavigationPanel.Controls["Package List"].items[$args[0]]
    $packageInfo = get-content ("$PackageDirectory\$PackageName") | ConvertFrom-Json
    CreatePage_ResetMain

    $RouteSheetSpacing = (($MAIN_PANEL_WIDTH-$ELEMENT_PADDING_X)/$packageInfo.RouteSheet.length)
    $CheckListOffset = ($ImageSize.height + $ELEMENT_PADDING_Y)*3.5

    # Set the Title
    $MainPanel.Controls["TITLE"].Text = "$PackageName"
    
    # Populate RouteSheet Display
    for($i = 0;$i -lt $packageInfo.RouteSheet.length;$i++){
        $step                 = [System.Windows.Forms.PictureBox]::new()
        $step.name            = [string]$packageInfo.RouteSheet[$i]
        $step.Location        = [System.Drawing.Point]::new($RouteSheetSpacing*$i,0)
        $step.Size            = [System.Drawing.Size]::new($ImageSize.Width/2,$ImageSize.Width/2)
        $step.SizeMode        = 4
        $step.Image           = [System.Drawing.Image]::Fromfile("$resources\images\next.png")
        $step.add_MouseEnter({$tooltip = [system.windows.forms.tooltip]::new();$tooltip.SetToolTip($this,$this.name)})

        $null = $MainPanel.Controls["Route Sheet"].controls.add($step)
    }

    # Check List Header
    $CheckListItem                 = [System.Windows.Forms.Panel]::new()
    $CheckListItem.Name            = "CheckList: Header"
    $CheckListItem.Location        = [System.Drawing.Point]::new($ELEMENT_PADDING_X,$CheckListOffset)
    $CheckListItem.Size            = [System.Drawing.Size]::new($MAIN_PANEL_WIDTH-$ELEMENT_PADDING_X*2.5,$ELEMENT_PADDING_Y*2.5)

    $Number              = [System.Windows.Forms.Label]::new()
    $Number.Location     = [System.Drawing.Point]::new(0,0)
    $Number.Size         = [System.Drawing.Point]::new($ELEMENT_PADDING_X*4,$ELEMENT_PADDING_Y*2.5)
    $Number.Font         = $CheckListHeaderFont
    $Number.ForeColor    = $WHITE
    $Number.text     = "#"

    $Name               = [System.Windows.Forms.Label]::new()
    $Name.Location      = [System.Drawing.Point]::new($ELEMENT_PADDING_X*4,0)
    $Name.Size          = [System.Drawing.Point]::new($ELEMENT_PADDING_X*20,$ELEMENT_PADDING_Y*2.5)
    $Name.Font          = $CheckListHeaderFont
    $Name.ForeColor     = $WHITE
    $Name.text          = "Name"

    $Path               = [System.Windows.Forms.Label]::new()
    $Path.Location      = [System.Drawing.Point]::new($ELEMENT_PADDING_X*24,0)
    $Path.Size          = [System.Drawing.Point]::new($ELEMENT_PADDING_X*20,$ELEMENT_PADDING_Y*2.5)
    $Path.Font          = $CheckListHeaderFont
    $Path.ForeColor     = $WHITE
    $Path.text          = "Path"
    $CheckListItem.controls.AddRange(@($Number,$Name,$Path))
    $null = $MainPanel.Controls.add($CheckListItem)

    $MaxCheckListNameLength = 19
    for($i = 0;$i -lt $packageInfo.Checklist.length;$i++){
        # CheckList Item Panel
        $CheckListItem          = [System.Windows.Forms.Panel]::new()
        $CheckListItem.Name     = "CheckList: Item $i"
        $CheckListItem.Location = [System.Drawing.Point]::new($ELEMENT_PADDING_X,$CheckListOffset+$ImageSize.Height*($i+1))
        $CheckListItem.Size     = [System.Drawing.Size]::new($MAIN_PANEL_WIDTH-$ELEMENT_PADDING_X*2.5,$ELEMENT_PADDING_Y*2.5)
 
        $Number              = [System.Windows.Forms.Label]::new()
        $Number.Location     = [System.Drawing.Point]::new(0,0)
        $Number.Size         = [System.Drawing.Point]::new($ELEMENT_PADDING_X*4,$ELEMENT_PADDING_Y*2.5)
        $Number.Font         = $CheckListItemFont
        $Number.ForeColor    = $WHITE
        $Number.text     = "{0:d2}" -f ($i+1)

        $Name               = [System.Windows.Forms.Label]::new()
        $Name.Location      = [System.Drawing.Point]::new($ELEMENT_PADDING_X*4,0)
        $Name.Size          = [System.Drawing.Point]::new($ELEMENT_PADDING_X*20,$ELEMENT_PADDING_Y*2.5)
        $Name.Font          = $CheckListItemFont
        $Name.ForeColor     = $WHITE
        # Truncate Item Text
        if($packageInfo.CheckList[$i].length -gt  $MaxCheckListNameLength){
            $Name.text = "{0:s}..." -f $packageInfo.CheckList[$i].substring(0,$MaxCheckListNameLength)
        }
        else{
            $Name.text = "{0:s}" -f $packageInfo.CheckList[$i]
        }

        $Path               = [System.Windows.Forms.Label]::new()
        $Path.Location      = [System.Drawing.Point]::new($ELEMENT_PADDING_X*24,0)
        $Path.Size          = [System.Drawing.Point]::new($ELEMENT_PADDING_X*20,$ELEMENT_PADDING_Y*2.5)
        $Path.Font          = $CheckListItemFont
        $Path.ForeColor     = $WHITE
        $Path.text          = "Drop File Here"
        
        # Highight When Selected Panel is covered got to add listener to all items
        $highlightItem = [scriptblock]::Create({foreach($element in $this.parent.controls){$element.BackColor = $LIGHTBLACK_HIGHLIGHTED};$tooltip = [system.windows.forms.tooltip]::new();$tooltip.SetToolTip($this,$this.text)})
        $Number.add_MouseEnter($highlightItem)
        $Name.add_MouseEnter($highlightItem)
        $Path.add_MouseEnter($highlightItem)

        $UnHighlightItem = [scriptblock]::Create({foreach($element in $this.parent.controls){$element.BackColor = $LIGHTBLACK}})
        $Number.add_MouseLeave($UnHighlightItem)
        $Name.add_MouseLeave($UnHighlightItem)
        $Path.add_MouseLeave($UnHighlightItem)

        # Allow Drag and drops of files
        $CheckListItem.AllowDrop = $true
        $CheckListItem.add_DragEnter({if($args[1].Data.GetDataPresent("FileDrop")){$args[1].effect = 1}})
        $CheckListItem.add_DragDrop({$path = $args[1].Data.GetData("FileDrop");if($path.length -gt 19){$this.controls[2].text = "{0:s}..." -f $path.substring(0,19)}else{$this.controls[2].text = $path}})

        # Add item to main panel
        $CheckListItem.controls.AddRange(@($Number,$Name,$Path))
        $null = $MainPanel.Controls.add($CheckListItem)
    }
    $step.Image = [System.Drawing.Image]::Fromfile("$resources\images\checked.png")
    
    $CreatePackageBtn                   = [System.Windows.Forms.PictureBox]::new()
    $CreatePackageBtn.Name              = "CheckList: CreateBtn"
    $CreatePackageBtn.Location          = [System.Drawing.Point]::new(($ImageSize.height+$ELEMENT_PADDING_X)*4.5,$CheckListOffset+$ImageSize.Height*$packageInfo.Checklist.length+$ELEMENT_PADDING_X*2.5)
    $CreatePackageBtn.size              = $ImageSize
    $CreatePackageBtn.SizeMode          = 4
    $CreatePackageBtn.Image             = [System.Drawing.Image]::Fromfile($StatusImagePath)
    $CreatePackageBtn.add_Click({CreatePage_ValidatePackage})

    $MainPanel.Controls.add($CreatePackageBtn)
}

function CreatePage_ValidatePackage{
    $PackageName = $MainPanel.Controls["TITLE"].Text
    $PackageInfo = get-content ("$PackageDirectory\$PackageName") | ConvertFrom-Json
    
    $items = $MainPanel.Controls | where name -like "CheckList: Item*"

    # Create A new dictionary to hold the items were checking
    $PackageFiles = [ordered]@{}
    $i = 0
    foreach($item in $items){
        if($item.controls[2].Text -eq "Drop File Here"){$item.controls[2].BackColor = "#FF1212"}
        else{$PackageFiles.add($PackageInfo.CheckList[$i],$item.controls[2].Text)}
        $i++
    }
    # Check if we have all the items if not quit
    if($PackageFiles.Keys.Count -ne $PackageInfo.CheckList.length){return}

    CreatePage_CreatePackage $PackageInfo.RouteSheet $PackageFiles
}

function CreatePage_CreatePackage{
    [Parameter(AttributeValues)][Object] $RoutingSheet
    [Parameter(AttributeValues)][System.Collections.Specialized.OrderedDictionary] $PackageFiles

    $PackageName    = "{0:s}_ICO_{1:s}_{2:s}" -f $MainPanel.Controls["TITLE"].Text, $sailor.Rank, $sailor.Lastname
    $PackagePath    = "{0:s}\{1:s}" -f $sailor.LocalPackageStorage, $PackageName
    $SailorName     = "{0:s},{1:s}" -f $sailor.LastName,$sailor.FirstName

    #TODO: MAKE SURE DIR IS THERE
    # Make Directory And Copy the Files
    mkdir $PackagePath
    foreach($file in $PackageFiles.keys.GetEnumerator()){Copy-Item -path $PackageFiles[$file] "$PackagePath\$file"}

    # Create New Package
    $NewPackage = [ordered]@{}
    $NewPackage.Add("ID", "")
    $NewPackage.add("CREATED", (get-date | Out-String).trim())
    $NewPackage.Add("PackageName", $PackageName)
    $NewPackage.Add("SailorName", $SailorName)
    $NewPackage.Add("SID", $sailor.SID)
    $newPackage.add("RoutingSheet", $RoutingSheet)
    $NewPackage.Add("Files", $PackageFiles)

    # Hash Package and Set ID
    $PackageTrackingInformation = [string]($NewPackage | ConvertTo-Json)
    $MemoryStream = [System.IO.MemoryStream]::new()
    $StreamWriter = [System.IO.StreamWriter]::new($MemoryStream)
    $StreamWriter.write($PackageTrackingInformation)
    $writer.Flush()
    $MemoryStream.Position = 0
    $Hash = Get-FileHash -InputStream $stringAsStream
    $NewPackage["ID"] = $hash.hash.substring(0,8)

    # Convert Package TrackingInformation and write it to folder
    $PackageTrackingInformation = [string]($NewPackage | ConvertTo-Json)
    Write-Output $PackageTrackingInformation > "$PackagePath\CorrespondenceInformation.json"

    # Write it to database
}



function BUILD_CreatePage(){
    $Packages =  Get-ChildItem -name "$PackageDirectory"
    $mainPanelList = [System.Collections.ArrayList]::new()

    # STATUS
        $StatusBtn                    = [System.Windows.Forms.PictureBox]::new()
        $StatusBtn.Location           = [System.Drawing.Point]::new(($STATUS_HEIGHT-$ImageSize.Width)/2,($STATUS_HEIGHT-$ImageSize.Width)/2)
        $StatusBtn.size               = $ImageSize
        $StatusBtn.SizeMode           = 4
        $StatusBtn.Image              = [System.Drawing.Image]::Fromfile($StatusImagePath)

        $StatusLabel                    = [System.Windows.Forms.Label]::new()
        $StatusLabel.Location           = [System.Drawing.Point]::new($ImageSize.Width + $ELEMENT_PADDING_X*2,$BUTTON_LOCATION)
        $StatusLabel.AutoSize           = $true
        $StatusLabel.Font               = $ButtonFont
        $StatusLabel.ForeColor          = $WHITE
        $StatusLabel.text               = "CREATE"

    # MAIN
        $TitleLabel                    = [System.Windows.Forms.Label]::new()
        $TitleLabel.Name               = "TITLE"
        $TitleLabel.Location           = [System.Drawing.Point]::new(($ImageSize.height+$ELEMENT_PADDING_X)*4.5,($ImageSize.height + $ELEMENT_PADDING_Y)*2)
        $TitleLabel.AutoSize           = $true
        $TitleLabel.Font               = $PreviousButtonFont
        $TitleLabel.ForeColor          = $WHITE
        $TitleLabel.text               = "Select Package"
        $null = $mainPanelList.add($TitleLabel)

        $RouteSheet                = [System.Windows.Forms.Panel]::new()
        $RouteSheet.Name           = "Route Sheet"
        $RouteSheet.Location       = [System.Drawing.Point]::new($ELEMENT_PADDING_X,($ImageSize.height + $ELEMENT_PADDING_Y)*2.8)
        $RouteSheet.Size           = [System.Drawing.Size]::new($MAIN_PANEL_WIDTH-$ELEMENT_PADDING_X*2.5,$ImageSize.Width)
        $RouteSheet.BackColor      = $LIGHTBLACK
        $null = $mainPanelList.add($RouteSheet)

        $PreviousBtn                    = [System.Windows.Forms.PictureBox]::new()
        $PreviousBtn.Location           = [System.Drawing.Point]::new(($STATUS_HEIGHT-$ImageSize.Width)/2,($STATUS_HEIGHT-$ImageSize.Width)/2)
        $PreviousBtn.size               = $ImageSize
        $PreviousBtn.SizeMode           = 4
        $PreviousBtn.Image              = [System.Drawing.Image]::Fromfile("$resources\Images\Previous.png")
        $PreviousBtn.add_Click({CreatePage_ResetMain;SET_LAYOUT "HOME"})
        $null = $mainPanelList.add($PreviousBtn)


    # Side Panel
        $PackageNameLabel                    = [System.Windows.Forms.Label]::new()
        $PackageNameLabel.Location           = [System.Drawing.Point]::new($ELEMENT_PADDING_X,$BUTTON_LOCATION)
        $PackageNameLabel.AutoSize           = $true
        $PackageNameLabel.Font               = $ButtonFont
        $PackageNameLabel.ForeColor          = $WHITE
        $PackageNameLabel.text               = "Packages"


        $PackageList                 = [System.Windows.Forms.ListBox]::new()
        $PackageList.name            = "Package list"
        $PackageList.Location        = [System.Drawing.Point]::new($ELEMENT_PADDING_X,$ImageSize.Height+$ELEMENT_PADDING_Y*2)
        $PackageList.Size            = [System.Drawing.Size]::new($NAVIGATION_PANEL_WIDTH - $ELEMENT_PADDING_X*2,$ImageSize.Height*9)
        $PackageList.Font            =  $CheckListFont
        $PackageList.ForeColor       = $WHITE
        $PackageList.BackColor       = $LIGHTBLACK
        $PackageList.Items.AddRange($Packages)
        $PackageList.add_SelectedIndexChanged({CreatePage_OnPackageSelect $this.SelectedIndex})
        
    $panels = @{}
    $panels.add('STATUS',@($StatusBtn,$StatusLabel))
    $panels.add("NAVIGATION", @($PackageNameLabel,$Packagelist))
    $panels.add("MAIN", [Array]$mainPanelList)
    return $panels
}


# Build all the layouts
$LAYOUTS.add("HOME", (BUILD_HOMEPAGE))
$LAYOUTS.add("CREATE", (BUILD_CreatePage))

SET_LAYOUT "HOME"
$MainWindow.ShowDialog()
