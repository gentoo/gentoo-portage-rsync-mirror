# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-strigi-analyzer/kdesdk-strigi-analyzer-4.9.5.ebuild,v 1.4 2013/01/27 23:24:16 ago Exp $

EAPI=4

KMNAME="kdesdk"
KMMODULE="strigi-analyzer"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="kdesdk: strigi plugins"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-misc/strigi
"
RDEPEND="${DEPEND}"
