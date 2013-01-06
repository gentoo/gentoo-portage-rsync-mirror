# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/arss/arss-0.2.3.ebuild,v 1.1 2010/07/11 11:42:16 hwoarang Exp $

inherit cmake-utils

MY_P=${P}-src

DESCRIPTION="Analysis & Resynthesis Sound Spectrograph"
HOMEPAGE="http://arss.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sci-libs/fftw"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/src

CMAKE_IN_SOURCE_BUILD="TRUE"

DOCS="../AUTHORS ../ChangeLog"
