# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/girara/girara-0.1.3.ebuild,v 1.3 2012/07/11 05:53:18 jdhore Exp $

EAPI=4
inherit multilib toolchain-funcs

DESCRIPTION="A library that implements a user interface that focuses on simplicity and minimalism"
HOMEPAGE="http://pwmt.org/projects/girara/"
SRC_URI="http://pwmt.org/projects/${PN}/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="2"
KEYWORDS="amd64 x86"
IUSE="static-libs"

RDEPEND=">=x11-libs/gtk+-2.18.6:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	mygiraraconf=(
		LIBDIR='${PREFIX}'/$(get_libdir)
		GIRARA_GTK_VERSION=2
		CC="$(tc-getCC)"
		SFLAGS=""
		VERBOSE=1
		DESTDIR="${D}"
		)
}

src_prepare() {
	# http://bt.pwmt.org/view.php?id=223
	if ! use static-libs; then
		sed -i \
			-e 's|${PROJECT}: lib${PROJECT}.a|${PROJECT}:|' \
			-e '/install.*lib${PROJECT}.a/d' \
			Makefile || die
	fi
}

src_compile() {
	emake "${mygiraraconf[@]}"
}

src_install() {
	emake "${mygiraraconf[@]}" install
	dodoc AUTHORS
}
