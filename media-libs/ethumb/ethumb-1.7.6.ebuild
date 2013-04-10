# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ethumb/ethumb-1.7.6.ebuild,v 1.1 2013/04/10 21:37:33 tommy Exp $

EAPI=2

inherit enlightenment

DESCRIPTION="Enlightenment thumbnailing library (meant to replace epsilon)"
HOMEPAGE="http://trac.enlightenment.org/e/wiki/Ethumb"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE="+dbus emotion static-libs"

DEPEND=">=dev-libs/eina-1.7.6
	>=dev-libs/ecore-1.7.6
	>=media-libs/edje-1.7.6
	>=media-libs/evas-1.7.6
	media-libs/libexif

	dbus? ( >=dev-libs/e_dbus-1.7.6 )
	emotion? ( >=media-libs/emotion-1.7.6 )"
RDEPEND="${DEPEND}"

#src_prepare() {
#	sed -i "s:1.7.5:1.7.4:g" configure.ac
#	eautoreconf
#}

src_configure() {
	MY_ECONF="$(use_enable dbus ethumbd)
		$(use_enable emotion)
		--disable-epdf"

	enlightenment_src_configure
}
