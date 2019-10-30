#!/usr/bin/python3

from gi import require_version
require_version("Playerctl", "2.0")
from gi.repository import Playerctl, GLib
from json import dumps
from sys import stdout

manager = Playerctl.PlayerManager()

def dump_output(output):
    print(dumps(output))
    stdout.flush()

def on_metadata(player, metadata):
    if player.get_property("status") == "Paused":
        return
    if "xesam:artist" in metadata.keys() and "xesam:title" in metadata.keys():
        output = {'text': '{artist} - {title}'.format(artist=metadata['xesam:artist'][0], title=metadata['xesam:title']), 'class': 'playing'}
        dump_output(output)

def on_pause(player, status):
    artist = player.get_artist()
    title = player.get_title()
    if artist and title:
        output = {'text': 'Paused <span color="#F00">({a} - {t})</span>'.format(a=artist, t=title), 'class': 'paused'}
        dump_output(output)

def init_player(name):
    if name.name == "spotify":
        player = Playerctl.Player.new_from_name(name)
        player.connect('metadata', on_metadata)
        player.connect('playback-status::paused', on_pause)

        playback_status = player.get_property("status")
        artist = player.get_artist()
        title = player.get_title()
        if playback_status == "Paused":
            output = {'text': 'Paused <span color="#F00">({a} - {t})</span>'.format(a=artist, t=title), 'class': 'paused'}
        else:
            output = {"text": "{artist} - {title}".format(artist=artist, title=title), "class": "playing"}
        dump_output(output)

        manager.manage_player(player)

def on_name_appeared(manager, name):
    init_player(name)

def on_player_vanished(manager, player):
    if player.props.player_name == "spotify":
        dump_output({"text": "Spotify not running"})

if __name__ == "__main__":
    manager.connect('name-appeared', on_name_appeared)
    manager.connect('player-vanished', on_player_vanished)

    dump_output({"text": "Spotify not running"})

    for name in manager.props.player_names:
        init_player(name)

    main = GLib.MainLoop()
    main.run()
