# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kenvy24/kenvy24-1.2.ebuild,v 1.3 2011/10/28 23:41:11 abcd Exp $

EAPI=4
# po/ directory is disabled in CMakeLists.txt
# KDE_LINGUAS="es fr pl ro"
inherit kde4-base

DESCRIPTION="VIA Envy24 based sound card control utility for KDE"
HOMEPAGE="http://kenvy24.wiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/kenvy24/${P}-src.tgz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="
	media-libs/alsa-lib
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

S=${WORKDIR}/${P}-src
