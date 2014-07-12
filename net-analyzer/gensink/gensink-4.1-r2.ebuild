# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gensink/gensink-4.1-r2.ebuild,v 1.4 2014/07/12 13:26:13 jer Exp $

EAPI=5

inherit base toolchain-funcs

DESCRIPTION="A simple TCP benchmark suite"
HOMEPAGE="http://jes.home.cern.ch/jes/gensink/"
SRC_URI="http://jes.home.cern.ch/jes/gensink/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

PATCHES=( "${FILESDIR}/${P}-make.patch" )

src_compile() {
	tc-export CC
	default
}
src_install() {
	dobin sink4 tub4 gen4
}
