# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/tasklist/tasklist-0.5.ebuild,v 1.6 2011/03/21 22:34:15 nirbheek Exp $

EAPI="1"
ROX_CLIB_VER=2.1.10
inherit rox-0install

MY_PN="Tasklist"
DESCRIPTION="Tasklist is a ROX applet which shows a list of running applications"
HOMEPAGE="http://rox.sourceforge.net/phpwiki/index.php/Tasklist"
SRC_URI="ftp://ftp.berlios.de/pub/rox4debian/apps/${MY_PN}-${PV}.tgz"

DEPEND="x11-libs/libwnck:1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

APPNAME=${MY_PN}
S=${WORKDIR}
LOCAL_FEED_SRC="${FILESDIR}/${MY_PN}-${PV}.xml"

src_unpack() {
	unpack ${A}
	cd "${S}/${MY_PN}"

	# Oh my, includes pre-compiled binary which requires libwnck-1.8!
	# Those crazy rox folks... Remove it.
	rm -rf Linux-ix86

	# No need for 2 identical files here, link one:
	rm AppletRun
	ln -s AppRun AppletRun

	# Patch to override default settings of ${HOME}/Choices/
	epatch "${FILESDIR}/choicespath.patch"
}
