# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.9.5.ebuild,v 1.5 2013/02/23 16:46:37 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Paint Program for KDE"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
LICENSE="BSD LGPL-2"
IUSE="debug scanner"

DEPEND="media-libs/qimageblitz"
RDEPEND="${DEPEND}
	scanner? ( kde-base/ksaneplugin )"
