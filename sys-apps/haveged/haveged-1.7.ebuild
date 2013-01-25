# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/haveged/haveged-1.7.ebuild,v 1.1 2013/01/25 16:58:06 flameeyes Exp $

EAPI=5

inherit eutils autotools

DESCRIPTION="A simple entropy daemon using the HAVEGE algorithm"
HOMEPAGE="http://www.issihosts.com/haveged/"
SRC_URI="http://www.issihosts.com/haveged/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="!<sys-apps/openrc-0.11.8"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_configure() {
	econf --bindir=/usr/sbin --enable-nistest \
		--disable-static
}

src_install() {
	default

	rm -rf "${D}"/usr/lib*/*.la

	# Install gentoo ones instead
	newinitd "${FILESDIR}"/haveged-init.d.3 haveged
	newconfd "${FILESDIR}"/haveged-conf.d haveged
}
