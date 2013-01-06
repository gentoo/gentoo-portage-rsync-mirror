# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qastools/qastools-0.17.1.ebuild,v 1.1 2012/03/13 01:21:14 pesa Exp $

EAPI=4

inherit cmake-utils

MY_P=${PN}_${PV}

DESCRIPTION="Qt4 GUI ALSA tools: mixer, configuration browser"
HOMEPAGE="http://xwmw.org/qastools/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/alsa-lib
	>=x11-libs/qt-core-4.6:4
	>=x11-libs/qt-gui-4.6:4
	>=x11-libs/qt-svg-4.6:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

DOCS="CHANGELOG README TODO"

# TODO: translation handling (currently auto-installs all l10ns)
