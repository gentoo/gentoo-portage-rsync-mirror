# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/keditbookmarks/keditbookmarks-4.11.5.ebuild,v 1.2 2014/01/20 08:00:35 kensington Exp $

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
