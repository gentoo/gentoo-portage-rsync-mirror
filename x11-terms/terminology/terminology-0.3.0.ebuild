# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/terminology/terminology-0.3.0.ebuild,v 1.1 2013/03/24 14:55:17 sera Exp $

EAPI=5

DESCRIPTION="Feature rich terminal emulator using the Enlightenment Foundation Libraries"
HOMEPAGE="http://www.enlightenment.org/p.php?p=about/terminology"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
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
	>=media-libs/ethumb-${EFL_VERSION}
	>=media-libs/evas-${EFL_VERSION}"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
