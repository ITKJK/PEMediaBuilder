# PEMediaBuilder

Windows PE media builder from NT 6.0 to NT 10.1.22000.1 (and later)

I'll start by adding a CMD or batch script I needed myself few years ago, something I had to build for myself few years ago in timeline of NT 6.0, because microsoft Windows PE at NT6.0 to latest 10.1.22000.1 all has quite a few bugs while building the media while including components which needs to be in right order while you add them to media which even Microsoft (any of their pages) informs wrong for everyone. So, it's really f'd up to test what components goes in and in which order for every single ADK and PE you build.

(Anyone reading this has to excuse me as I use build numbers instead of OS names since it's easier for me to understand which systems all works.)


Usage:

1. Install Deployment Tools and PE from Microsoft ADK [anything from Windows 7 (NT6.0) to Windows 11 (NT10.1)].
2. Copy 'BUILD-PE-MEDIA.CMD' to 'INSTALLATIONPATH\Assessment and Deployment Kit\Windows Preinstallation Environment'.
3. Open 'Deployment and Imaging Tools Environment' from start menu (or what ever metro you use).
4. run 'BUILD-PE-MEDIA.CMD' and follow instuctions.

This is multilanguage build with separate input and additional languages including language supported features. The script will ask input, default languages
and memory or RAM allocation for PE since somethings like DISM won't fly without at least 1,5GB of scratch space maximum being 2047MB.
