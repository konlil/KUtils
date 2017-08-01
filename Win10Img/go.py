import os
import getpass
import imghdr
from shutil import copyfile

user = getpass.getuser()
path = r'c:\users\%s\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets' % user
target = r'C:\Users\%s\Pictures\win10' % user

if not os.path.isdir(target):
	os.mkdir(target)

for f in os.listdir(path):
	fullpath = os.path.join(path, f)
	filetype = imghdr.what(fullpath)
	if filetype in ['jpeg', 'png']:
		targetfile = os.path.join(target, f+'.'+filetype)
		copyfile(fullpath, targetfile)
