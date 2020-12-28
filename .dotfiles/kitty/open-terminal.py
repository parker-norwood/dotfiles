 # Original: https://gitlab.gnome.org/GNOME/nautilus-python/-/blob/0287f32431eadce9b9becd1ec35ddac0c56ea98e/examples/open-terminal.py

# This example is contributed by Martin Enlund
import os
import getpass

# A way to get unquote working with python 2 and 3
try:
    from urllib import unquote
except ImportError:
    from urllib.parse import unquote

import gi

gi.require_version('GConf', '2.0')
# NOTE: "PyGIWarning: Nautilus was imported without specifying a version first." is raised in the nautilus-python package, not this file.
gi.require_version('Nautilus', '3.0')

from gi.repository import Nautilus, GObject, GConf

class OpenTerminalExtension(Nautilus.MenuProvider, GObject.GObject):
    def __init__(self):
        self.client = GConf.Client.get_default()
        
    def _open_terminal(self, file):
        if file.get_uri_scheme() == 'x-nautilus-desktop':
            filename = unquote('/home/%s' % getpass.getuser())
        else:
            filename = unquote(file.get_uri()[7:])
        

        os.chdir(filename)
        os.system('kitty')
        
    def menu_activate_cb(self, menu, file):
        self._open_terminal(file)
        
    def menu_background_activate_cb(self, menu, file):
        self._open_terminal(file)
       
    def get_file_items(self, window, files):
        if len(files) != 1:
            return
        
        file = files[0]
        if not file.is_directory() or file.get_uri_scheme() != 'file':
            return
       
        item = Nautilus.MenuItem(name='NautilusPython::openterminal_file_item',
                                 label='Open in Terminal' ,
                                 tip='Open Terminal In %s' % file.get_name())
        item.connect('activate', self.menu_activate_cb, file)
        return item,

    def get_background_items(self, window, file):
        item = Nautilus.MenuItem(name='NautilusPython::openterminal_file_item2',
                                 label='Open in Terminal' ,
                                 tip='Open Terminal In %s' % file.get_name())
        item.connect('activate', self.menu_background_activate_cb, file)
        return item,
