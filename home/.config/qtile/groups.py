from libqtile.config import Group, Match

group_keys = 'nrtdgfq'

groups = []
groups.append(Group('urxvt', spawn='urxvt -e bash -c "tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$HOSTNAME"', exclusive=True, layout='max'))
groups.append(Group('browser', spawn='firefox', layout='max'))
groups.append(Group('chat', spawn='franz', layout='max'))
groups.append(Group('music', spawn='spotify', layout='max', matches=[Match(wm_class=["spotify", "Spotify"])]))


for i in range(len(group_keys)-len(groups)):
    groups.append(Group('misc'))