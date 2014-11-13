# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtchooser/qtchooser-0_p20140613.ebuild,v 1.1 2014/11/13 02:59:00 pesa Exp $

EAPI=5

inherit qmake-utils toolchain-funcs

DESCRIPTION="Qt4/Qt5 version chooser"
HOMEPAGE="https://qt.gitorious.org/qt/qtchooser"
SRC_URI="http://dev.gentoo.org/~pesa/distfiles/${P}.tar.xz"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt5 test"

DEPEND="qt5? ( test? (
		dev-qt/qtcore:5
		dev-qt/qttest:5
	) )"
RDEPEND="!<dev-qt/qtcore-4.8.6:4"

qtchooser_make() {
	emake \
		CXX="$(tc-getCXX)" \
		LFLAGS="${LDFLAGS}" \
		prefix="${EPREFIX}/usr" \
		"$@"
}

src_compile() {
	qtchooser_make
}

src_test() {
	use qt5 || return

	pushd tests/auto >/dev/null || die
	eqmake5
	popd >/dev/null || die

	qtchooser_make check
}

src_install() {
	qtchooser_make INSTALL_ROOT="${D}" install

	keepdir /etc/xdg/qtchooser

	# TODO: bash and zsh completion
	# newbashcomp scripts/${PN}.bash ${PN}
}
