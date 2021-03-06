from libqtile import bar, widget

soft_sep = {'linewidth': 2, 'size_percent': 70,
            'foreground': '393939', 'padding': 7}

icon_theme_path = '/usr/share/icons/AwOkenWhite/clear/24x24/status/'
main_bar = bar.Bar(
        [
            widget.GroupBox(),
            widget.Sep(linewidth=2, size_percent=100, padding=12),
            widget.CurrentLayout(),
            widget.Sep(linewidth=2, size_percent=100, padding=12),
            widget.Mpris2(background='253253', name='spotify',
                          stop_pause_text='▶', scroll_chars=None,
                          display_metadata=['xesam:title', 'xesam:artist'],
                          objname="org.mpris.MediaPlayer2.spotify"),
            widget.Prompt(),
            widget.Volume(theme_path=icon_theme_path),
            widget.WindowName(),
            widget.Net(interface='wlp2s0'),
            widget.Systray(icon_size=72),
            widget.Sep(**soft_sep),
            widget.Battery(foreground='247052', low_percentage=0.20,
                           low_foreground='fa5e5b', update_delay=10,
                           format='{percent:.0%} {hour:d}:{min:02d} '
                           '{watt:.2}W'),
            widget.Sep(**soft_sep),
            widget.Clock(timezone='Europe/Paris', format='%B %-d, %H:%M'),
            ], 70)

# bar.Bar(
#             [
#                 widget.CurrentLayout(),
#                 widget.Sep(),
#                 widget.GroupBox(),
#                 widget.Prompt(),
#                 widget.Sep(),
#                 widget.WindowName(),
#                 widget.Net(interface='wlp2s0'),
#                 widget.Sep(),
#                 widget.Battery(),
#                 widget.Sep(),
#                 widget.BitcoinTicker(currency='EUR'),
#                 widget.Sep(),
#                 widget.Systray(icon_size=46),
#                 widget.Sep(),
#                 widget.Clock(format='%Y-%m-%d %a %H:%M'),
#             ],
#             45,
#         )
