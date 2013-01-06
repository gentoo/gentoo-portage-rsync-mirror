# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-starwars/fortune-mod-starwars-0.1.ebuild,v 1.15 2010/12/12 09:27:19 grobian Exp $

MY_P=${PN/-mod/}
DESCRIPTION="Quotes from StarWars, The Empire Strikes Back, and Return of the Jedi"
HOMEPAGE="http://www.splitbrain.org/projects/fortunes/starwars"
SRC_URI="http://www.splitbrain.org/_media/projects/fortunes/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""
RESTRICT="mirror"

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_P}

src_install() {
	insinto /usr/share/fortune
	doins starwars starwars.dat || die
}
