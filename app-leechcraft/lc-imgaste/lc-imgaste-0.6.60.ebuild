# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-imgaste/lc-imgaste-0.6.60.ebuild,v 1.5 2015/04/02 17:57:03 mr_bones_ Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="The simple image uploader data filter for LeechCraft"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}"
RDEPEND="${DEPEND}"
