# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/agedu/agedu-9723.ebuild,v 1.1 2013/01/08 03:37:08 blueness Exp $

EAPI="4"

inherit autotools eutils

MY_P="${PN}-r${PV}"

DESCRIPTION="A utility for tracking down wasted disk space"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/agedu/"
SRC_URI="http://www.chiark.greenend.org.uk/~sgtatham/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc ipv6"

DEPEND="doc? ( app-doc/halibut )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-r9671-fix-automagic.patch"
	eautoreconf
}

src_configure() {
	econf --enable-ipv4 \
		$(use_enable doc halibut) \
		$(use_enable ipv6)
}
