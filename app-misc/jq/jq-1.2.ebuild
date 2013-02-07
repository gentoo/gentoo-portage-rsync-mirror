# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jq/jq-1.2.ebuild,v 1.2 2013/02/07 21:39:36 ulm Exp $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="A lightweight and flexible command-line JSON processor"
HOMEPAGE="http://stedolan.github.com/jq/"
SRC_URI="https://github.com/stedolan/jq/archive/${P}.tar.gz"

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="sys-devel/bison
	sys-devel/flex
	test? ( dev-util/valgrind )"

S=${WORKDIR}/${PN}-${P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	tc-export CC
}

src_install() {
	dobin jq
	dodoc README.md
}
