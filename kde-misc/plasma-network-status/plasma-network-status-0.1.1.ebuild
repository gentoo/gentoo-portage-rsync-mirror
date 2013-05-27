# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/plasma-network-status/plasma-network-status-0.1.1.ebuild,v 1.2 2013/05/27 15:39:10 kensington Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="KDE applet to monitor the network interface status."
HOMEPAGE="http://sourceforge.net/projects/pa-net-stat/"
SRC_URI="mirror://sourceforge/pa-net-stat/${P}-Source.tar.bz2"

SLOT="4"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${P}-Source"
