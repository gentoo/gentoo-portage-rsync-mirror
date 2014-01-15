# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/coinor-bcps/coinor-bcps-0.93.9.ebuild,v 1.2 2014/01/15 18:32:48 bicatali Exp $

EAPI=5

inherit autotools-utils multilib

MYPN=Bcps

DESCRIPTION="COIN-OR BiCEPS data handling library"
HOMEPAGE="https://projects.coin-or.org/CHiPPS/"
SRC_URI="http://www.coin-or.org/download/source/${MYPN}/${MYPN}-${PV}.tgz"

LICENSE="CPL-1.0"
SLOT="0/1"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples static-libs test"

RDEPEND="
	sci-libs/coinor-utils:=
	sci-libs/coinor-clp:=
	sci-libs/coinor-alps:="
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( sci-libs/coinor-sample )"

S="${WORKDIR}/${MYPN}-${PV}/${MYPN}"

src_configure() {
	local myeconfargs=(
		--enable-dependency-linking
	)
	autotools-utils_src_configure
}

src_test() {
	autotools-utils_src_test test
}

src_install() {
	autotools-utils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
