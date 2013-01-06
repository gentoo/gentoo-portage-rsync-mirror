# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jq/jq-1.1.ebuild,v 1.1 2012/10/23 20:33:52 radhermit Exp $

EAPI=5

inherit vcs-snapshot toolchain-funcs eutils

DESCRIPTION="A lightweight and flexible command-line JSON processor"
HOMEPAGE="http://stedolan.github.com/jq/"
SRC_URI="https://github.com/stedolan/jq/tarball/${P} -> ${P}.tar.gz"

LICENSE="MIT CCPL-Attribution-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-util/valgrind )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	tc-export CC
}

src_install() {
	dobin jq
	dodoc README.md
}
