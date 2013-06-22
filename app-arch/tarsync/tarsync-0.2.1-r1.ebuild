# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tarsync/tarsync-0.2.1-r1.ebuild,v 1.3 2013/06/22 14:28:33 kensington Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Delta compression suite for using/generating binary patches"
HOMEPAGE="http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/app-arch/tarsync/tarsync-0.2.1-r1.ebuild?view=markup"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND=">=dev-util/diffball-0.7"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

pkg_setup() {
	tc-export CC
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-make.patch
}
