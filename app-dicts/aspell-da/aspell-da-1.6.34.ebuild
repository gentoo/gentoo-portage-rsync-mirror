# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-da/aspell-da-1.6.34.ebuild,v 1.9 2012/08/26 18:30:33 armin76 Exp $

ASPELL_LANG="Danish"

inherit aspell-dict

LICENSE="GPL-2"
HOMEPAGE="http://da.speling.org"

KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~ppc-macos"
IUSE=""

SRC_URI="http://da.speling.org/filer/new_${P}.tar.bz2"

S="${WORKDIR}/new_${P}"
