# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dd-rescue/dd-rescue-1.10.ebuild,v 1.4 2012/09/02 18:19:53 armin76 Exp $

inherit flag-o-matic

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="similar to dd but can copy from source with errors"
HOMEPAGE="http://www.garloff.de/kurt/linux/ddrescue/"
SRC_URI="http://www.garloff.de/kurt/linux/ddrescue/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="static"

RDEPEND=""
DEPEND=">=sys-apps/sed-4"

src_compile() {
	use static && append-ldflags -static
	emake RPM_OPT_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README.dd_rescue
}
