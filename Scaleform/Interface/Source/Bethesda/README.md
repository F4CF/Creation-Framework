# Scaleform
This is the root package directory for AS3 imports.
These Flash documents reflect the vanilla UI libraries.

<BR>**Fallout 4:** `v1.10.138.3908801`
<BR>**FFDec:** `v11.2.0.1722`

# Tools
- [Adobe Flash](https://en.wikipedia.org/wiki/Adobe_Flash) or [Adobe Animate](https://en.wikipedia.org/wiki/Adobe_Animate)
- [JPEXS Free Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler/releases) (aka FFDec)

# [Autodesk Scaleform Documentation](https://help.autodesk.com/view/SCLFRM/ENU/)
* [Font and Text Configuration Overview](https://help.autodesk.com/view/SCLFRM/ENU/?guid=__scaleform_help_font_html)
* [Scaleform Game Communication Overview](https://help.autodesk.com/view/SCLFRM/ENU/?guid=__scaleform_help_game_communication_html)
* [AS3 Extensions Reference](https://help.autodesk.com/view/SCLFRM/ENU/?guid=__scaleform_help_as3_reference_html)

# Issues
* `Source\Bethesda\Shared\AS3\BSScrollingList.as`:  Figure out which variable(s) are used between `bAllowWheelScrollNoSelectionChange` & `bAllowSelectionDisabledListNav`.
* The `PipboyMenu.swf` uses a version of `Shared\AS3\BSScrollingList.as` with an additional boolean variable called `bAllowSelectionDisabledListNav`.
* PipboyMenu could possibly use finer tweaking of the page header textfields. Its pretty dang close already though.
* HUDMenu ammo counter seems messed up. Incorrect counting.
