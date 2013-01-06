# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/liberation-fonts/liberation-fonts-2.00.0-r1.ebuild,v 1.3 2012/12/08 12:22:13 maekke Exp $

EAPI=4

inherit font

DESCRIPTION="A Helvetica/Times/Courier replacement TrueType font set, courtesy of Red Hat"
HOMEPAGE="https://fedorahosted.org/liberation-fonts"
SRC_URI="!fontforge? ( https://fedorahosted.org/releases/l/i/${PN}/${PN}-ttf-${PV}.tar.gz )
fontforge? ( https://fedorahosted.org/releases/l/i/${PN}/${P}.tar.gz )"

KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
SLOT="0"
LICENSE="OFL-1.1"
IUSE="fontforge X"

FONT_SUFFIX="ttf"

FONT_CONF=( "${FILESDIR}/${PV}/60-liberation.conf" )

DEPEND="fontforge? ( media-gfx/fontforge )"
RDEPEND=""

pkg_setup() {
	if use fontforge; then
		FONT_S="${S}/${PN}-ttf-${PV}"
	else
		FONT_S="${WORKDIR}/${PN}-ttf-${PV}"
		S="${FONT_S}"
	fi
	font_pkg_setup
}
