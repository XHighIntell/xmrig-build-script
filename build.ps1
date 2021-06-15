using namespace System.IO
using namespace System.Net

##############      Github Sourcecode - Input      ##############
$xmrig_repository       = "https://github.com/xmrig/xmrig";
$xmrig_version          = "6.12.2";

$xmrig_deps_repository  = "https://github.com/xmrig/xmrig-deps";
$xmrig_deps_version     = "4.1";

$output_folder          = "C:\build";
#################################################################
$ErrorActionPreference = "Stop";
$env:PATH += ";C:\Program Files\7-Zip";
$env:PATH += ";E:\Programs\cmake-3.20.3-windows-x86_64\bin";
. .\"tools.ps1"


<# 
   0. Prepare variable
   1. Dowload github archive from github
   2. Extract to build folder
   3. Create c++ project
   4. Build
#>

# -- 0 --
$output_folder           = [Path]::GetFullPath($output_folder);
$xmrig_archive_path      = [Path]::Combine($output_folder, "xmrig-" + $xmrig_version + ".zip");           # build\xmrig-6.12.2.zip
$xmrig_extract_path      = [Path]::Combine($output_folder, "xmrig");                                      # build\xmrig
$xmrig_deps_archive_path = [Path]::Combine($output_folder, "xmrig-deps-" + $xmrig_deps_version + ".zip"); # build\xmrig-deps-4.1.zip
$xmrig_deps_extract_path = [Path]::Combine($output_folder, "xmrig-deps");                                 # build\xmrig-deps


# -- 1 --
[Directory]::CreateDirectory($output_folder) > $null
DownloadGithubArchive $xmrig_repository      $xmrig_version      $xmrig_archive_path
DownloadGithubArchive $xmrig_deps_repository $xmrig_deps_version $xmrig_deps_archive_path

# -- 2 --
ExtractGithubArchive $xmrig_archive_path      $xmrig_extract_path;      Write-Host "Extracted " -NoNewline; Write-Host $xmrig_archive_path -F Cyan;
ExtractGithubArchive $xmrig_deps_archive_path $xmrig_deps_extract_path; Write-Host "Extracted " -NoNewline; Write-Host $xmrig_deps_archive_path -F Cyan;


# -- 3 --
$cmake_project_path = $output_folder + "\output";
[Directory]::CreateDirectory($cmake_project_path) > $null
$DXMRIG_DEPS = [Path]::GetFullPath([Path]::Combine($xmrig_deps_extract_path, "msvc2019\x64"));
cmake -H"$xmrig_extract_path" -B"$cmake_project_path" -G "Visual Studio 16 2019" -A x64 -DXMRIG_DEPS="$DXMRIG_DEPS"

# -- 4 --
cmake --build "$cmake_project_path" --config Release




