# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop-pg-qt/kdevelop-pg-qt-1.0.0.ebuild,v 1.3 2012/06/05 13:13:33 johu Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="A LL(1) parser generator used mainly by KDevelop language plugins"
HOMEPAGE="http://www.kdevelop.org"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE="debug"

RDEPEND=""
DEPEND="
	sys-devel/bison
	sys-devel/flex
"
