$ErrorActionPreference = 'Stop'

$urlBase = "https://www.scootersoftware.com"
$LCID = (Get-Culture).LCID
$german = @(3079,1031,5127,4103,2055)
$french = @(2060,11276,3084,9228,12300,1036,5132,13324,6156,14348,10252,4108,7180)
$japanese = @(17, 1041)

$version = '3.3.13.18981'

$packageArgs = @{
  packageName   = 'beyondcompare'
  fileType      = 'exe'
  url           = $url
  silentArgs = '/SP- /VERYSILENT /NORESTART'

  checksum      = ''
  checksumType  = 'sha256'
}

$checksumde = '19FBB60C5D522A40D77971F788DBFF408D2E3CD7F47694E4F99CF1D67EECE485'
$checksumfr = '0AA3E42843CC69E898037908A215DA33E18A80D2E80D80D069908A8046AE20FF'
$checksumjp = '267ADEAAA57CE076E690B3E357A735CCE3E032A88B84265DE0C965C52CBBA5D1'
$checksum = '01BB556FAACE02CBFA2CD000E4692105F1EB8F8C80A2CCBDF22A32484725B448'

if ($german -contains $LCID)
{
    $packageArgs.url = "$urlBase/BCompare-de-$version.exe"
    $packageArgs.checksum = $checksumde
}
elseif ($french -contains $LCID)
{
    $packageArgs.url = "$urlBase/BCompare-fr-$version.exe"
    $packageArgs.checksum = $checksumfr
}
elseif ($japanese -contains $LCID)
{
    $packageArgs.url = "$urlBase/BCompare-jp-$version.exe"
    $packageArgs.checksum = $checksumjp
}
else
{
    $packageArgs.url = "$urlBase/BCompare-$version.exe"
    $packageArgs.checksum = $checksum
}

# This is necessary to avoid Invoke-WebRequest failing with "The request was aborted: Could not create SSL/TLS secure channel."
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Install-ChocolateyPackage @packageArgs
