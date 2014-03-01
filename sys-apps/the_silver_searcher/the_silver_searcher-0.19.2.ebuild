# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/the_silver_searcher/the_silver_searcher-0.19.2.ebuild,v 1.1 2014/03/01 08:08:58 radhermit Exp $

EAPI=5
inherit autotools bash-completion-r1 eutils

DESCRIPTION="A code-searching tool similar to ack, but faster"
HOMEPAGE="http://github.com/ggreer/the_silver_searcher"
SRC_URI="https://github.com/ggreer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="lzma"

RDEPEND="dev-libs/libpcre
	sys-libs/zlib
	lzma? ( app-arch/xz-utils )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="README.md"

src_prepare() {
	epatch "${FILESDIR}"/${P}-automagic-lzma.patch
	sed -i '/^dist_bashcomp/d' Makefile.am || die

	eautoreconf
}

src_configure() {
	econf $(use_enable lzma)
}

src_install() {
	default
	newbashcomp ag.bashcomp.sh ag
}
