# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solid-actions-kcm/solid-actions-kcm-4.11.10.ebuild,v 1.1 2014/06/15 17:24:02 kensington Exp $

EAPI=5

KMNAME="kde-workspace"
CPPUNIT_REQUIRED="test"
inherit kde4-meta

DESCRIPTION="KDE control module for Solid actions"
HOMEPAGE="http://solid.kde.org"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep solid-runtime)
	!kde-base/solid:4
"
