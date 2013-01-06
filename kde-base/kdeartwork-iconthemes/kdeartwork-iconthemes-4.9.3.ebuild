# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-iconthemes/kdeartwork-iconthemes-4.9.3.ebuild,v 1.4 2012/11/30 15:34:25 ago Exp $

EAPI=4

KMNAME="kdeartwork"
KMMODULE="IconThemes"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Icon themes for kde"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

# Provides nuvola icon theme
RDEPEND="
	!x11-themes/nuvola
"

# Moved here in 4.7
add_blocker kdeaccessibility-iconthemes
