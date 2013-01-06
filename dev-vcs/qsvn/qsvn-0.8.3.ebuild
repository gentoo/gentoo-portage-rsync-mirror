# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/qsvn/qsvn-0.8.3.ebuild,v 1.5 2012/07/15 14:49:00 kensington Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="GUI frontend to the Subversion revision system"
HOMEPAGE="http://www.anrichter.net/projects/qsvn/"
SRC_URI="http://www.anrichter.net/projects/${PN}/chrome/site/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/apr
	dev-libs/apr-util
	dev-vcs/subversion
	x11-libs/qt-core:4[qt3support]
	x11-libs/qt-gui:4[qt3support]
	x11-libs/qt-sql:4[sqlite]
	dev-vcs/subversion"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/src

PATCHES=(
	"${FILESDIR}/${P}-static-lib.patch"
	"${FILESDIR}/${P}-tests.patch"
)

DOCS=( ../ChangeLog ../README )
