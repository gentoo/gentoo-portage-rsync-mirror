# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/qmmp-plugin-pack/qmmp-plugin-pack-0.8.0.ebuild,v 1.1 2014/07/12 08:51:34 hwoarang Exp $

EAPI=5

CMAKE_MIN_VERSION=2.8

inherit cmake-utils

DESCRIPTION="A set of extra plugins for Qmmp"
HOMEPAGE="http://qmmp.ylsoftware.com/"
SRC_URI="http://qmmp.ylsoftware.com/files/plugins/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/taglib-1.7.0
	>=media-sound/mpg123-1.13.0
	>=media-sound/qmmp-0.8.0
	dev-qt/qtgui:4"
DEPEND="${RDEPEND}
	dev-lang/yasm"
