# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/uevt/uevt-2.3-r1.ebuild,v 1.7 2014/05/26 19:54:34 ssuominen Exp $

EAPI=5
VALA_MIN_API_VERSION="0.16"
VALA_MAX_API_VERSION="0.22"
inherit eutils vala

DESCRIPTION="UPower/UDisks Event, a lightweight desktop-independent power and disk manager"
HOMEPAGE="http://elentir.sleipnir.fr/ http://git.sleipnir.fr/uevt/"
SRC_URI="http://ftp.sleipnir.fr/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

#TODO FIXME: Does this release work with >=sys-power/upower-0.99 API?
#If not, adjust dependencies to:
#|| ( <sys-power/upower-0.99 sys-power/upower-pm-utils ) )
COMMON_DEPEND=">=dev-libs/glib-2.28
	x11-libs/gtk+:2
	>=x11-libs/libnotify-0.7"
RDEPEND="${COMMON_DEPEND}
	>=sys-fs/udisks-1.0.4-r5:0
	|| ( >=sys-power/upower-0.9.21 sys-power/upower-pm-utils )"
DEPEND="${COMMON_DEPEND}
	$(vala_depend)
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog README"

pkg_setup() {
	export VALAC="$(type -P valac-${UEVT_VALA_VERSION})"
}

src_prepare() {
	# http://git.sleipnir.fr/uevt/commit/?id=69d2f45e234190fbfb37745ea05ab88547a3de96
	epatch "${FILESDIR}"/${P}-support_for_more_than_one_CPU.patch

	# See http://bugs.gentoo.org/ wrt #428438
	echo src/configurator.c >> po/POTFILES.skip
	echo src/power-infos.c >> po/POTFILES.skip

	vala_src_prepare
}
