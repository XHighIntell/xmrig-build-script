




function DownloadGithubArchive([string]$repository, [string]$version, [string]$filename) {
    # repository = https://github.com/xmrig/xmrig
    # version    = 6.12.2
    # filename   = xmrig-6.12.2.zip
    
    $name = [Path]::GetFileName($repository);     # "xmrig"


    if ([File]::Exists($filename) -eq $false) {
        # url = https://github.com/xmrig/xmrig/archive/refs/tags/v6.12.2.zip
        $url = $repository + "/archive/refs/tags/v" + $version + ".zip";
        $client = [WebClient]::new();
        $client.DownloadFile($url, $filename); Write-Host "Downloaded " -NoNewline; Write-Host $filename -F Cyan;
        $client.Dispose();
    } else {
        Write-Host "Skipped downloading " -NoNewline; Write-Host $filename -F Cyan -NoNewline; Write-Host " (Already existed)"
    }

}

function ExtractGithubArchive([string]$filename, [string]$output) {
    # filename = C:\build\xmrig-6.12.2.zip
    # output   = C:\build\xmrig
    
    $tmp = [Path]::GetFullPath([Path]::Combine($filename, "..", "tmp")); # C:\build\tmp

    7z.exe x $filename -o"$tmp" -aoa > $null;  

    $name = [Path]::GetFileNameWithoutExtension($filename);
    [Directory]::Move($tmp + "\" + $name, $output);
    [Directory]::Delete($tmp);

}














