# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/jumanji/jumanji-9999.ebuild,v 1.9 2014/04/03 15:26:33 xmw Exp $

EAPI=5

inherit eutils savedconfig git-2 toolchain-funcs

DESCRIPTION="highly customizable and functional web browser with minimalistic and space saving interface"
HOMEPAGE="http://pwmt.org/projects/jumanji"
EGIT_REPO_URI="git://pwmt.org/jumanji.git"
EGIT_BRANCH=develop

LICENSE="ZLIB"
SLOT="develop"
KEYWORDS=""
IUSE="+deprecated"

RDEPEND="dev-db/sqlite:3
	dev-libs/glib:2
	!deprecated? (
		dev-libs/girara:3
		net-libs/webkit-gtk:3
		x11-libs/gtk+:3 )
	deprecated? (
		dev-libs/girara:2
		net-libs/webkit-gtk:2
		x11-libs/gtk+:2 )
	!${CATEGORY}/${PN}:0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	use deprecated && \
		epatch "${FILESDIR}"/${PN}-0.0.0_p20130103-r1-gtk2.patch

	restore_config config.h
}

src_compile() {
	emake CC="$(tc-getCC)" SFLAGS="" VERBOSE=1 || \
		die "emake failed$(usex savedconfig ",please check the configfile" "")"
}

src_install() {
	default
	make_desktop_entry ${PN}

	save_config config.h
}
