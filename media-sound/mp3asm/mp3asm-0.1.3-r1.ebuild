# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3asm/mp3asm-0.1.3-r1.ebuild,v 1.12 2005/08/07 13:27:24 hansmi Exp $

IUSE=""

MY_P=${PN}-${PV}-${PR/r/}
DESCRIPTION="A command line tool to clean and edit mp3 files."
HOMEPAGE="http://sourceforge.net/projects/mp3asm/"
SRC_URI="mirror://sourceforge/mp3asm/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

DEPEND=""

# the author uses weird numbering...
S=${WORKDIR}/mp3asm-0.1

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodoc README
	dobin src/mp3asm
}
