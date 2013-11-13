# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/terminology/terminology-0.4.0_alpha1.ebuild,v 1.1 2013/11/13 08:32:36 sera Exp $

EAPI=5

inherit autotools

DESCRIPTION="Feature rich terminal emulator using the Enlightenment Foundation Libraries"
HOMEPAGE="http://www.enlightenment.org/p.php?p=about/terminology"
SRC_URI="http://download.enlightenment.org/releases/${P//_/-}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EFL_VERSION=1.7.0

RDEPEND="
	>=dev-libs/ecore-${EFL_VERSION}[evas]
	>=dev-libs/eet-${EFL_VERSION}
	>=dev-libs/efreet-${EFL_VERSION}
	>=dev-libs/eina-${EFL_VERSION}
	>=media-libs/edje-${EFL_VERSION}
	>=media-libs/elementary-${EFL_VERSION}
	>=media-libs/emotion-${EFL_VERSION}
	>=media-libs/ethumb-${EFL_VERSION}[dbus]
	>=media-libs/evas-${EFL_VERSION}"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${P//_/-}"

src_prepare() {
	sed -i "s:1.8.0:${EFL_VERSION}:g" configure.ac
	eautoreconf
}
