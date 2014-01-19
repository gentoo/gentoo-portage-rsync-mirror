# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbluedevil/libbluedevil-1.9.4.ebuild,v 1.5 2014/01/19 11:15:16 pacho Exp $

EAPI=5

inherit kde4-base

MY_P=${PN}-v${PV}
DESCRIPTION="Qt wrapper for bluez used in the KDE bluetooth stack"
HOMEPAGE="http://projects.kde.org/projects/playground/libs/libbluedevil"
SRC_URI="mirror://kde/stable/${PN}/${MY_P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
SLOT="4"
IUSE="debug"

RDEPEND="net-wireless/bluez"

S=${WORKDIR}/${MY_P}
