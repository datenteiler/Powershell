$VIMPATH    = "C:\Program Files (x86)\Vim\vim73\vim.exe"
 
Set-Alias vi   $VIMPATH
Set-Alias vim  $VIMPATH
 
# for editing your PowerShell profile
Function Edit-Profile
{
    vim $profile
}
 
# for editing your Vim settings
Function Edit-Vimrc
{
    vim $home\_vimrc
}

# Load posh-git example profile
. 'C:\Users\Christian\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1'

