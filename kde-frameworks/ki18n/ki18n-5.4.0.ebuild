# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/ki18n/ki18n-5.4.0.ebuild,v 1.1 2014/11/14 11:01:35 mrueg Exp $

EAPI=5

inherit kde5

DESCRIPTION="Framework based on Gettext for internationalizing user interface text"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64"
IUSE=""

RDEPEND="
	dev-qt/qtscript:5
"
DEPEND="${RDEPEND}
	virtual/libintl
	test? ( dev-qt/qtconcurrent:5 )
"
