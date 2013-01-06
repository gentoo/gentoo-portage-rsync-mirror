# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/wikipedia-syntax/wikipedia-syntax-20101113.ebuild,v 1.7 2012/12/04 08:34:31 radhermit Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Wikipedia syntax highlighting"
HOMEPAGE="http://en.wikipedia.org/wiki/Wikipedia:Text_editor_support#Vim"
LICENSE="CCPL-Attribution-ShareAlike-3.0"
KEYWORDS="amd64 ~hppa ~mips ppc ppc64 x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for Wikipedia article
files. Detection is by filename (*.wiki)."
VIM_PLUGIN_MESSAGES="filetype"
