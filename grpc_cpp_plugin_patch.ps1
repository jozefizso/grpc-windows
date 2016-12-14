
$projFile = $(get-location).Path + "\grpc\vsprojects\vcxproj\grpc_cpp_plugin\grpc_cpp_plugin.vcxproj"

[xml]$project = Get-Content $projFile

$items = $project.CreateElement("ItemGroup", $project.DocumentElement.NamespaceURI)
$rc = $project.CreateElement("ResourceCompile", $project.DocumentElement.NamespaceURI)
$rc.SetAttribute("Include", "`$(SolutionDir)\..\src\compiler\cpp_plugin.rc")

$items.AppendChild($rc)
$project.Project.AppendChild($items)

$project.Save($projFile)
