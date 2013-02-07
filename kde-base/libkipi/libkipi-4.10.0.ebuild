# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkipi/libkipi-4.10.0.ebuild,v 1.1 2013/02/07 04:57:08 alexxy Exp $

EAPI=5

# needed for digikam
KDE_OVERRIDE_MINIMAL="4.9.0"

inherit kde4-base

DESCRIPTION="A library for image plugins accross KDE applications."
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
