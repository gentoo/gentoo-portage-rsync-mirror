# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solid-actions-kcm/solid-actions-kcm-4.11.5.ebuild,v 1.1 2014/01/10 04:21:51 creffett Exp $

EAPI=5

KMNAME="kde-workspace"
CPPUNIT_REQUIRED="test"
inherit kde4-meta

DESCRIPTION="KDE control module for Solid actions"
HOMEPAGE="http://solid.kde.org"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep solid-runtime)
	!kde-base/solid:4
"
