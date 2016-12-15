
$propPath = $(get-location).Path + "\grpc\vsprojects\global.props"

[xml]$prop = Get-Content $propPath

$newElem = $prop.CreateElement("DisableSpecificWarnings", $prop.DocumentElement.NamespaceURI)
$newElem.set_InnerXML("4819;%(DisableSpecificWarnings)")
$prop.Project.ItemDefinitionGroup.ClCompile.AppendChild($newElem)
$prop.Project.ItemDefinitionGroup.ClCompile.RemoveAttribute("xmlns");

$debugSymbols = $prop.CreateElement("DebugSymbols", $prop.DocumentElement.NamespaceURI)
$debugSymbols.InnerText = "true"
$prop.Project.PropertyGroup[1].AppendChild($debugSymbols)

$prop.Save($propPath)
