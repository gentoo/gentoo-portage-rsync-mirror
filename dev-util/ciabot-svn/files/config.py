# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ciabot-svn/files/config.py,v 1.1 2005/04/11 01:18:00 trapni Exp $

# This file contains contents stripped out from upstream ciabot_svn.py
# script in order to allow convient end-user config file management.
#
# Please adapt this file to your needs.

class config:
    # Replace this with your project's name, or always provide a project
    # name on the commandline.
    #
    # NOTE: This shouldn't be a long description of your project. Ideally
    #       it is a short identifier with no spaces, punctuation, or
    #       unnecessary capitalization. This will be used in URLs related
    #       to your project, as an internal identifier, and in IRC messages.
    #       If you want a longer name shown for your project on the web
    #       interface, please use the "title" metadata key rather than
    #       putting that here.
    #
    project = "YOUR_PROJECT_NAME_HERE"

    # Subversion's normal directory hierarchy is powerful enough that
    # it doesn't have special methods of specifying modules, tags, or
    # branches like CVS does.  Most projects do use a naming
    # convention though that works similarly to CVS's modules, tags,
    # and branches.
    #
    # This is a list of regular expressions that are tested against
    # paths in the order specified. If a regex matches, the 'branch'
    # and 'module' groups are stored and the matching section of the
    # path is removed.
    #
    # Several common directory structure styles are below as defaults.
    # Uncomment the ones you're using, or add your own regexes.
    # Whitespace in the each regex are ignored.

    pathRegexes = [
    #   r"^ trunk/           (?P<module>[^/]+)/ ",
    #   r"^ (branches|tags)/ (?P<branch>[^/]+)/ ",
    #   r"^ (branches|tags)/ (?P<module>[^/]+)/ (?P<branch>[^/]+)/ ",
        ]

    # If your repository is accessable over the web, put its base URL here
    # and 'uri' attributes will be given to all <file> elements. This means
    # that in CIA's online message viewer, each file in the tree will link
    # directly to the file in your repository
    repositoryURI = None

    # This can be the http:// URI of the CIA server to deliver commits over
    # XML-RPC, or it can be an email address to deliver using SMTP. The
    # default here should work for most people. If you need to use e-mail
    # instead, you can replace this with "cia@cia.navi.cx"
    server = "http://cia.navi.cx"

    # The SMTP server to use, only used if the CIA server above is an
    # email address
    smtpServer = "localhost"

    # The 'from' address to use. If you're delivering commits via email, set
    # this to the address you would normally send email from on this host.
    fromAddress = "cia-user@localhost"

    # When nonzero, print the message to stdout instead of delivering it to CIA
    debug = 0

