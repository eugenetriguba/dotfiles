#!/bin/python3

import argparse
import os
from pathlib import Path
import sys
from typing import Union


def get_filelist(path: Union[str, Path]) -> list:
    """
    Retrieve a list of files from a given path.

    Example:
        >>> print(get_filelist('/home/eugene/Pictures/')
        [('file.txt', '/home/eugene/Pictures', 353859)]

    Args:
        path: The path to search for files.

    Returns:
        A list of files with the file name, directory it is in, and its st_ino.
        The st_ino is a unique identifier for a file, typically the inode number
        in Unix and file index on Windows.
    """
    filelist = []

    for subdir, dirs, files in os.walk(path):
        for file in dirs + files:
            if file[0] == '.' or file[-1] == '~':
                continue

            lstat = os.lstat(os.path.join(subdir, file))
            filelist.append((file, subdir, lstat.st_ino))

    return filelist


if __name__ == '__main__':
   parser = argparse.ArgumentParser(
       prog='list_dir',
       description='Retrieve a list of files from a directory'
    )
   parser.add_argument('path', type=str, help='The path to search')
   parser.add_argument('-of', '--only-filename', action='store_true', help='list only the filenames')
   parser.add_argument('-s', '--sort', action='store_true', help='sort the list of files')
   args = parser.parse_args()

   filelist = get_filelist(args.path)

   if args.sort:
       filelist.sort(key = lambda x: x[0])

   for filename, subdir, ino in filelist:
       if args.only_filename:
           print(filename)
       else:
           print(f'{ino} {subdir} {filename}')



