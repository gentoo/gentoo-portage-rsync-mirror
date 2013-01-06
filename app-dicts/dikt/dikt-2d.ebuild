# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dikt/dikt-2d.ebuild,v 1.3 2011/10/29 01:09:44 abcd Exp $

EAPI=4
inherit kde4-base

DESCRIPTION="A dictionary for KDE"
HOMEPAGE="http://code.google.com/p/dikt/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tbz"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DOCS=( README )
