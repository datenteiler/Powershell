$VIMPATH    = "C:\Program Files (x86)\Vim\vim73\vim.exe"
 
Set-Alias vi   $VIMPATH
Set-Alias vim  $VIMPATH
Set-Alias edit $VIMPATH
 
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

