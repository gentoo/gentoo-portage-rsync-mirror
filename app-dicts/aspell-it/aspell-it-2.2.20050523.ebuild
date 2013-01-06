# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-it/aspell-it-2.2.20050523.ebuild,v 1.18 2012/05/17 20:02:21 aballier Exp $

ASPELL_LANG="Italian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE=""

FILENAME="aspell6-it-2.2_20050523-0"
SRC_URI="mirror://gnu/aspell/dict/it/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}
