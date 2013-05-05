# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-iconthemes/kdeartwork-iconthemes-4.10.2.ebuild,v 1.5 2013/05/05 10:14:35 ago Exp $

EAPI=5

KMNAME="kdeartwork"
KMMODULE="IconThemes"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Icon themes for kde"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

# Provides nuvola icon theme
RDEPEND="
	!x11-themes/nuvola
"

# Moved here in 4.7
add_blocker kdeaccessibility-iconthemes
