# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qtermwidget/qtermwidget-0.4.0.37.ebuild,v 1.2 2014/08/03 16:53:22 maksbotan Exp $

EAPI="5"

inherit vcs-snapshot cmake-utils

DESCRIPTION="Qt4 terminal emulator widget"
HOMEPAGE="https://github.com/qterminal/"
SRC_URI="http://dist.leechcraft.org/3rdparty/qtermwidget/qtermwidget-0.4.0-37-gebf7d6c.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug" # todo: python

DEPEND="|| ( ( >=dev-qt/qtgui-4.8.5:4 dev-qt/designer:4 ) <dev-qt/qtgui-4.8.5:4 )"
RDEPEND="${DEPEND}"
