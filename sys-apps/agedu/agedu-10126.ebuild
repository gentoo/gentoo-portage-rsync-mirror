# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/agedu/agedu-10126.ebuild,v 1.1 2014/01/27 13:36:16 blueness Exp $

EAPI="5"

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
