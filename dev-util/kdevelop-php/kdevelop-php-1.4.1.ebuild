# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop-php/kdevelop-php-1.4.1.ebuild,v 1.3 2012/12/14 12:54:43 ago Exp $

EAPI=4

KDE_LINGUAS="ca ca@valencia da de el en_GB es et fi fr gl it nb nds nl pl pt
pt_BR sv th uk zh_CN zh_TW"
VIRTUALX_REQUIRED=test
KMNAME="kdevelop"
EGIT_REPONAME="kdev-php"

inherit kde4-base

DESCRIPTION="PHP plugin for KDevelop 4"
LICENSE="GPL-2 LGPL-2"
IUSE="debug doc"

if [[ $PV == *9999* ]]; then
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

DEPEND="
	>=dev-util/kdevelop-pg-qt-1.0.0
"
RDEPEND="
	dev-util/kdevelop
	doc? ( >=dev-util/kdevelop-php-docs-${PV}:${SLOT} )
"
# Bug 330051
# RESTRICT="test"

PATCHES=( "${FILESDIR}/${PN}"-1.2.0-{dbustests,parmake}.patch )
