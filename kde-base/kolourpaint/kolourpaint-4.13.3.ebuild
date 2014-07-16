# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.13.3.ebuild,v 1.1 2014/07/16 17:40:41 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Paint Program for KDE"
HOMEPAGE="http://www.kde.org/applications/graphics/kolourpaint/"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD LGPL-2"
IUSE="debug"

DEPEND="media-libs/qimageblitz"
RDEPEND="${DEPEND}"

pkg_postinst() {
	kde4-base_pkg_postinst

	if ! has_version kde-base/ksaneplugin:${SLOT} ; then
		elog "To enable scanner support, please install kde-base/ksaneplugin:${SLOT}"
	fi
}
