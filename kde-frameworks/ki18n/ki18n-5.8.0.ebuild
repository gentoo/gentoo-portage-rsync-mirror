# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/ki18n/ki18n-5.8.0.ebuild,v 1.1 2015/03/21 17:26:26 kensington Exp $

EAPI=5

inherit kde5

DESCRIPTION="Framework based on Gettext for internationalizing user interface text"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-qt/qtscript:5
"
DEPEND="${RDEPEND}
	virtual/libintl
	test? ( dev-qt/qtconcurrent:5 )
"
