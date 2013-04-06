# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/qimhangul/qimhangul-0.2.0.ebuild,v 1.2 2013/04/06 02:55:40 naota Exp $

EAPI=5

DESCRIPTION="a qt-based imhangul"
HOMEPAGE="https://code.google.com/p/qimhangul/"
SRC_URI="https://qimhangul.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=app-i18n/libhangul-0.0.12
	dev-qt/qtgui"
RDEPEND="${DEPEND}"
