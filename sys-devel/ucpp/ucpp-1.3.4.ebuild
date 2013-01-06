# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ucpp/ucpp-1.3.4.ebuild,v 1.1 2012/12/19 07:57:52 scarabeus Exp $

EAPI=5

inherit eutils

DESCRIPTION="A quick and light preprocessor, but anyway fully compliant to C99"
HOMEPAGE="http://code.google.com/p/ucpp/"
SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux"
IUSE="static-libs"

src_configure() {
	econf \
		--disable-werror \
		$(use_enable static-libs static)
}

src_install() {
	default

	prune_libtool_files --all
}
