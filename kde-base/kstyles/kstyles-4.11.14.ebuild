# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstyles/kstyles-4.11.14.ebuild,v 1.5 2015/02/17 11:06:35 ago Exp $

EAPI=5

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE: A set of different KDE styles"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	kde-base/liboxygenstyle:4=
	x11-libs/libX11
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libs/oxygen
"
