# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcapnav/libpcapnav-0.8.ebuild,v 1.4 2014/07/18 15:19:46 jer Exp $

EAPI=5
inherit eutils

DESCRIPTION="Libpcap wrapper library to navigate to arbitrary packets in a tcpdump trace file"
HOMEPAGE="http://netdude.sourceforge.net/"
SRC_URI="mirror://sourceforge/netdude/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~sparc ~x86"
IUSE="doc static-libs"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

RESTRICT="test"

DOCS=( AUTHORS ChangeLog README )

src_prepare() {
	epatch "${FILESDIR}"/${P}-includes.patch
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_compile() {
	emake SUBDIRS="src docs"
}

src_install() {
	default
	rm -fr "${D}"/usr/share/gtk-doc
	use doc && dohtml -r docs/*.css docs/html/*.html docs/images
	prune_libtool_files
}
