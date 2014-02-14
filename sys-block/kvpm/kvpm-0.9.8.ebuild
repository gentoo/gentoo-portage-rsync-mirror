# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/kvpm/kvpm-0.9.8.ebuild,v 1.1 2014/02/14 17:26:58 kensington Exp $

EAPI=5

KDE_DOC_DIRS="docbook"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE frontend for Linux LVM2 and GNU parted"
HOMEPAGE="http://kvpm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="
	sys-apps/util-linux
	sys-block/parted
	sys-fs/lvm2
"
DEPEND="${RDEPEND}"
