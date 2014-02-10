# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/msgpack/msgpack-0.5.6-r1.ebuild,v 1.2 2014/02/10 07:46:53 pinkbyte Exp $

EAPI="5"

inherit eutils

DESCRIPTION="MessagePack is a binary-based efficient data interchange format"
HOMEPAGE="http://msgpack.org/"
SRC_URI="http://msgpack.org/releases/cpp/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="static-libs test"

DEPEND="test? ( dev-cpp/gtest )"
RDEPEND=""

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	# fix underlinking in tests
	sed -i -e 's/-lgtest_main/\0 -lgtest/' test/Makefile.in || die

	epatch_user
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	prune_libtool_files
}
