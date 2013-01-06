# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.9.4.ebuild,v 1.2 2012/12/23 12:11:01 maekke Exp $

EAPI=4

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD LGPL-2"
IUSE="debug scanner"

DEPEND="media-libs/qimageblitz"
RDEPEND="${DEPEND}
	scanner? ( kde-base/ksaneplugin )"
