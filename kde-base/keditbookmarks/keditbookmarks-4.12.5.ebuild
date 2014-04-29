# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/keditbookmarks/keditbookmarks-4.12.5.ebuild,v 1.1 2014/04/29 18:35:00 johu Exp $

EAPI=5

KMNAME="kde-baseapps"
VIRTUALX_REQUIRED="test"
inherit kde4-meta

DESCRIPTION="KDE's bookmarks editor"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	lib/konq/
"
