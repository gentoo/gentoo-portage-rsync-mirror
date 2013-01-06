# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/media-player-info/media-player-info-17.ebuild,v 1.6 2012/11/28 17:53:02 ssuominen Exp $

EAPI=5

DESCRIPTION="A repository of data files describing media player capabilities"
HOMEPAGE="http://cgit.freedesktop.org/media-player-info/"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~sh ~sparc x86"
IUSE=""

RDEPEND="virtual/udev"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS README"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"
