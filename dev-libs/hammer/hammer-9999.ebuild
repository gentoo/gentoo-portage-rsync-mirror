# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hammer/hammer-9999.ebuild,v 1.1 2014/02/06 23:37:24 lejonet Exp $

EAPI="5"

inherit eutils toolchain-funcs scons-utils git-2

DESCRIPTION="Hammer is a parsing library, which is bit-oriented and features several parsing backends"
HOMEPAGE="https://github.com/UpstandingHackers/hammer"
SRC_URI=""
EGIT_REPO_URI="git://github.com/UpstandingHackers/hammer.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-util/scons
>=dev-libs/glib-2.29"
RDEPEND=""

src_prepare() {
	tc-export AR CC CXX RANLIB
}

src_configure() {
	myesconsargs="bindings=cpp"
}

src_compile() {
	escons prefix="/usr"
}

src_test() {
	escons test
}

src_install() {
	escons prefix="${D}/usr" install
	dodoc -r README.md NOTES HACKING TODO examples/
}
