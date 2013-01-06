# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/purple-plugin_pack/purple-plugin_pack-2.5.1-r1.ebuild,v 1.5 2011/10/27 06:46:56 tetromino Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A package with many different plugins for pidgin and libpurple"
HOMEPAGE="http://plugins.guifications.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="talkfilters debug gtk ncurses spell"

RDEPEND="net-im/pidgin[gtk?,ncurses?]
	talkfilters? ( app-text/talkfilters )
	spell? ( app-text/gtkspell:2 )"
DEPEND="${RDEPEND}
	dev-lang/python"

src_configure() {
	local plugins=""

	# XMMS Remote is disabled due to XMMS being masked
	DISABLED_PLUGINS="xmmsremote"

	use talkfilters || DISABLED_PLUGINS="${DISABLED_PLUGINS} talkfilters"
	use spell || DISABLED_PLUGINS="${DISABLED_PLUGINS} switchspell"

	plugins="$(python plugin_pack.py -p dist_dirs)"
	use gtk && plugins="${plugins} $(python plugin_pack.py -P dist_dirs)"
	use ncurses && plugins="${plugins} $(python plugin_pack.py -f dist_dirs)"

	# Disable incomplete plugins too
	DISABLED_PLUGINS="${DISABLED_PLUGINS} $(python plugin_pack.py -i dist_dirs)"

	for i in $DISABLED_PLUGINS; do
		plugins="${plugins//$i/}"
		plugins="${plugins//  / }"
		plugins="${plugins/# /}"
		plugins="${plugins/% /}"
		echo disabled $i
		echo $plugins
	done

	plugins="${plugins// /,}"

	econf --with-plugins="${plugins}" $(use_enable debug) || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README VERSION || die
}
