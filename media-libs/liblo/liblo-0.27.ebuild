# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblo/liblo-0.27.ebuild,v 1.1 2013/06/01 08:15:44 radhermit Exp $

EAPI=5
inherit eutils

DESCRIPTION="Lightweight OSC (Open Sound Control) implementation"
HOMEPAGE="http://plugin.org.uk/liblo"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~ppc-macos"
IUSE="doc ipv6 static-libs threads"

RESTRICT="test"

DEPEND="doc? ( app-doc/doxygen )"

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
