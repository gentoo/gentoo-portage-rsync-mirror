# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tarsync/tarsync-0.2.1.ebuild,v 1.6 2009/10/12 16:50:07 halcy0n Exp $

DESCRIPTION="Delta compression suite for using/generating binary patches"
HOMEPAGE="http://gentooexperimental.org/~ferringb/tarsync/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~hppa ppc x86 ~amd64"
IUSE=""

S="${WORKDIR}/${PN}"

DEPEND=">=dev-util/diffball-0.7"
RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "failed installing"
}
