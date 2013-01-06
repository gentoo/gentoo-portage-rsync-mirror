# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/flasm/flasm-1.63.ebuild,v 1.2 2011/08/11 02:28:20 vapier Exp $

EAPI=2

inherit eutils versionator toolchain-funcs

MY_PV=$(delete_all_version_separators $(get_version_component_range 1-2))
DESCRIPTION="Command line assembler/disassembler of Flash ActionScript bytecode"
HOMEPAGE="http://www.nowrap.de/flasm.html"
SRC_URI="http://www.nowrap.de/download/flasm${MY_PV}src.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/unzip
	sys-devel/flex
	virtual/yacc
	dev-util/gperf"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	dobin flasm || die
	dodoc CHANGES.TXT || die
	dohtml flasm.html classic.css || die
}
