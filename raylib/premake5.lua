newoption
{
    trigger = "graphics-api",
    value = "OPENGL_VERSION",
    description = "version of OpenGL to build raylib against",
    allowed = {
	    { "opengl11", "OpenGL 1.1"},
	    { "opengl21", "OpenGL 2.1"},
	    { "opengl33", "OpenGL 3.3"},
	    { "opengl43", "OpenGL 4.3"}
    },
    default = "opengl33"
}

newoption
{
    trigger = "wayland",
    description = "use Wayland window system"
}

function platform_defines()
    defines{"PLATFORM_DESKTOP"}

    filter {"options:graphics=opengl43"}
        defines{"GRAPHICS_API_OPENGL_43"}

    filter {"options:graphics=opengl33"}
        defines{"GRAPHICS_API_OPENGL_33"}

    filter {"options:graphics=opengl21"}
        defines{"GRAPHICS_API_OPENGL_21"}

    filter {"options:graphics=opengl11"}
        defines{"GRAPHICS_API_OPENGL_11"}

    filter {"system:linux", "options:wayland"}
        defines{"_GLFW_WAYLAND"}

    filter{}
end



project "raylib"
    kind "StaticLib"

    platform_defines()

    language "C"
    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}
        characterset ("MBCS")

    filter{}

    includedirs 
    {
        "raylib/raylib/src/",
        "raylib/raylib/src/external/glfw/include/",
        "raylib/raylib/src/external/glfw/deps/" 
    }
    files 
    {
        "raylib/raylib/src/*.h", 
        "raylib/raylib/src/*.c"
    }
