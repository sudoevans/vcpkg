# Copyright (c) Microsoft Corporation.
# SPDX-License-Identifier: MIT

param([string]$SasToken)

if (Test-Path "$PSScriptRoot/utility-prefix.ps1") {
  . "$PSScriptRoot/utility-prefix.ps1"
}

# See https://learn.microsoft.com/visualstudio/releases/2022/release-history
# 17.14.8
$VisualStudioBootstrapperUrl = 'https://download.visualstudio.microsoft.com/download/pr/f55fba7b-3f02-49b7-9aca-a075049a807d/9aca214a7c2982c847582af89b9168b876cc5d4041ae64b6cb677f3ff7236388/vs_Enterprise.exe'
$Workloads = @(
  'Microsoft.VisualStudio.Workload.NativeDesktop',
  'Microsoft.VisualStudio.Workload.Universal',
  'Microsoft.VisualStudio.Component.UWP.VC.ARM64',
  'Microsoft.VisualStudio.Component.VC.Tools.x86.x64',
  'Microsoft.VisualStudio.Component.VC.Tools.ARM64',
  'Microsoft.VisualStudio.Component.VC.ASAN',
  'Microsoft.VisualStudio.Component.VC.ATL',
  'Microsoft.VisualStudio.Component.VC.ATLMFC',
  'Microsoft.VisualStudio.Component.VC.ATL.ARM64',
  'Microsoft.VisualStudio.Component.VC.MFC.ARM64',
  'Microsoft.VisualStudio.Component.Windows11SDK.26100',
  'Microsoft.VisualStudio.Component.Windows10SDK.20348', # As of 2024-11-15, CMake explicitly needs a Windows 10 SDK for Store
  # These .NET parts are needed for easyhook, openni2
  'Microsoft.Net.Component.4.8.SDK',
  'Microsoft.Net.Component.4.7.2.TargetingPack',
  'Microsoft.Component.NetFX.Native',
  'Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset',
  'Microsoft.VisualStudio.Component.VC.Llvm.Clang',
  'Microsoft.VisualStudio.ComponentGroup.UWP.VC.BuildTools',
  'Microsoft.VisualStudio.Component.VC.CMake.Project'
)

$vsArgs = @('--quiet', '--norestart', '--wait', '--nocache')
foreach ($workload in $Workloads) {
  $vsArgs += '--add'
  $vsArgs += $workload
}

DownloadAndInstall -Name 'Visual Studio' -Url $VisualStudioBootstrapperUrl -Args $vsArgs
