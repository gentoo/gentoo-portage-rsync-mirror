# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword-docs/abiword-docs-2.8.6.ebuild,v 1.3 2011/07/23 15:31:28 tomka Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Fully featured yet light and fast cross platform word processor"
HOMEPAGE="http://www.abisource.com/"
SRC_URI="http://www.abisource.com/downloads/abiword/${PV}/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=app-office/abiword-${PV}"
DEPEND="${RDEPEND}"
