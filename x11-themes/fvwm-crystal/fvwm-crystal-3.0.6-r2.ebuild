# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm-crystal/fvwm-crystal-3.0.6-r2.ebuild,v 1.4 2012/07/29 17:48:29 armin76 Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"

inherit eutils python

DESCRIPTION="Configurable and full featured theme for FVWM, with lots of transparency"
HOMEPAGE="http://gna.org/projects/fvwm-crystal/"
SRC_URI="http://download.gna.org/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="|| ( media-gfx/imagemagick[png] media-gfx/graphicsmagick[imagemagick,png] )
	x11-apps/xwd
	|| ( x11-misc/habak x11-misc/hsetroot )
	|| ( x11-misc/stalonetray x11-misc/trayer )
	>=x11-wm/fvwm-2.6.2[png]"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	find . -type d -name '.svn' -prune -exec rm -rf {} ';' || die
	python_convert_shebangs -r 2 bin fvwm/scripts #317041
	epatch \
		"${FILESDIR}"/${PN}.apps.patch \
		"${FILESDIR}"/${PN}-build.patch
}

src_install() {
	emake \
		DESTDIR="${D}" \
		addondir="/usr/share/doc/${PF}/addons" \
		docdir="/usr/share/doc/${PF}" \
		prefix="/usr" \
		install

	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}"/fvwm-crystal

	insinto /usr/share/xsessions
	doins addons/fvwm-crystal.desktop
}

pkg_postinst() {
	einfo
	einfo "Configuration examples can be found in ${ROOT}usr/share/doc/${PF}/examples/"
	einfo
	einfo "Many applications can extend functionality of fvwm-crystal."
	einfo "They are listed in the INSTALL file in ${ROOT}usr/share/doc/${PF}."
	einfo
	ewarn "In this release, all hyphens (-) in names of env variables"
	ewarn "used by FVWM-Crystal have been replaced by underscores (_)."
	ewarn "You may need to update your configuration."
}
