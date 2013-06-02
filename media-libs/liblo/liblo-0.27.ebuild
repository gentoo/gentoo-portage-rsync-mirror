# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblo/liblo-0.27.ebuild,v 1.2 2013/06/01 23:12:45 radhermit Exp $

EAPI=5
inherit eutils autotools

DESCRIPTION="Lightweight OSC (Open Sound Control) implementation"
HOMEPAGE="http://plugin.org.uk/liblo"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~ppc-macos"
IUSE="doc ipv6 static-libs threads"

RESTRICT="test"

DEPEND="doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-threads.patch

	# don't build examples by default
	sed -i '/^SUBDIRS =/s/examples//' Makefile.am || die

	eautoreconf
}

src_configure() {
	use doc || export ac_cv_prog_HAVE_DOXYGEN=false

	econf \
		$(use_enable static-libs static) \
		$(use_enable ipv6) \
		$(use_enable threads)
}

src_install() {
	default
	prune_libtool_files
}
