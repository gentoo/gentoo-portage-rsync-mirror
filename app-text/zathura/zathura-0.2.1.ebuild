# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura/zathura-0.2.1.ebuild,v 1.4 2012/09/21 02:03:45 heroxbd Exp $

EAPI=4
inherit eutils multilib toolchain-funcs

DESCRIPTION="A highly customizable and functional document viewer"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/${PN}/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+doc sqlite"

RDEPEND=">=dev-libs/girara-0.1.4:2
	>=dev-libs/glib-2
	x11-libs/cairo
	sqlite? ( dev-db/sqlite:3 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( dev-python/docutils )"

pkg_setup() {
	myzathuraconf=(
		ZATHURA_GTK_VERSION=2
		WITH_SQLITE=$(usex sqlite 1 0)
		PREFIX="${EPREFIX}"/usr
		LIBDIR='${PREFIX}'/$(get_libdir)
		RSTTOMAN="$(use doc && type -P rst2man.py)"
		CC="$(tc-getCC)"
		SFLAGS=""
		VERBOSE=1
		DESTDIR="${D}"
		)
}

src_prepare() {
	# http://bugs.pwmt.org/msg816
	# these are 0 byte files in dist tarball wrt #434140
	rm *.{1,5}
}

src_compile() {
	emake "${myzathuraconf[@]}"
}

src_install() {
	emake "${myzathuraconf[@]}" install
	dodoc AUTHORS
}
