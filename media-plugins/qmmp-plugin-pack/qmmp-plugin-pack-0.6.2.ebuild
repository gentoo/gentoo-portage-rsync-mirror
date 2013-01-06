# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/qmmp-plugin-pack/qmmp-plugin-pack-0.6.2.ebuild,v 1.1 2012/08/17 17:52:56 hwoarang Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A set of extra plugins for Qmmp"
HOMEPAGE="http://code.google.com/p/qmmp"
SRC_URI="http://qmmp.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/qmmp-0.6.0"
