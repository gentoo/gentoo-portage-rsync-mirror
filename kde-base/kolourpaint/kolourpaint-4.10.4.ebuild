# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.10.4.ebuild,v 1.2 2013/06/29 16:09:41 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Paint Program for KDE"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
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
