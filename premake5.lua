-- premake5.lua
workspace "EquirectangleToCubemap"
	architecture "x64"
	startproject "EquirectangleToCubemap"
	configurations { "Debug", "Release", "Distribution" }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "EquirectangleToCubemap"
	kind "ConsoleApp"
	language "C++"
	staticruntime "off"
   
	targetdir ("bin/" ..outputdir.. "/%{prj.name}")
	objdir ("bin-int/" ..outputdir.. "/%{prj.name}")

	files
	{
		"src/**.h",
		"src/**.cpp"
	}
	
	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"
		
		
	filter "configuration.Debug"
		defines "DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configuration.Release"
		defines "RELEASE"
		runtime "Release"
		optimize "On"
		
	filter "configuration.Distribution"
		defines "YE_DISTRIBUTION"
	runtime "Release"
		optimize "On"