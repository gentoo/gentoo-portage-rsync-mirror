# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qtermwidget/qtermwidget-0.4.0.ebuild,v 1.4 2013/07/12 07:56:28 patrick Exp $

EAPI="4"

inherit cmake-utils

DESCRIPTION="Qt4 terminal emulator widget"
HOMEPAGE="https://github.com/qterminal/"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug" # todo: python

DEPEND="|| ( <dev-qt/qtgui-4.8.5:4 ( >=dev-qt/qtgui-4.8.5:4 dev-qt/designer ) )"
RDEPEND="${DEPEND}"
