Function GUI
{
    [CMDLetBinding(DefaultParameterSetName='Form')]
    Param
    (
        [Parameter(Mandatory=$True, ParameterSetName='TabControl', Position=0)]
        [Switch]$TC,
        [Parameter(Mandatory=$True, ParameterSetName='TabPage', Position=0)]
        [Switch]$TP,
        [Parameter(Mandatory=$True, ParameterSetName='Panel', Position=0)]
        [Switch]$P,
        [Parameter(Mandatory=$True, ParameterSetName='GroupBox', Position=0)]
        [Switch]$G,
        [Parameter(Mandatory=$True, ParameterSetName='Label', Position=0)]
        [Switch]$L,
        [Parameter(Mandatory=$True, ParameterSetName='TextBox', Position=0)]
        [Switch]$TB,
        [Parameter(Mandatory=$True, ParameterSetName='RichTextBox', Position=0)]
        [Switch]$RTB,
        [Parameter(Mandatory=$True, ParameterSetName='MaskedTextBox', Position=0)]
        [Switch]$MTB,
        [Parameter(Mandatory=$True, ParameterSetName='ListBox', Position=0)]
        [Switch]$LB,
        [Parameter(Mandatory=$True, ParameterSetName='Button', Position=0)]
        [Switch]$B,
        [Parameter(Mandatory=$True, ParameterSetName='Checkbox', Position=0)]
        [Switch]$C,
        [Parameter(Mandatory=$True, ParameterSetName='RadioButton', Position=0)]
        [Switch]$R,

        [Parameter(Mandatory=$False, ParameterSetName='Form', Position=0)]
        [Parameter(Mandatory=$False, ParameterSetName='TabControl', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='Panel', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='GroupBox', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='Label', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='TextBox', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='RichTextBox', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='MaskedTextBox', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='ListBox', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='Button', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='Checkbox', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='RadioButton', Position=1)]
        [Int]$SX,

        [Parameter(Mandatory=$False, ParameterSetName='Form', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='TabControl', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='Panel', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='GroupBox', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='Label', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='TextBox', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='RichTextBox', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='MaskedTextBox', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='ListBox', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='Button', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='Checkbox', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='RadioButton', Position=2)]
        [Int]$SY,

        [Parameter(Mandatory=$False, ParameterSetName='TabControl', Position=3)]
        [Parameter(Mandatory=$False, ParameterSetName='Panel', Position=3)]
        [Parameter(Mandatory=$False, ParameterSetName='GroupBox', Position=3)]
        [Parameter(Mandatory=$False, ParameterSetName='Label', Position=3)]
        [Parameter(Mandatory=$False, ParameterSetName='TextBox', Position=3)]
        [Parameter(Mandatory=$False, ParameterSetName='RichTextBox', Position=3)]
        [Parameter(Mandatory=$False, ParameterSetName='MaskedTextBox', Position=3)]
        [Parameter(Mandatory=$False, ParameterSetName='ListBox', Position=3)]
        [Parameter(Mandatory=$False, ParameterSetName='Button', Position=3)]
        [Parameter(Mandatory=$False, ParameterSetName='Checkbox', Position=3)]
        [Parameter(Mandatory=$False, ParameterSetName='RadioButton', Position=3)]
        [Int]$LX,

        [Parameter(Mandatory=$False, ParameterSetName='TabControl', Position=4)]
        [Parameter(Mandatory=$False, ParameterSetName='Panel', Position=4)]
        [Parameter(Mandatory=$False, ParameterSetName='GroupBox', Position=4)]
        [Parameter(Mandatory=$False, ParameterSetName='Label', Position=4)]
        [Parameter(Mandatory=$False, ParameterSetName='TextBox', Position=4)]
        [Parameter(Mandatory=$False, ParameterSetName='RichTextBox', Position=4)]
        [Parameter(Mandatory=$False, ParameterSetName='MaskedTextBox', Position=4)]
        [Parameter(Mandatory=$False, ParameterSetName='ListBox', Position=4)]
        [Parameter(Mandatory=$False, ParameterSetName='Button', Position=4)]
        [Parameter(Mandatory=$False, ParameterSetName='Checkbox', Position=4)]
        [Parameter(Mandatory=$False, ParameterSetName='RadioButton', Position=4)]
        [Int]$LY,

        [Parameter(Mandatory=$False, ParameterSetName='Form', Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName='TabPage', Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName='Panel', Position=5)]
        [Parameter(Mandatory=$False, ParameterSetName='GroupBox', Position=5)]
        [Parameter(Mandatory=$False, ParameterSetName='Label', Position=5)]
        [Parameter(Mandatory=$False, ParameterSetName='TextBox', Position=5)]
        [Parameter(Mandatory=$False, ParameterSetName='RichTextBox', Position=5)]
        [Parameter(Mandatory=$False, ParameterSetName='MaskedTextBox', Position=5)]
        [Parameter(Mandatory=$False, ParameterSetName='Button', Position=5)]
        [Parameter(Mandatory=$False, ParameterSetName='Checkbox', Position=5)]
        [Parameter(Mandatory=$False, ParameterSetName='RadioButton', Position=5)]
        [String]$TE
    )

    If(@([AppDomain]::CurrentDomain.GetAssemblies() | Select FullName | ?{($_.FullName.Split(',')[0] -eq 'System.Drawing') -OR ($_.FullName.Split(',')[0] -eq 'System.Windows.Forms')}).Count -lt 2)
    {
        [void] $(Add-Type -AssemblyName 'System.Drawing')
        [void] $(Add-Type -AssemblyName 'System.Windows.Forms')

        [Void] [System.Windows.Forms.Application]::EnableVisualStyles()
    }

    If($TC)
    {
        $Temp = New-Object System.Windows.Forms.TabControl

        If(($Temp | Get-Member | ?{($_.Name -eq 'AddTab') -OR ($_.Name -eq 'AddTabs')}).Count -lt 2)
        {
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'AddTab' -Value {Param($Add) $This.TabPages.Add($Add)} -Force)
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'AddTabs' -Value {Param($Add) ($Add | %{$This.TabPages.Add($_)})} -Force)
        }
    }
    ElseIf($TP)
    {
        $Temp = New-Object System.Windows.Forms.TabPage
    }
    ElseIf($P)
    {
        $Temp = New-Object System.Windows.Forms.Panel
    }
    ElseIf($G)
    {
        $Temp = New-Object System.Windows.Forms.GroupBox
    }
    ElseIf($L)
    {
        $Temp = New-Object System.Windows.Forms.Label
    }
    ElseIf($TB -OR $RTB -OR $MTB)
    {
        If($TB)
        {
            $Temp = New-Object System.Windows.Forms.TextBox
        }
        ElseIf($RTB)
        {
            $Temp = New-Object System.Windows.Forms.RichTextBox
        }
        Else
        {
            $Temp = New-Object System.Windows.Forms.MaskedTextBox
            $Temp.PasswordChar = '•'
        }

        $Temp.Multiline = $True
        
        If(($Temp | Get-Member | ?{($_.Name -eq 'TexCh') -OR ($_.Name -eq 'KeyD')}).Count -lt 2)
        {
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'TexCh' -Value {Param($Add) $This.Add_TextChanged($Add)} -Force)
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'KeyD' -Value {Param($Add) $This.Add_KeyDown($Add)} -Force)
        }
    }
    ElseIf($LB)
    {
        $Temp = New-Object System.Windows.Forms.ListBox
        
        If(($Temp | Get-Member | ?{($_.Name -eq 'AddE') -OR ($_.Name -eq 'SelCh') -OR ($_.Name -eq 'SelM')}).Count -lt 3)
        {
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'AddE' -Value {Param($Add) $This.Items.Add($Add)} -Force)
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'SelCh' -Value {Param($Add) $This.SelectedValueChanged($Add)} -Force)
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'SelM' -Value {$This.SelectionMode = 'MultiExtended'} -Force)
        }
    }
    ElseIf($B)
    {
        $Temp = New-Object System.Windows.Forms.Button

        If(($Temp | Get-Member | ?{($_.Name -eq 'Cl')}).Count -lt 1)
        {
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'Cl' -Value {Param($Add) $This.Add_Click($Add)} -Force)
        }
    }
    ElseIf($C)
    {
        $Temp = New-Object System.Windows.Forms.CheckBox
    }
    ElseIf($R)
    {
        $Temp = New-Object System.Windows.Forms.RadioButton
    }
    Else
    {
        $Temp = New-Object System.Windows.Forms.Form

        If(($Temp | Get-Member | ?{($_.Name -eq 'Start')}).Count -lt 1)
        {
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'Start' -Value {[Void] $This.ShowDialog()} -Force)
        }

        $F = $True
    }

    If($F -OR $TC -OR $TP -OR $P -OR $G)
    {
        If(($Temp | Get-Member | ?{($_.Name -eq 'Ins') -OR ($_.Name -eq 'InsArr')}).Count -lt 2)
        {
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'Ins' -Value {Param($Add) $This.Controls.Add($Add)} -Force)
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'InsArr' -Value {Param($Add) [Void] ($Add | %{$This.Controls.Add($_)})} -Force)
        }
    }

    If($C -OR $R)
    {
        If(($Temp | Get-Member | ?{($_.Name -eq 'ChkCh')}).Count -lt 1)
        {
            [Void] ($Temp | Add-Member -PassThru -MemberType ScriptMethod -Name 'ChkCh' -Value {Param($Add) $This.Add_CheckedChanged($Add)} -Force)
        }
    }

    If($TE)
    {
        $Temp.Text = $TE
    }

    $Temp.Font = New-Object System.Drawing.Font('Lucida Console',8.25,[System.Drawing.FontStyle]::Regular)
    
    $Temp.Location = New-Object System.Drawing.Size($LX,$LY)
    $Temp.Size = New-Object System.Drawing.Size($SX,$SY)

    Return $Temp
}

Function NL
{
    Param($X)

    Return $(If($X){(1..([Math]::Abs([Int]$X)) | %{[Environment]::NewLine}) -join ''}Else{[Environment]::NewLine})
}

Function HideConsole
{
    $(Add-Type -Name Window -NameSpace Console -MemberDefinition '
    [DllImport("Kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);') 2> $Null

    $Hide = [Console.Window]::GetConsoleWindow()
    [Void][Console.Window]::ShowWindow($Hide, 0)
}
