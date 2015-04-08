# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/culmus/culmus-0.104-r1.ebuild,v 1.7 2010/07/20 16:13:38 jer Exp $

EAPI="2"

inherit font

DESCRIPTION="Hebrew Type1 fonts"
HOMEPAGE="http://culmus.sourceforge.net/"
SRC_URI="mirror://sourceforge/culmus/${P}.tar.gz
	mirror://sourceforge/culmus/${PN}-type1-${PV}.tar.gz
	http://culmus.sourceforge.net/fancy/hillel.tar.gz
	http://culmus.sourceforge.net/fancy/anka.tar.gz
	http://culmus.sourceforge.net/fancy/comix.tar.gz
	http://culmus.sourceforge.net/fancy/gan.tar.gz
	http://culmus.sourceforge.net/fancy/ozrad.tar.gz
	http://culmus.sourceforge.net/fancy/ktav-yad.tar.gz
	http://culmus.sourceforge.net/fancy/dorian.tar.gz
	http://culmus.sourceforge.net/fancy/gladia.tar.gz"
# Some fonts are available in otf format too. Do we need them?
#	http://culmus.sourceforge.net/fancy/anka-otf.zip
#	http://culmus.sourceforge.net/fancy/hillel-otf.zip

LICENSE="|| ( GPL-2 LICENSE-BITSTREAM )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="afm pfa ttf"
FONT_CONF=( "65-culmus.conf" )
DOCS="CHANGES"

src_prepare() {
	mv "${WORKDIR}"/*.{afm,pfa} "${S}"
	mv "${WORKDIR}"/${PN}-type1-${PV}/*.{afm,pfa} "${S}"
	mv culmus.conf 65-culmus.conf
}
