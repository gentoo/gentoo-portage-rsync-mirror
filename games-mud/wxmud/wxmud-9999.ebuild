# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/wxmud/wxmud-9999.ebuild,v 1.5 2011/03/27 13:19:58 nirbheek Exp $

EAPI="1"
WX_GTK_VER=2.8
inherit flag-o-matic subversion wxwidgets autotools games

DESCRIPTION="Cross-platform MUD client"
HOMEPAGE="http://wxmud.sourceforge.net/"
SRC_URI=""
ESVN_REPO_URI="https://wxmud.svn.sourceforge.net/svnroot/wxmud/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="python"

RDEPEND="=x11-libs/wxGTK-2.8*
	>=x11-libs/gtk+-2.4:2
	python? ( >=dev-lang/python-2.4 )"
DEPEND="${RDEPEND}"

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	append-flags -fno-strict-aliasing
	# No audiere in portage yet, so useful MSP support is disabled for now
	egamesconf --with-wx-config="${WX_CONFIG}" \
		$(use_enable python) \
		--disable-audiere
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO docs/input.txt docs/scripting.txt || die
	prepgamesdirs
}
