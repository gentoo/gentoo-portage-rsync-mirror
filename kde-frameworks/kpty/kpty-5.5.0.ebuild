# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kpty/kpty-5.5.0.ebuild,v 1.1 2014/12/17 21:24:20 mrueg Exp $

EAPI=5

inherit kde5

DESCRIPTION="Framework for pseudo terminal devices and running child processes"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64"
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	sys-libs/libutempter
"
RDEPEND="${DEPEND}"
