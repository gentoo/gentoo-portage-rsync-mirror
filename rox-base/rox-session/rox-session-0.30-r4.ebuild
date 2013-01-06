# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-session/rox-session-0.30-r4.ebuild,v 1.5 2008/08/31 21:16:22 armin76 Exp $

ROX_LIB_VER="2.0.4-r1"
ROX_VER="2.7-r1"
inherit eutils rox-0install

DESCRIPTION="Rox-Session is a really simple session manager"
HOMEPAGE="http://rox.sourceforge.net/rox_session.html"
SRC_URI="mirror://sourceforge/rox/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=dev-python/dbus-python-0.71
	x11-apps/xgamma
	x11-apps/xset"

MY_PN="ROX-Session"
APPNAME=${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# By default on first startup rox-session tries to load oroborox (and
	# download it if it's not already installed).  This patch gives users a
	# choice of existing WM instead of forcing oroborox down their throats:
	epatch "${FILESDIR}/${P}-wmselect.patch"

	# Fixes bug #202797
	epatch "${FILESDIR}/${P}-logging.patch"
}

src_install() {
	rox-0install_src_install

	dobin "${FILESDIR}/rox-start"

	local wm="rox"
	make_session_desktop "ROX Desktop" /usr/bin/rox-start

	dodir /etc/X11/Sessions
	echo "/usr/bin/rox-start" > "${D}/etc/X11/Sessions/ROX_Desktop"
	fperms a+x /etc/X11/Sessions/ROX_Desktop

	# This is fun- Requires 'ROX-Defaults' which is basically useless.
	# So setup a dummy feed for it:
	local feedname
	feedname=$(0distutils -e "${FILESDIR}/ROX-Defaults.xml") || die "0distutils URI escape failed"
	insinto "${NATIVE_FEED_DIR}"
	newins "${FILESDIR}/ROX-Defaults.xml" "${feedname}"
}

pkg_postinst() {
	echo
	einfo "ROX-Session has been installed into ${APPDIR}"
	einfo "Please review its documentation about proper use. A symlink"
	einfo "for the executable has been created as /usr/bin/${WRAPPERNAME}."
	echo
	einfo "It has also been installed as an X Session, so you should be"
	einfo "able to select it in the Session list of gdm or kdm"
}
