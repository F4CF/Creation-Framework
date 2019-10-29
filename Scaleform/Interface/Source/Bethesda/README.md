# Scaleform
This is the root package directory for AS3 imports.
These Flash documents reflect the vanilla UI libraries.
<BR>**Fallout 4:** `v1.10.138.3908801`
<BR>**FFDec:** `v11.2.0.1722`

# Tools
- [Adobe Flash](https://en.wikipedia.org/wiki/Adobe_Flash) or [Adobe Animate](https://en.wikipedia.org/wiki/Adobe_Animate)
- [JPEXS Free Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler/releases) (aka FFDec)
- [Font Forge](https://fontforge.github.io/en-US/) & [Font Forge - Common Problems](https://fontforge.github.io/problems.html)

# [Autodesk Scaleform Documentation](https://help.autodesk.com/view/SCLFRM/ENU/)
* [Font and Text Configuration Overview](https://help.autodesk.com/view/SCLFRM/ENU/?guid=__scaleform_help_font_html)
* [Scaleform Game Communication Overview](https://help.autodesk.com/view/SCLFRM/ENU/?guid=__scaleform_help_game_communication_html)
* [AS3 Extensions Reference](https://help.autodesk.com/view/SCLFRM/ENU/?guid=__scaleform_help_as3_reference_html)

# Fonts
This section provides details for the font libraries used by Fallout 4.

#### Fonts Not Included
* [Arial](https://docs.microsoft.com/en-us/typography/font-list/arial)
* [Courier New](https://docs.microsoft.com/en-us/typography/font-list/courier-new)
* [Roboto](https://fonts.google.com/specimen/Roboto)

#### Font Symbol Mappings
```
map "$HandwrittenFont" = "Handwritten_Institute" Normal
map "$MAIN_Font" = "Roboto Condensed" Normal
map "$MAIN_Font_Bold" = "Roboto Condensed" Bold
map "$Terminal_Font" = "Share-TechMono" Normal
map "$Controller_Buttons" = "Controller  Buttons" Normal
map "$Controller_Buttons_inverted" = "Controller  Buttons inverted" Normal
map "$ConsoleFont" = "Arial" Normal
map "$DebugTextFont" = "Consolas" Normal
map "$BRODY" = "Brody" Bold
map "$CClub_Font" = "Eurostile LT Std" Roman
map "$CClub_Font_Bold" = "Eurostile LT Std" Demi
```

#### Embedded Fonts
* `Adventure.ttf`
* `Press Start 2P.ttf`
* `vir2L_Medium.ttf`


# Issues
* The original fonts were damaged by the extraction process.
* `Source\Bethesda\Shared\AS3\BSScrollingList.as`:  Figure out which variable(s) are used between `bAllowWheelScrollNoSelectionChange` & `bAllowSelectionDisabledListNav`.
* The `PipboyMenu.swf` uses a version of `Shared\AS3\BSScrollingList.as` with an additional boolean variable called `bAllowSelectionDisabledListNav`.
* PipboyMenu could possibly use finer tweaking of the page header textfields. Its pretty dang close already though.
* HUDMenu ammo counter seems messed up. Incorrect counting.

#### Issue - Controller_Buttons_inverted (Normal)
```
Bad Font name

The PostScript font name "Controller  Buttons inverted" is invalid.
It should be printable ASCII,
must not contain (){}[]<>%/ or space
and must be shorter than 63 characters
```
```
Warnings

The following table(s) in the fonts have been ignored by FontForge.
	Ignoring 'hdmx' horizontal device metrics table.
In GID 13 the advance width (64853) is greater than the stated maximum (1610)
	Subsequent errors will not be reported.
```
