# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-clib/rox-clib-2.1.10.ebuild,v 1.11 2013/06/16 08:19:58 pacho Exp $

EAPI=1
inherit eutils multilib

MY_PN="ROX-CLib"
DESCRIPTION="A library for ROX applications written in C."
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="
	x11-libs/gtk+:2
	dev-libs/libxml2:2
"
DEPEND="$RDEPEND
	virtual/pkgconfig
	rox-base/zeroinstall-injector
"

S=${WORKDIR}/ROX-CLib
APPNAME=${MY_PN}

src_compile() {
	chmod 0755 AppRun

	# Most rox self-compiles have a 'read' call to wait for the user to
	# press return if the compile fails.
	# Find and remove this:
	sed -i.bak -e 's/\<read WAIT\>/#read/' AppRun

	./AppRun --compile || die "Could not make ROX-CLib. Sorry."

	# Restore the original AppRun
	mv AppRun.bak AppRun
}

src_install() {
	local baselibdir="/usr/$(get_libdir)"
	local NATIVE_FEED_DIR="/usr/share/0install.net/native_feeds"
	local ICON_CACHE_DIR="/var/cache/0install.net/interface_icons"

	#  clean up source instead of remove it!
	( cd src && make clean )

	# remove silly .cvs files
	find . -name '.cvs*' | xargs rm -f >/dev/null 2>&1
	dodir ${baselibdir}/${APPNAME}
	cp -r . "${D}${baselibdir}/${APPNAME}"
	(
		cd Help
		dodoc Authors Changes ToDo README Versions
	)

	0distutils ROX-CLib.xml > tmp.native_feed || die "0distutilss feed edit failed"
	insinto "${baselibdir}/ROX-CLib/"
	newins tmp.native_feed ROX-CLib.xml

	local feedname
	feedname=$(0distutils -e tmp.native_feed) || die "0distutils URI escape failed"
	dosym "${baselibdir}/ROX-CLib/ROX-CLib.xml" "${NATIVE_FEED_DIR}/${feedname}"

	local cachedname
	cachedname=$(0distutils -c tmp.native_feed) || die "0distutils URI escape failed"
	dosym "${baselibdir}/ROX-CLib/.DirIcon" "${ICON_CACHE_DIR}/${cachedname}"

	prune_libtool_files
}
