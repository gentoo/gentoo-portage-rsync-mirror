# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgit2/libgit2-0.16.0.ebuild,v 1.3 2012/04/23 07:25:00 heroxbd Exp $

EAPI=4

inherit cmake-utils multilib

DESCRIPTION="A linkable library for Git"
HOMEPAGE="http://libgit2.github.com/"
SRC_URI="mirror://github/${PN}/${PN}/${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos"
IUSE="examples test"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

DOCS=( README.md )

src_configure() {
	local mycmakeargs=(
		-DINSTALL_LIB="${EPREFIX}/usr/$(get_libdir)"
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use examples ; then
		find examples -name .gitignore -delete
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
