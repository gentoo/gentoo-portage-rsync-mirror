# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leechcraft-popishu/leechcraft-popishu-9999.ebuild,v 1.2 2011/12/16 18:37:31 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Popishu, the text editor with IDE features for LeechCraft."

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qscintilla"
RDEPEND="${DEPEND}"
