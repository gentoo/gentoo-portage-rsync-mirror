# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/wrk/wrk-3.1.1.ebuild,v 1.1 2014/10/02 19:09:59 vikraman Exp $

EAPI=5

inherit eutils

DESCRIPTION="A modern HTTP benchmarking tool"
HOMEPAGE="https://github.com/wg/wrk"
SRC_URI="https://github.com/wg/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/openssl >=dev-lang/luajit-2.0.2"
RDEPEND="${DEPEND}"

src_prepare() {
	rm -rf deps/luajit || die "failed to remove bundled luajit"
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	dobin wrk
	dodoc README NOTICE
	insinto /usr/share/${PN}
	doins -r scripts
}
