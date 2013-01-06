# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/eselect-syntax/eselect-syntax-20070506.ebuild,v 1.14 2010/10/07 03:13:25 leio Exp $

inherit eutils vim-plugin

DESCRIPTION="vim plugin: Eselect syntax highlighting, filetype and indent settings"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="vim"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"

DEPEND="!<app-vim/gentoo-syntax-20070506"
RDEPEND="${DEPEND}"

IUSE=""

VIM_PLUGIN_HELPFILES="${PN}"
VIM_PLUGIN_MESSAGES="filetype"
