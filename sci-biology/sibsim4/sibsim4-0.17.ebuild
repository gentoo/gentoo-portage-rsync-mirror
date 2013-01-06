# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/sibsim4/sibsim4-0.17.ebuild,v 1.2 2009/04/04 19:21:04 maekke Exp $

DESCRIPTION="A rewrite and improvement upon sim4, a DNA-mRNA aligner"
HOMEPAGE="http://sibsim4.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/SIBsim4-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/SIBsim4-${PV}"

src_unpack() {
	unpack ${A}
	sed -i 's/CFLAGS = \(.*\)/CFLAGS := \1 ${CFLAGS}/' "${S}/Makefile"
}

src_install() {
	dobin SIBsim4
	doman SIBsim4.1
}
