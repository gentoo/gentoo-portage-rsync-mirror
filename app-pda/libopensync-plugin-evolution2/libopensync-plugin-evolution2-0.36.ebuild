# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-evolution2/libopensync-plugin-evolution2-0.36.ebuild,v 1.1 2008/01/27 17:42:03 peper Exp $

inherit cmake-utils

DESCRIPTION="OpenSync Evolution 2 Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	gnome-extra/evolution-data-server"
RDEPEND="${DEPEND}"
