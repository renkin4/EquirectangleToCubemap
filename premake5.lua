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
		"src/**.cpp",
	}
 
	excludes 
	{ 
		"src/vendor/**.cpp",
		"src/vendor/**.h",
	}

	includedirs
	{
		"src",
		"src/vendor/OpenCV/build/include",
	}

	libdirs 
	{
		"src/vendor/OpenCV/build/x64/vc15/lib"
	}	

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"
		
	filter "configurations:Debug"
		links { "opencv_world455d.lib", }
		prebuildcommands 
		{ 
			"{COPY} src/vendor/OpenCV/build/x64/vc15/bin/opencv_world455d.dll bin/" ..outputdir.. "/%{prj.name}",  
			"{COPY} src/vendor/OpenCV/build/x64/vc15/bin/opencv_world455d.pdb bin/" ..outputdir.. "/%{prj.name}"
		}
		defines "DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		links{ "opencv_world455.lib", }
		defines "NDEBUG"
		runtime "Release"
		optimize "On"
		
	filter "configurations:Distribution"
		links{ "opencv_world455.lib", }
		defines "NDEBUG"
	runtime "Release"
		optimize "On"