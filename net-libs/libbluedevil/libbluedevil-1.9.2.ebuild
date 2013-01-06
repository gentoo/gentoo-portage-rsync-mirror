# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbluedevil/libbluedevil-1.9.2.ebuild,v 1.4 2012/05/24 10:54:14 ago Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Qt wrapper for bluez used in the KDE bluetooth stack"
HOMEPAGE="http://projects.kde.org/projects/playground/libs/libbluedevil"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	net-wireless/bluez
"
