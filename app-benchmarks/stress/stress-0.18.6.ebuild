# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/stress/stress-0.18.6.ebuild,v 1.9 2011/02/06 05:24:34 leio Exp $

inherit flag-o-matic

MY_P="${PN}-${PV/_/}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Imposes stressful loads on different aspects of the system."
HOMEPAGE="http://weather.ou.edu/~apw/projects/stress"
SRC_URI="http://weather.ou.edu/~apw/projects/stress/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 ~sparc x86"
IUSE="static"

src_compile() {
	use static && append-ldflags -static
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS README
}
