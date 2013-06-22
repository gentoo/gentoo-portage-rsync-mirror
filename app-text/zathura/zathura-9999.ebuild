# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura/zathura-9999.ebuild,v 1.1 2013/06/22 13:05:38 xmw Exp $

EAPI=5

inherit eutils fdo-mime git-2 multilib toolchain-funcs virtualx

DESCRIPTION="A highly customizable and functional document viewer"
HOMEPAGE="http://pwmt.org/projects/zathura/"
EGIT_REPO_URI="git://git.pwmt.org/${PN}.git"
EGIT_BRANCH="develop"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE="+doc +deprecated sqlite test"

RDEPEND="dev-libs/glib:2
	x11-libs/cairo:=
	deprecated? ( >=dev-libs/girara-0.1.6:2 )
	!deprecated? ( >=dev-libs/girara-0.1.6:3 )
	sqlite? ( dev-db/sqlite:3 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( dev-python/docutils )
	test? ( dev-libs/check )"

pkg_setup() {
	myzathuraconf=(
		ZATHURA_GTK_VERSION=$(usex deprecated 2 3)
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

src_compile() {
	emake "${myzathuraconf[@]}"
}

src_test() {
	Xemake "${myzathuraconf[@]}" test
}

src_install() {
	emake "${myzathuraconf[@]}" install
	dodoc AUTHORS
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
