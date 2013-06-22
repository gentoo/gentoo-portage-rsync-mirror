# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/jumanji/jumanji-0.0.0_p20130103.ebuild,v 1.1 2013/06/22 12:20:11 xmw Exp $

EAPI=5

inherit eutils savedconfig toolchain-funcs vcs-snapshot

DESCRIPTION="highly customizable and functional web browser with minimalistic and space saving interface"
HOMEPAGE="http://pwmt.org/projects/jumanji"
SRC_URI="https://git.pwmt.org/?p=jumanji.git;a=snapshot;h=963b309e9f91c6214f36c729514d5a08e7293310;sf=tgz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="develop"
KEYWORDS="~amd64 ~x86"
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
		epatch "${FILESDIR}"/${PN}-0.0.0_p20130103-gtk2.patch

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
